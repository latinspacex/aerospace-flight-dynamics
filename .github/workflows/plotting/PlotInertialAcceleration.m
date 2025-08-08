function PlotInertialAcceleration(t, S, C)
% Generates the 2x2 subplot for inertial acceleration.

    n = numel(t);
    a_body_gs = zeros(3, n);
    a_inertial_gs = zeros(1, n);

    for k = 1:n
        Rcggs = S(1:3, k);
        Vcggs = S(4:6, k);
        q = S(7:10, k);
        Rcge = C.Rgse + Rcggs;
        Vcge = C.Vgse + cross(C.We, Rcggs) + Vcggs;
        Vatm = cross(C.We, Rcge);
        Vinf_enz = Vcge - Vatm;
        vinf = norm(Vinf_enz);
        [~,~,rho] = StandardAtmosphere(norm(Rcge) - C.Re);
        g_enz = -C.Gm * Rcge / norm(Rcge)^3;
        Fd_enz = -0.5 * C.Cd * rho * C.acg * vinf * Vinf_enz;
        a_inert_enz = Fd_enz / C.mcg + g_enz;
        
        qw=q(1); qx=q(2); qy=q(3); qz=q(4);
        T_enz2bod = [ 1-2*(qy^2+qz^2), 2*(qx*qy+qw*qz), 2*(qx*qz-qw*qy);
                      2*(qx*qy-qw*qz), 1-2*(qx^2+qy^2), 2*(qy*qz+qw*qx);
                      2*(qx*qz+qw*qy), 2*(qy*qz-qw*qx), 1-2*(qx^2+qy^2) ];
        a_inert_bod = T_enz2bod * a_inert_enz;
        
        a_body_gs(:, k) = a_inert_bod / C.g;
        a_inertial_gs(k) = norm(a_inert_enz) / C.g;
    end

    figure('Color','w', 'Name','Acceleration', 'NumberTitle','Off');

    % --- Subplot 1 ---
    ax1 = subplot(2,2,1);
    plot(ax1, t, a_body_gs(1,:), '.k');
    grid on;
    th1 = title(ax1, 'Body-X');
    xh1 = xlabel(ax1, 'Time (s)');
    yh1 = ylabel(ax1, 'Acceleration (g''s)');
    set(th1, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh1, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax1, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 2 ---
    ax2 = subplot(2,2,2);
    plot(ax2, t, a_body_gs(2,:), '.k');
    grid on;
    th2 = title(ax2, 'Body-Y');
    xh2 = xlabel(ax2, 'Time (s)');
    yh2 = ylabel(ax2, 'Acceleration (g''s)');
    set(th2, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh2, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax2, 'FontName','Arial','FontSize',8,'FontWeight','bold');

    % --- Subplot 3 ---
    ax3 = subplot(2,2,3);
    plot(ax3, t, a_body_gs(3,:), '.k');
    grid on;
    th3 = title(ax3, 'Body-Z');
    xh3 = xlabel(ax3, 'Time (s)');
    yh3 = ylabel(ax3, 'Acceleration (g''s)');
    set(th3, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh3, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax3, 'FontName','Arial','FontSize',8,'FontWeight','bold');
    
    % --- Subplot 4 ---
    ax4 = subplot(2,2,4);
    plot(ax4, t, a_inertial_gs, '.k');
    grid on;
    th4 = title(ax4, 'Inertial');
    xh4 = xlabel(ax4, 'Time (s)');
    yh4 = ylabel(ax4, 'Acceleration (g''s)');
    set(th4, 'FontName','Arial','FontSize',16,'FontWeight','bold');
    set(xh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(yh4, 'FontName','Arial','FontSize',12,'FontWeight','bold');
    set(ax4, 'FontName','Arial','FontSize',8,'FontWeight','bold');
end