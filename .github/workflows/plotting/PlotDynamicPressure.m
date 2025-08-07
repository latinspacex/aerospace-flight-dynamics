function PlotDynamicPressure(t, Rcggs, Vcggs, C)

    n = numel(t);
    qkPa = zeros(1,n);

    for k = 1:n
        Rcge = C.Rgse + Rcggs(:,k);
        h    = norm(Rcge) - C.Re;
        [~,~,rho] = StandardAtmosphere(h);
        Vcge = C.Vgse + cross(C.We, Rcggs(:,k)) + Vcggs(:,k);
        Vatm  = cross(C.We, Rcge);
        Vinf  = Vcge - Vatm;
        qkPa(k) = 0.5 * rho * norm(Vinf)^2 / 1e3;
    end

    figure('Color','w', 'Name','Dynamic Pressure', 'NumberTitle','Off');
    plot(t, qkPa, '.k');
    
    title('Dynamic', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Pressure (kPa)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');
    
end