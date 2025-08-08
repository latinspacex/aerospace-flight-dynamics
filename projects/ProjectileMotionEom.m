function dSdt = ProjectileMotionEom(~, S, C)
% Final, numerically stable version of the equations of motion.

% --- Unpack State Vector ---
Rcggs=S(1:3); Vcggs=S(4:6); q=S(7:10); omega_bod=S(11:13);

% --- Coordinate Transformations ---
qw=q(1); qx=q(2); qy=q(3); qz=q(4);
T_bod2enz = [1-2*(qy^2+qz^2), 2*(qx*qy-qw*qz), 2*(qx*qz+qw*qy);
             2*(qx*qy+qw*qz), 1-2*(qx^2+qz^2), 2*(qy*qz-qw*qx);
             2*(qx*qz-qw*qy), 2*(qy*qz+qw*qx), 1-2*(qx^2+qy^2)];
T_enz2bod = T_bod2enz.';

% --- Kinematics ---
Rcge = C.Rgse + Rcggs;
Vcge = C.Vgse + cross(C.We, Rcggs) + Vcggs;
Vatm = cross(C.We, Rcge);
Vinf_enz = Vcge - Vatm;
vinf = norm(Vinf_enz);

% --- Environment ---
rcge = norm(Rcge);
hcg = rcge - C.Re;
[~,~,rho] = StandardAtmosphere(hcg);

% --- Forces ---
g_enz = -C.Gm * Rcge / rcge^3;
Fd_enz = -0.5 * C.Cd * rho * C.acg * vinf * Vinf_enz;
omega_rel_air_bod = omega_bod - T_enz2bod * C.We;
omega_rel_air_enz = T_bod2enz * omega_rel_air_bod;
magnus_cross_prod = cross(omega_rel_air_enz, Vinf_enz);
norm_magnus_cross = norm(magnus_cross_prod);
if norm_magnus_cross > 1e-10
    Fm_enz = 0.5 * C.Cl * rho * C.acg * vinf^2 * (magnus_cross_prod / norm_magnus_cross);
else
    Fm_enz = [0; 0; 0];
end

% --- Moments ---
M_bod = cross(C.Rcpcg, T_enz2bod * (Fd_enz + Fm_enz));

% --- Assemble State Derivatives ---
dSdt = zeros(13,1);
dSdt(1:3) = Vcggs;
dSdt(4:6) = (Fd_enz + Fm_enz)/C.mcg + g_enz - C.Agse - cross(C.We,cross(C.We,Rcggs)) - 2*cross(C.We,Vcggs);
Omega_mat = [0,-omega_bod(1),-omega_bod(2),-omega_bod(3);
             omega_bod(1),0,omega_bod(3),-omega_bod(2);
             omega_bod(2),-omega_bod(3),0,omega_bod(1);
             omega_bod(3),omega_bod(2),-omega_bod(1),0];
dSdt(7:10) = 0.5 * Omega_mat * q;
dSdt(11:13) = C.Icg \ (M_bod - cross(omega_bod, C.Icg * omega_bod));
end