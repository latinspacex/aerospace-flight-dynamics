function PlotVelocity(t, Vcggs)
% Generates the 3x1 subplot for Eastern, Northern, and Zenith speed components.

    figure('Color','w', 'Name','Velocity', 'NumberTitle','Off');
    
    % --- Subplot 1: East Speed ---
    ax1 = subplot(3,1,1);
    plot(ax1, t, Vcggs(1,:), '.k');
    grid on;
    th1 = title(ax1, 'East');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Speed (m/s)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 2: North Speed ---
    ax2 = subplot(3,1,2);
    plot(ax2, t, Vcggs(2,:), '.k');
    grid on;
    th2 = title(ax2, 'North');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Speed (m/s)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 3: Zenith Speed ---
    ax3 = subplot(3,1,3);
    plot(ax3, t, Vcggs(3,:), '.k');
    grid on;
    th3 = title(ax3, 'Zenith');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Speed (m/s)');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end