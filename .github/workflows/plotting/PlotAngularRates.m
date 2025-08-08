function PlotAngularRates(t,S)
% Generates the 2x2 subplot for rotational velocity.

    omega_dps = rad2deg(S(11:13,:));

    figure('Color','w','Name','AngularRates', 'NumberTitle','Off');

    % --- Subplot 1 ---
    ax1 = subplot(2,2,1);
    plot(ax1, t, omega_dps(1,:),'.k');
    grid on;
    th1 = title(ax1, 'Body-X');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, '\omega_x (°/s)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 2 ---
    ax2 = subplot(2,2,2);
    plot(ax2, t, omega_dps(2,:),'.k');
    grid on;
    th2 = title(ax2, 'Body-Y');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, '\omega_y (°/s)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 3 ---
    ax3 = subplot(2,2,3);
    plot(ax3, t, omega_dps(3,:),'.k');
    grid on;
    th3 = title(ax3, 'Body-Z');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, '\omega_z (°/s)');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 4 ---
    ax4 = subplot(2,2,4);
    omega_mag_dps = vecnorm(omega_dps);
    plot(ax4, t, omega_mag_dps,'.k');
    grid on;
    th4 = title(ax4, 'Total');
    xh4 = xlabel(ax4, 'Time (s)');
    yh4 = ylabel(ax4, '\omega (°/s)');
    set(th4, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax4, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end