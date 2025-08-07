function PlotAngularRates(t,S)

    omega = rad2deg(S(11:13,:));
    
    figure('Color','w','Name','Angular Rates');
    
    subplot(2,2,1);
    plot(t,omega(1,:),'.k');
    title('Body-X','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('\omega_x (°/s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;

    subplot(2,2,2);
    plot(t,omega(2,:),'.k');
    title('Body-Y','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('\omega_y (°/s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;

    subplot(2,2,3);
    plot(t,omega(3,:),'.k');
    title('Body-Z','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('\omega_z (°/s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
    omega_mag = zeros(1,length(t));
    for k = 1:length(t)
        omega_mag(k) = norm(omega(:,k));
    end
    
    subplot(2,2,4);
    plot(t,omega_mag,'.k');
    title('Total','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('\omega (°/s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
end