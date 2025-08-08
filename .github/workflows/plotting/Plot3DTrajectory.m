function Plot3DTrajectory(t, Rcggs)
% Generates a 3D plot of the projectile's trajectory.
%
%   Inputs:
%       t       - Time vector
%       Rcggs   - Position history in ENZ coordinates (m)

    % Convert positions from meters to kilometers for better scaling
    pos_km = Rcggs / 1000;
    
    % --- Create the Figure ---
    figure('Color','w', 'Name','3D Trajectory', 'NumberTitle','Off');
    
    % --- Create the 3D Plot ---
    % Plot the main trajectory line
    plot3(pos_km(1,:), pos_km(2,:), pos_km(3,:), 'b-', 'LineWidth', 2);
    hold on; % Hold the plot to add more elements
    
    % Add a marker for the starting point
    plot3(pos_km(1,1), pos_km(2,1), pos_km(3,1), 'go', ...
        'MarkerFaceColor', 'g', 'MarkerSize', 10);
        
    % Add a marker for the ending point
    plot3(pos_km(1,end), pos_km(2,end), pos_km(3,end), 'rs', ...
        'MarkerFaceColor', 'r', 'MarkerSize', 10);
        
    hold off; % Release the plot
    
    % --- Formatting ---
    title('Projectile 3D Trajectory', 'FontName','Arial', 'FontSize',18, 'FontWeight','Bold');
    xlabel('East Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('North Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    zlabel('Zenith Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    
    legend('Trajectory', 'Launch Point', 'Impact Point', 'Location', 'best');
    grid on;
    axis equal; % Ensures the scaling is the same on all axes for a true-to-life view
    view(3);    % Set the default view to 3D
    rotate3d on;% Allow interactive rotation with the mouse
    
    fprintf('3D trajectory plot generated. You can click and drag to rotate the view.\n');

end