function PlotAzEl(t, Rcggs)
% Generates the 2x1 subplot for Azimuth and Elevation.

    n = numel(t);
    az = zeros(1,n);
    el = zeros(1,n);

    for k = 1:n
        E = Rcggs(1,k); N = Rcggs(2,k); Z = Rcggs(3,k);
        az(k) = atan2d(E, N);
        el(k) = asind(Z / norm([E;N;Z]));
    end

    figure('Color','w', 'Name','AzimuthElevation', 'NumberTitle','Off');

    % --- Subplot 1: Azimuth ---
    ax1 = subplot(2,1,1);
    plot(ax1, t, az, '.k');
    grid on;
    th1 = title(ax1, 'Azimuth');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Azimuth (°)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 2: Elevation ---
    ax2 = subplot(2,1,2);
    plot(ax2, t, el, '.k');
    grid on;
    th2 = title(ax2, 'Elevation');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Elevation (°)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end