function S = jpattern(~)
% Provides the sparsity pattern of the Jacobian matrix.
% A '1' indicates a non-zero element, giving the solver a "map" of the
% system's dependencies to improve performance on stiff problems.
    
    % For maximum robustness, assume a fully dense Jacobian.
    % The solver is efficient at handling this.
    S = sparse(ones(13,13));

end