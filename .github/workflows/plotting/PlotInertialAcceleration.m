function PlotInertialAcceleration(t, Rcggs, Vcggs, C)

    n = numel(t);
    ags = zeros(1,n);

    for k = 1:n
        Rcge = C.Rgse + Rcggs(:,k);
        g_vec = -C.Gm * Rcge / norm(Rcge)^3;
        Vcge = C.Vgse + cross(C.We, Rcggs(:,k)) + Vcggs(:,k);
        Vatm = cross(C.We, Rcge);
        Vinf = Vcge - Vatm;
        vinf = norm(Vinf);
        [~,~,rho] = StandardAtmosphere(norm(Rcge)-C.Re);
        Fd = -0.5 * C.Cd * rho * C.acg * vinf * Vinf;
        a_inert = Fd/C.mcg + g_vec;
        ags(k) = norm(a_inert)/C.g;
    end

    figure('Color','w', 'Name','Inertial Acceleration', 'NumberTitle','Off');
    plot(t, ags, '.k');
    
    title('Inertial', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel("Acceleration (g's)", 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

end