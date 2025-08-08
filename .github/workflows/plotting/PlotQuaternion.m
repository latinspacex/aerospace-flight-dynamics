function PlotQuaternion(t,S)
% Generates the 2x2 subplot for the four quaternion components.

    q = S(7:10,:);

    figure('Color','w','Name','Quaternion', 'NumberTitle','Off');

    % --- Subplot 1 ---
    ax1 = subplot(2,2,1);
    plot(ax1, t, q(1,:),'.k');
    grid on;
    th1 = title(ax1, 'Q_1');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Q_1');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 2 ---
    ax2 = subplot(2,2,2);
    plot(ax2, t, q(2,:),'.k');
    grid on;
    th2 = title(ax2, 'Q_2');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Q_2');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 3 ---
    ax3 = subplot(2,2,3);
    plot(ax3, t, q(3,:),'.k');
    grid on;
    th3 = title(ax3, 'Q_3');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Q_3');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 4 ---
    ax4 = subplot(2,2,4);
    plot(ax4, t, q(4,:),'.k');
    grid on;
    th4 = title(ax4, 'Q_4');
    xh4 = xlabel(ax4, 'Time (s)');
    yh4 = ylabel(ax4, 'Q_4');
    set(th4, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax4, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end