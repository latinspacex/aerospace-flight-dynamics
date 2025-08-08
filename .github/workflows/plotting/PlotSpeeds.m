function PlotSpeeds(t, S, C)
% Generates the 3x1 subplot for Relative Speed, Ground Speed, and Dynamic Pressure.

    n = numel(t);
    relative_speed_ms = zeros(1,n);
    ground_speed_ms = zeros(1,n);
    dynamic_pressure_kpa = zeros(1,n);

    for k = 1:n
        Rcggs = S(1:3, k);
        Vcggs = S(4:6, k);
        relative_speed_ms(k) = norm(Vcggs);
        Rcge = C.Rgse + Rcggs;
        Vcge = C.Vgse + cross(C.We, Rcggs) + Vcggs;
        ground_speed_ms(k) = norm(Vcge(1:2));
        Vatm = cross(C.We, Rcge);
        Vinf = Vcge - Vatm;
        vinf = norm(Vinf);
        [~,~,rho] = StandardAtmosphere(norm(Rcge) - C.Re);
        dynamic_pressure_kpa(k) = (0.5 * rho * vinf^2) / 1000;
    end

    figure('Color','w', 'Name','Speeds and Pressure', 'NumberTitle','Off');

    % --- Subplot 1: Relative Speed ---
    ax1 = subplot(3,1,1);
    plot(ax1, t, relative_speed_ms, '.k');
    grid on;
    th1 = title(ax1, 'Relative');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Speed (m/s)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 2: Ground Speed ---
    ax2 = subplot(3,1,2);
    plot(ax2, t, ground_speed_ms, '.k');
    grid on;
    th2 = title(ax2, 'Ground');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Speed (m/s)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 3: Dynamic Pressure ---
    ax3 = subplot(3,1,3);
    plot(ax3, t, dynamic_pressure_kpa, '.k');
    grid on;
    th3 = title(ax3, 'Dynamic');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Pressure (kPa)');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end