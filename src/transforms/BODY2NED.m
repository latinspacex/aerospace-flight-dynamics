function T = BODY2NED(roll, pitch, yaw)
%BODY2NED  Transformation from body frame to NED frame
%   T = body2ned(roll, pitch, yaw) returns the 3×3 matrix such that
%       r_ned = T * r_body
%   Inputs:
%     roll, pitch, yaw as in ned2body

    % simply transpose the forward rotation
    T_n2b = NED2BODY(roll, pitch, yaw).';

    T = T_n2b.';
end
