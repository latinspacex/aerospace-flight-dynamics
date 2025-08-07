function dSdt = ProjectileMotionEom(~,S,C)

    Rcggs = S(1:3);
    % [m]Projectile position WRT the ground station in ENZ coordinates.

    Vcggs = S(4:6);
    % [m/s]Projectile velocity WRT the gorund station in ENZ coordinates.

    q = S(7:10);
    % [–] quaternion body→ENZ

    qw = q(1); qx = q(2); qy = q(3); qz = q(4);

    omega  = S(11:13);      
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

    ned2bod = [ ...
                qw^2+qx^2-qy^2-qz^2,     2*(qx*qy+qw*qz),       2*(qx*qz-qw*qy); ... 
                2*(qx*qy-qw*qz),       qw^2-qx^2+qy^2-qz^2,     2*(qy*qz+qw*qx); ...
                2*(qx*qz+qw*qy),         2*(qy*qz-qw*qx),     qw^2-qx^2-qy^2+qz^2 ];

    roll  = atan2( C_ned2bod(2,3), C_ned2bod(3,3) );
    pitch = asin( -C_ned2bod(1,3) );
    yaw   = atan2( C_ned2bod(1,2), C_ned2bod(1,1) );
 

    %----------------------------------------------------------------------
    % FORCES

    Fd = -0.5 * C.Cd * rho * C.acg * vinf * Vinf;
    % [N]Drag force in ENZ coordinates

    Fm = 0.5 * C.Cl * rho * C.acg * vinf^2 * (cross(C.We,Vcge)/norm(cross(C.We,Vcge)));
    % []Magnus force in ENZ coordinates.

    Fm = 

    g = -C.Gm * Rcge / rcge^3;
    % [m/s^2]Acceleration due to gravity in ENZ coordinates.

    %----------------------------------------------------------------------
    % MOMENTS

    Rcpcg = [-e3; 0; 0];
    % [m]Postion of center of pressure WRT center of gravity in body coordinates.

    Md = cross(Rcpcg,)


    %----------------------------------------------------------------------

    dSdt = zeros(6,1);
    % []Allocates memory for the state vector derivative.

    dSdt(1:3) = Vcggs;
    % [m/s]Vehicle velocity WRT the ground station in ENZ coordinates.

    dSdt(4:6) = Fd / C.mcg + g - C.Agse - cross(C.We,cross(C.We,Rcggs)) - 2 * cross(C.We,Vcggs);
    % [m/s^2]Vehicle acceleration WRT the ground station in ENZ coordinates.

end
%==========================================================================