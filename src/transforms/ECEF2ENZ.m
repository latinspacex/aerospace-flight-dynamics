function T = ECEF2ENZ(phi, lambda)
%ECEF2ENZ  Transformation matrix from ECEF frame to ENZ frame
%   T = ecef2enz(phi, lambda) returns the 3×3 matrix such that
%       r_enz = T * r_ecef
%   Inputs:
%     phi    – latitude of the ENZ origin (rad)
%     lambda – longitude of the ENZ origin (rad)

    % build the forward ENZ→ECEF and then transpose
    T_e2n = ENZ2ECEF(phi, lambda);
    T = T_e2n.';
end
