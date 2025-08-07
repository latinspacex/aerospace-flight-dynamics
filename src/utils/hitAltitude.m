function [value,isterminal,direction] = hitAltitude(t,S,C)
% Stops integration when altitude above mean equator returns to C.hgs (185 m)
%
% Inputs:
%   t – current time (unused)
%   S – state vector [Rcggs; Vcggs]
%   C – constants struct
    Rcggs = S(1:3);
    Rcge  = C.Rgse + Rcggs;
    hcg   = norm(Rcge) - C.Re;       % current altitude above mean equator
    value      = hcg - C.hgs;        % zero when hcg == C.hgs
    isterminal = 1;                  % stop the solver
    direction  = -1;                 % only trigger when descending through C.hgs
end
