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

C.Vcggs = [v0 * cos(C.el) * sin(C.az); v0 * cos(C.el) * cos(C.az); v0 * sin(C.el)];
% [m/s]Initial vehicle velocity WRT the ground station in ENZ coordinates.

%% Numerical Integration:

to = [0,70];
% [s]Modeling time.

S0 = [ C.Rcggs; C.Vcggs; C.q0; C.omega0 ];
% [m,m/s]Initial vehicle state WRT the ground station in ENZ coordinates.

opts = odeset( ...
    'RelTol',    1E-10, ...
    'Events',    @(t,S) hitAltitude(t,S,C) ...
);

S = ode45(@(t,S) ProjectileMotionEom(t,S,C), to, So, opts);

%S = ode45(@(t,S)ProjectileMotionEom(t,S,C),to,So,C.Options);
% []Numerically integrates the equations of motion.

%% Plot Results:

t = S.x;
% [s]Time vector.

Rcggs = S.y(1:3,:);
% [m]Vehicle positions WRT the ground station in ENZ coordinates.

Vcggs = S.y(4:6,:);
% [m/s]Vehicle velocities WRT the ground station in ENZ coordinates.

PlotAltitude(t,Rcggs,C);
% []Plots the altitude above mean equator WRT to time.

PlotDisplacements(t,Rcggs);
% []Plots the Eastern, Northern, & Azimuth displacement WRT to time.

PlotSpeeds(t, Vcggs);
% []Plots the Eastern, Northern, & Azimuth speeds WRT to time.

PlotAzEl(t, Rcggs);
% []Plots the Azimuth & Elevation angles in ENZ coordinates vs. time.

PlotInertialAcceleration(t, Rcggs, Vcggs, C);
% []Plots the Intertial acceleration WRT to the ground station vs. time.

PlotDynamicPressure(t, Rcggs, Vcggs, C);
% []Plots the projectile's Dynamic Pressure vs. Time.

%% Print Simulation Time:

SimulationTime = toc;
% [s]Stops the program timer.

SimulationTimeString = 'Simulation Complete! (%0.3f seconds)\n';
% []Formatted string.

fprintf(SimulationTimeString,SimulationTime);
% []Prints the simulation time on the command window.
%===================================================================================================
