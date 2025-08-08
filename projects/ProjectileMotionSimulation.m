tic;
% [s]Starts the program timer.

clc;
% []Clears the command window.

clear;
% []Clears the variable workspace.

format('Compact');
% []Formats the command window output to single-spaced output.

format('LongG');
% []Formats the command window output to display 16 digits for double-precision values.

close('All');
% []Closes all figures.

%% Load Simulation Parameters:

C = ConstantsEom;
% []Loads all of the simulation parameters.

v0 = 827;
% [m/s]Initial vehicle speed WRT to the ground station.

Vcggs0 = [v0 * cos(C.el) * sin(C.az); v0 * cos(C.el) * cos(C.az); v0 * sin(C.el)];
% [m/s]Initial vehicle velocity WRT the ground station in ENZ coordinates.

%% Numerical Integration:

to = [0, 200];
% [s]Modeling time.

S0 = [ C.Rcggs; Vcggs0; C.q0; C.omega0 ];
% [m,m/s]Initial vehicle state WRT the ground station in ENZ coordinates.

% --- Final, Most Robust ODE Options ---
opts = odeset( ...
    'RelTol',    1e-4, ... % A relaxed tolerance is essential for this problem
    'AbsTol',    1e-4, ...
    'Events',    @(t,S) hitAltitude(t,S,C), ...
    'OutputFcn', @odeProgressPlotter, ...
    'JPattern',  jpattern(C) ... % Provide the sparsity pattern for maximum stability
);

[t,S] = ode15s(@(t,S) ProjectileMotionEom(t,S,C), to, S0, opts);
S = S.';
t = t.';

%% Plot Results:

fprintf('Simulation finished. Now generating plots...\n');

% --- Extract final data for plotting ---
Rcggs = S(1:3,:);
Vcggs = S(4:6,:);

% --- Call all plotting functions as specified by the assignment ---

% Figure 1: Altitude, Linear Range, Haversine Range
PlotAltitude(t,Rcggs,C);

% Figure 2: Relative Speed, Ground Speed, Dynamic Pressure
PlotSpeeds(t, S, C);

% Figure 3: East, North, Zenith Displacements
PlotDisplacements(t, Rcggs);

% Figure 4: East, North, Zenith Speeds
PlotVelocity(t, Vcggs);

% Figure 5: Body-Frame and Inertial Acceleration
PlotInertialAcceleration(t, S, C);

% Figure 6: Azimuth and Elevation
PlotAzEl(t, Rcggs);

% Figure 7: Roll, Pitch, and Yaw Angles
PlotRollPitchYaw(t,S);

% Figure 8: Rotational Velocity Components and Magnitude
PlotAngularRates(t,S);

% Figure 9: Quaternion Components
PlotQuaternion(t,S);

% --- Bonus: 3D Trajectory Plot ---
Plot3DTrajectory(t, Rcggs);

fprintf('All plots have been generated.\n');

%% Print Simulation Time:

SimulationTime = toc;
% [s]Stops the program timer.

SimulationTimeString = 'Total Simulation and Plotting Time: (%0.3f seconds)\n';
% []Formatted string.

fprintf(SimulationTimeString,SimulationTime);
% []Prints the simulation time on the command window.