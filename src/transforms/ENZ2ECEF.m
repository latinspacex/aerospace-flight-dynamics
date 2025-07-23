function T = ENZ2ECEF(phi, lambda)
%ENZ2ECEF  Transformation matrix from ENZ frame to ECEF frame
%   T = enz2ecef(phi, lambda) returns the 3×3 matrix such that
%       r_ecef = T * r_enz
%   Inputs:
%     phi    – latitude of the ENZ origin (rad)
%     lambda – longitude of the ENZ origin (rad)

    % precompute sines & cosines
    sphi = sin(phi);
    cphi = cos(phi);
    slam = sin(lambda);
    clam = cos(lambda);

    % this is the transpose of T^{enz}_{ecef} from the notes
    T = [ ...
        -slam,                  -sphi*clam,            cphi*clam; 
         clam,                  -sphi*slam,            cphi*slam;
         0,                       cphi,                sphi    ];
end
