function C = ConstantsEom
% Defines all physical and initial constants for the simulation.

    % --- Environmental Constants ---
    C.Gm = 3.98600435436E14; % [m^3/s^2] Gravitational parameter of the Earth
    C.Re = 6378137;          % [m] Mean equatorial radius of the Earth
    C.we = 7.292115e-5;      % [rad/s] Rotational speed of the Earth
    C.g  = 9.80665;          % [m/s^2] Standard gravity

    % --- Ground Station (AT&T Stadium) ---
    C.phigs = deg2rad(32 + 44/60 + 52/3600);    % [rad] Latitude
    C.lambdags = -deg2rad(97 + 5/60 + 34/3600); % [rad] Longitude
    C.hgs = 185;                               % [m] Altitude

    % --- Earth Frame Vectors in ENZ ---
    C.We = C.we * [0; cos(C.phigs); sin(C.phigs)];
    C.Rgse = (C.Re + C.hgs) * [0; 0; 1];
    C.Vgse = cross(C.We, C.Rgse);
    C.Agse = cross(C.We, C.Vgse);

    % --- Projectile Characteristics ---
    C.mcg = 35;                        % [kg] Mass
    C.Cl = 0.173;                      % [–] Magnus coefficient
    C.Cd = 0.820;                      % [–] Drag coefficient
    C.acg = 6006.25 * pi * 1e-6;       % [m^2] Reference area (mm^2 to m^2)
    C.Rcpcg = [-0.001; 0; 0];           % [m] CP wrt CG (mm to m)

    % --- Inertia Tensor (Corrected Signs per Standard Convention) ---
    Ixx = 0.0630656250;
    Iyy = 1.3440328125;
    Izz = 1.3440328125;
    Ixy = 0.1579431538;
    Ixz = 0.1579431538;
    Iyz = 0.1579431538;
    C.Icg = [ Ixx, -Ixy, -Ixz;
             -Ixy,  Iyy, -Iyz;
             -Ixz, -Iyz,  Izz ];

    % --- Initial Conditions ---
    C.az = deg2rad(107);
    C.el = deg2rad(45);
    C.q0 = [1; 0; 0; 0];
    C.omega0 = [0; 0; 0];
    C.Rcggs = [0; 0; 0];

end