function PlotAzEl(t, Rcggs)

    n = numel(t);
    az  = zeros(1,n);
    el  = zeros(1,n);
    
    for k = 1:n
        E = Rcggs(1,k);
        N = Rcggs(2,k);
        Z = Rcggs(3,k);
        az(k) = atan2d(E, N);
        el(k) = asind( Z / norm([E;N;Z]) );
    end

    figure('Color','w', 'Name','Azimuth & Elevation', 'NumberTitle','Off');

    % --- Azimuth ---
    subplot(2,1,1);
    plot(t, az, '.k');
    title('Azimuth', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Azimuth (°)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

    % --- Elevation ---
    subplot(2,1,2);
    plot(t, el, '.k');
    title('Elevation', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Elevation (°)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

end