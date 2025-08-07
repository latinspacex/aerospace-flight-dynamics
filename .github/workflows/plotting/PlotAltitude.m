function PlotAltitude(t,Rcggs,C)

    n = numel(t);
    hcg = zeros(1,n);

    for k = 1:n
        Rcge = C.Rgse + Rcggs(:,k);
        hcg(k) = norm(Rcge) - C.Re;
    end

    figure('Color','w', 'Name','Altitude Above Mean Equator', 'NumberTitle','Off');
    plot(t,hcg/1000, '.k'); % Convert to km for the plot
    
    title('Altitude', 'FontName','Arial', 'FontSize',16, 'FontWeight','Bold');
    xlabel('Time (s)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    ylabel('Altitude (km)', 'FontName','Arial', 'FontSize',12, 'FontWeight','Bold');
    grid on;
    set(gca, 'FontName','Arial', 'FontSize',8, 'FontWeight','Bold');

end