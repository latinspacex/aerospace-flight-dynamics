function dSdt = ProjectileMotionEom(~,S,C)

    Rcggs = S(1:3);
    % [m]Projectile position WRT the ground station in ENZ coordinates.

    Vcggs = S(4:6);
    % [m/s]Projectile velocity WRT the gorund station in ENZ coordinates.

    q = S(7:10);
    % [–] quaternion body→ENZ

    omega_bod = S(11:13);
    % [rad/s] body‐rates

    %----------------------------------------------------------------------

    Rcge = C.Rgse + Rcggs;
    % [m]Projectile position WRT the Earth in ENZ coordinates.

    Vcge = C.Vgse + cross(C.We,Rcggs) + Vcggs;
    % [m/s]Vehicle velocity WRT the Earth in ENZ coordinates.

    %----------------------------------------------------------------------

    Vatm = cross(C.We,Rcge);
    % [m/s]Velocity of the atmosphere WRT Earth in ENZ coordinates.

    Vinf = Vcge - Vatm;
    % [m/s]Vehicle true air velocity in ENZ coordinates.

    vinf = norm(Vinf);
    % [m/s]Vehicle true air speed.

    rcge = norm(Rcge);
    % [m]Vehicle range WRT the Earth.

    hcg = rcge - C.Re;
    % [m]Vehicle altitude above mean equator.

    [~,~,rho] = StandardAtmosphere(hcg);
    % [kg/m^3]Atmospheric density.

    %----------------------------------------------------------------------

    qw = q(1); qx = q(2); qy = q(3); qz = q(4);
    T_bod2enz = [ ...
        1-2*(qy^2+qz^2),   2*(qx*qy-qw*qz),   2*(qx*qz+qw*qy); ...
        2*(qx*qy+qw*qz),   1-2*(qx^2+qz^2),   2*(qy*qz-qw*qx); ...
        2*(qx*qz-qw*qy),   2*(qy*qz+qw*qx),   1-2*(qx^2+qy^2)  ...
    ];
    T_enz2bod = T_bod2enz.';

    %----------------------------------------------------------------------
    % FORCES

    Fd_enz = -0.5 * C.Cd * rho * C.acg * vinf * Vinf;
    % [N]Drag force in ENZ coordinates

    omega_rel_air_bod = omega_bod - T_enz2bod*C.We;
    omega_rel_air_enz = T_bod2enz * omega_rel_air_bod;

    magnus_direction_vec = cross(omega_rel_air_enz, Vinf);
    if norm(magnus_direction_vec) > 1e-9
        magnus_unit_vec = magnus_direction_vec / norm(magnus_direction_vec);
    else
        magnus_unit_vec = [0; 0; 0];
    end

    Fm_enz = 0.5 * C.Cl * rho * C.acg * vinf^2 * magnus_unit_vec;
    % [N] Magnus force in ENZ coordinates.

    g_enz = -C.Gm * Rcge / rcge^3;
    % [m/s^2]Acceleration due to gravity in ENZ coordinates.

    %----------------------------------------------------------------------
    % MOMENTS

    Fd_bod = T_enz2bod * Fd_enz;
    Fm_bod = T_enz2bod * Fm_enz;

    M_bod = cross(C.Rcpcg, Fd_bod) + cross(C.Rcpcg, Fm_bod);

    %----------------------------------------------------------------------

    dSdt = zeros(13,1);
    % []Allocates memory for the state vector derivative.

    dSdt(1:3) = Vcggs;
    % [m/s]Vehicle velocity WRT the ground station in ENZ coordinates.

    a_total_enz = (Fd_enz + Fm_enz) / C.mcg;

    dSdt(4:6) = a_total_enz + g_enz - C.Agse - cross(C.We,cross(C.We,Rcggs)) - 2 * cross(C.We,Vcggs);
    % [m/s^2]Vehicle acceleration WRT the ground station in ENZ coordinates.

    Omega_mat = [ 0,         -omega_bod(1), -omega_bod(2), -omega_bod(3);
                  omega_bod(1),  0,          omega_bod(3), -omega_bod(2);
                  omega_bod(2), -omega_bod(3),  0,          omega_bod(1);
                  omega_bod(3),  omega_bod(2), -omega_bod(1),  0 ];
    dSdt(7:10) = 0.5 * Omega_mat * q;

    dSdt(11:13) = C.Icg \ (M_bod - cross(omega_bod, C.Icg * omega_bod));

end