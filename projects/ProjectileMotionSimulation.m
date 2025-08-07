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

to = [0,200];
% [s]Modeling time.

S0 = [ C.Rcggs; Vcggs0; C.q0; C.omega0 ];
% [m,m/s]Initial vehicle state WRT the ground station in ENZ coordinates.

% --- Final ODE options with correctly passed Jacobian ---
opts = odeset( ...
    'RelTol',    1E-5, ...
    'AbsTol',    1e-5, ...
    'Events',    @(t,S) hitAltitude(t,S,C), ...
    'OutputFcn', @odeProgressPlotter, ...
    'Jacobian',  @(t,S) ProjectileMotionJacobian(t,S,C) ... % <-- FINAL CORRECTION
);

[t,S] = ode15s(@(t,S) ProjectileMotionEom(t,S,C), to, S0, opts);
S = S.';
t = t.';

%% Plot Results:

fprintf('Simulation finished. Now generating plots...\n');

% --- Extract final data for plotting ---
Rcggs = S(1:3,:);
Vcggs = S(4:6,:);

% --- Call all plotting functions ---
PlotAltitude(t,Rcggs,C);
PlotDisplacements(t,Rcggs);
PlotSpeeds(t, Vcggs);
PlotAzEl(t, Rcggs);
PlotInertialAcceleration(t, Rcggs, Vcggs, C);
PlotDynamicPressure(t, Rcggs, Vcggs, C);
PlotRollPitchYaw(t,S);
PlotAngularRates(t,S);
PlotQuaternion(t,S);

fprintf('All plots have been generated.\n');

%% Print Simulation Time:

SimulationTime = toc;
% [s]Stops the program timer.

SimulationTimeString = 'Total Simulation and Plotting Time: (%0.3f seconds)\n';
% []Formatted string.

fprintf(SimulationTimeString,SimulationTime);
% []Prints the simulation time on the command window.