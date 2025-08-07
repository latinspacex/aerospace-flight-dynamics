function J = ProjectileMotionJacobian(~, S, C)
% Computes the Jacobian matrix for the projectile motion equations.
% This function provides the solver with the system's sensitivity matrix,
% which is crucial for stabilizing stiff problems.

% Pre-allocate the 13x13 Jacobian matrix with zeros
J = zeros(13, 13);

% Unpack state variables for clarity
omega_bod = S(11:13);

% --- Row 1-3: d(Position)/dt with respect to Velocity ---
% The time derivative of position (dS(1:3)) is velocity (S(4:6)).
% So, the partial derivative of dS(1:3)/dt with respect to S(4:6) is eye(3).
J(1:3, 4:6) = eye(3);

% --- Row 11-13: d(Omega)/dt with respect to Omega ---
% This is the most critical part for stability. We provide the Jacobian for
% the rotational dynamics, specifically for the gyroscopic term, which is
% the primary source of the stiffness.

I = C.Icg;
ox = omega_bod(1);
oy = omega_bod(2);
oz = omega_bod(3);

% The gyroscopic torque is T_gyro = -cross(omega, I*omega)
% The Jacobian of this term with respect to omega is needed.

% Skew-symmetric matrix for omega
omega_skew = [  0, -oz,  oy;
               oz,   0, -ox;
              -oy,  ox,   0];

% First, calculate the vector I*omega
I_omega = I * omega_bod;

% Now, create the skew-symmetric matrix for the I_omega vector
I_omega_skew = [    0,      -I_omega(3),   I_omega(2);
                  I_omega(3),      0,      -I_omega(1);
                 -I_omega(2),   I_omega(1),      0      ];

% The Jacobian of the gyroscopic term is (I_omega_skew - omega_skew*I)
% We then left-divide by the inertia tensor I to get the effect on d(omega)/dt
J_rot = I \ (I_omega_skew - omega_skew * I);
J(11:13, 11:13) = J_rot;

% Note: A full analytical Jacobian is extremely complex. Providing the Jacobian
% for the dominant, stiffest terms (the gyroscopic ones) is usually
% sufficient to give the solver the "roadmap" it needs to be stable.

end