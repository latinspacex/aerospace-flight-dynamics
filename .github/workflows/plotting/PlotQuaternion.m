function PlotQuaternion(t,S)
    
    q = S(7:10,:);
    
    figure('Color','w','Name','Quaternion Components');
    
    subplot(2,2,1);
    plot(t,q(1,:),'.k');
    title('Q_1','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Q_1','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
    subplot(2,2,2);
    plot(t,q(2,:),'.k');
    title('Q_2','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Q_2','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
    subplot(2,2,3);
    plot(t,q(3,:),'.k');
    title('Q_3','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Q_3','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
    subplot(2,2,4);
    plot(t,q(4,:),'.k');
    title('Q_4','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Q_4','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;

end