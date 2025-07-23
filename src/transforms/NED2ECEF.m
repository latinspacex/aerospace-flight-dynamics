function T = NED2ECEF(phi, lambda)
%NED2ECEF  Transformation matrix from NED to ECEF frame 
%   T = ned2ecef(phi, lambda) returns the 3×3 matrix such that
%       r_ecef = T * r_ned
%   Inputs:
%     phi    – geodetic latitude of the origin (rad)
%     lambda – geodetic longitude of the origin (rad)

    % build the forward ECEF→NED
    T_e2n = ECEF2NED(phi, lambda);
    
    % invert by transposition
    T = T_e2n.';
end
