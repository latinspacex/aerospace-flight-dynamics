function PlotAltitude(t, Rcggs, C)
% Generates the 3x1 subplot for Altitude, Linear Range, and Haversine Range
% using direct handle graphics for robust bold formatting.

    n = numel(t);
    altitude_km = zeros(1,n);
    linear_range_km = zeros(1,n);
    haversine_range_km = zeros(1,n);
    phi_gs = C.phigs;
    lambda_gs = C.lambdags;

    for k = 1:n
        Rcge = C.Rgse + Rcggs(:,k);
        altitude_km(k) = (norm(Rcge) - C.Re) / 1000;
        linear_range_km(k) = norm(Rcggs(1:2, k)) / 1000;
        Rcge_ecef = ENZ2ECEF(phi_gs, lambda_gs) * Rcge;
        x = Rcge_ecef(1); y = Rcge_ecef(2); z = Rcge_ecef(3);
        phi_cg = atan2(z, sqrt(x^2 + y^2));
        lambda_cg = atan2(y, x);
        dPhi = phi_cg - phi_gs;
        dLambda = lambda_cg - lambda_gs;
        a = sin(dPhi/2)^2 + cos(phi_gs) * cos(phi_cg) * sin(dLambda/2)^2;
        c = 2 * atan2(sqrt(a), sqrt(1-a));
        haversine_range_km(k) = (C.Re * c) / 1000;
    end
    
    figure('Color','w', 'Name','Displacement', 'NumberTitle','Off');

    % --- Subplot 1: Altitude ---
    ax1 = subplot(3,1,1);
    plot(ax1, t, altitude_km, '.k');
    grid on;
    % Get handles to text objects
    th1 = title(ax1, 'Altitude');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Altitude (km)');
    % Set properties directly on handles
    set(th1, 'FontName', 'Arial', 'FontSize', 16, 'FontWeight', 'bold');
    set(xh1, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(yh1, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(ax1, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'bold');

    % --- Subplot 2: Linear Range ---
    ax2 = subplot(3,1,2);
    plot(ax2, t, linear_range_km, '.k');
    grid on;
    % Get handles to text objects
    th2 = title(ax2, 'Linear');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Range (km)');
    % Set properties directly on handles
    set(th2, 'FontName', 'Arial', 'FontSize', 16, 'FontWeight', 'bold');
    set(xh2, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(yh2, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(ax2, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'bold');

    % --- Subplot 3: Haversine Range ---
    ax3 = subplot(3,1,3);
    plot(ax3, t, haversine_range_km, '.k');
    grid on;
    % Get handles to text objects
    th3 = title(ax3, 'Haversine');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Range (km)');
    % Set properties directly on handles
    set(th3, 'FontName', 'Arial', 'FontSize', 16, 'FontWeight', 'bold');
    set(xh3, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(yh3, 'FontName', 'Arial', 'FontSize', 12, 'FontWeight', 'bold');
    set(ax3, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'bold');
end