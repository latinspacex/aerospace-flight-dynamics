function T = ECEF2NED(phi, lambda)
%ECEF2NED  Transformation matrix from ECEF to NED frame 
%   T = ecef2ned(phi, lambda) returns the 3×3 matrix such that
%       r_ned = T * r_ecef
%   Inputs:
%     phi    – geodetic latitude of the origin (rad)
%     lambda – geodetic longitude of the origin (rad)

    % precompute sines & cosines
    sphi = sin(phi);
    cphi = cos(phi);
    slam = sin(lambda);
    clam = cos(lambda);

    % eqn for T^ned_ecef from the lecture notes
    T = [ ...
      -sphi*clam,   -sphi*slam,    cphi; 
      -   slam,        clam,      0; 
      -cphi*clam,   -cphi*slam,   -sphi ];
end
