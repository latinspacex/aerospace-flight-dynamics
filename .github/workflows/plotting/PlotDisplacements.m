function PlotDisplacements(t, Rcggs)

    figure('Color','w', 'Name','Displacements', 'NumberTitle','Off');
    
    % --- East Displacement ---
    subplot(3,1,1);
    plot(t, Rcggs(1,:)/1000, '.k'); % Convert to km
    title('East', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

    % --- North Displacement ---
    subplot(3,1,2);
    plot(t, Rcggs(2,:)/1000, '.k'); % Convert to km
    title('North', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');
    
    % --- Zenith Displacement ---
    subplot(3,1,3);
    plot(t, Rcggs(3,:)/1000, '.k'); % Convert to km
    title('Zenith', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Displacement (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

end