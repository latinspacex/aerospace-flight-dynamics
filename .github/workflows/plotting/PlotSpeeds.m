function PlotSpeeds(t, Vcggs)

    figure('Color','w', 'Name','Speeds', 'NumberTitle','Off');
    
    % --- East Speed ---
    subplot(3,1,1);
    plot(t, Vcggs(1,:), '.k');
    title('East', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Speed (m/s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

    % --- North Speed ---
    subplot(3,1,2);
    plot(t, Vcggs(2,:), '.k');
    title('North', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Speed (m/s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

    % --- Zenith Speed ---
    subplot(3,1,3);
    plot(t, Vcggs(3,:), '.k');
    title('Zenith', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Speed (m/s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');
    
end