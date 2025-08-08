function PlotRollPitchYaw(t,S)
% Generates the 3x1 subplot for Roll, Pitch, and Yaw angles.

    n = numel(t);
    roll = zeros(1,n); pitch = zeros(1,n); yaw = zeros(1,n);

    for k=1:n
        q = S(7:10,k);
        qw = q(1); qx = q(2); qy = q(3); qz = q(4);
        
        sinr_cosp = 2 * (qw * qx + qy * qz);
        cosr_cosp = 1 - 2 * (qx^2 + qy^2);
        roll(k) = atan2d(sinr_cosp, cosr_cosp);

        sinp = 2 * (qw * qy - qz * qx);
        if abs(sinp) >= 1
            pitch(k) = copysign(90.0, sinp);
        else
            pitch(k) = asind(sinp);
        end

        siny_cosp = 2 * (qw * qz + qx * qy);
        cosy_cosp = 1 - 2 * (qy^2 + qz^2);
        yaw(k) = atan2d(siny_cosp, cosy_cosp);
    end

    figure('Color','w','Name','RollPitchYaw', 'NumberTitle','Off');

    % --- Subplot 1: Roll ---
    ax1 = subplot(3,1,1);
    plot(ax1, t,roll,'.k');
    grid on;
    th1 = title(ax1, 'Roll');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Roll (°)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 2: Pitch ---
    ax2 = subplot(3,1,2);
    plot(ax2, t,pitch,'.k');
    grid on;
    th2 = title(ax2, 'Pitch');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Pitch (°)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 3: Yaw ---
    ax3 = subplot(3,1,3);
    plot(ax3, t,yaw,'.k');
    grid on;
    th3 = title(ax3, 'Yaw');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Yaw (°)');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end