function T = NED2BODY(roll, pitch, yaw)
%NED2BODY  Transformation from NED frame to body frame (3-2-1 sequence)
%   T = ned2body(roll, pitch, yaw) returns the 3×3 matrix such that
%       r_body = T * r_ned
%   Inputs:
%     roll  – rotation about NED x-axis  (rad)  (ϕ)
%     pitch – rotation about intermediate y-axis (rad)  (θ)
%     yaw   – rotation about final z-axis   (rad)  (ψ)

    % Precompute sines & cosines
    cphi = cos(roll);    sphi = sin(roll);
    ctht = cos(pitch);   stht = sin(pitch);
    cpsi = cos(yaw);     spsi = sin(yaw);

    % elemental rotations (Eqns 2.6–2.8)
    R_x = [ 1,   0,    0;
            0,  cphi, -sphi;
            0,  sphi,  cphi ];

    R_y = [  ctht, 0, stht;
             0,  1,  0;
           -stht, 0, ctht ];

    R_z = [ cpsi, -spsi, 0;
            spsi,  cpsi, 0;
             0,   0, 1 ];

    % full NED→body = R_x * R_y * R_z
    T = R_x * R_y * R_z;
end
