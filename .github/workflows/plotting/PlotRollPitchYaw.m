function PlotRollPitchYaw(t,S)
    
    n = numel(t);
    roll = zeros(1,n);
    pitch = zeros(1,n);
    yaw = zeros(1,n);

    for k=1:n
        q = S(7:10,k);
        qw = q(1);
        qx = q(2);
        qy = q(3);
        qz = q(4);
        
        T_bod2ned = [ ...
            1-2*(qy^2+qz^2),   2*(qx*qy-qw*qz),   2*(qx*qz+qw*qy); ...
            2*(qx*qy+qw*qz),   1-2*(qx^2+qz^2),   2*(qy*qz-qw*qx); ...
            2*(qx*qz-qw*qy),   2*(qy*qz+qw*qx),   1-2*(qx^2+qy^2) ...
        ];

        roll(k)  = atan2( T_bod2ned(2,3), T_bod2ned(3,3) );
        pitch(k) = asin( -T_bod2ned(1,3) );
        yaw(k)   = atan2( T_bod2ned(1,2), T_bod2ned(1,1) );
    end

    roll = rad2deg(roll);
    pitch = rad2deg(pitch);
    yaw = rad2deg(yaw);

    figure('Color','w','Name','Roll, Pitch, & Yaw Angles');
    subplot(3,1,1);
    plot(t,roll,'.k');
    title('Roll','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Roll (°)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;
    
    subplot(3,1,2);
    plot(t,pitch,'.k');
    title('Pitch','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Pitch (°)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;

    subplot(3,1,3);
    plot(t,yaw,'.k');
    title('Yaw','FontName','Arial','FontSize',16,'FontWeight','Bold');
    xlabel('Time (s)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    ylabel('Yaw (°)','FontName','Arial','FontSize',12,'FontWeight','Bold');
    grid on;

end