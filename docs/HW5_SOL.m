tic;
% []Starts the program timer.

clc;
% []Clears the command window.

clear;
% []Clears the variable workspace.

format('Compact');
% []Formats the command window output to single-spaced output.

format('LongG');
% []Formats the command window output to print 16 digits for double-precision variables.

close('All');
% []Closes all figures.

%% Initial Output:
String = 'Homework 5 Solution:\n';
% []Formatted string.

Equal = strcat(repelem('=',100),'\n');
% []Formatted string with 100 equal signs and a carriage return.

Dash = strcat(repelem('-',100),'\n');
% []Formatted string with 100 dash signs and a carriage return.

fprintf(String);
% []Prints the formatted string on the command window.

fprintf(Equal);
% []Prints the formatted string on the command window.

%% Constants:

u = 398600.435436;
% [km^3/s^2]Gravitational parameter of the Earth.

Re = 6378.137;
% [km]Mean equatorial radius of the Earth.

we = 2 * pi / 86164.1;
% [rad]Rotational speed of the Earth.

%% Given Quantities:
UTC = [2025, 12, 13, 14, 15, 16];
% [yyyy,MM,dd,HH,mm,ss]Coordinated universal time.

Enz.Rcggs = [6441; -2001; 931] / 1000;
% [km]Aircraft position relative to the ground station in ENZ coordinates.

Enz.Vcggs = [17; -12; -19] / 1000;
% [km/s]Aircraft velocity relative to the ground station in ENZ coordinates.

Enz.Acggs = [8.147; 9.057; 1.269] / 1000;
% [km/s^2]Aircraft acceleration relative to the ground station in ENZ coordinates.

Body.Wcg = [1.911; -1.337; 2.297] * pi / 180;
% [rad/s]Aircraft rotational velocity WRT the CG in Body coordinates.

Roll = -29.412 * pi / 180;
% [rad]Aircraft roll angle.

Pitch = 8.386 * pi / 180;
% [rad]Aircraft pitch angle.

Yaw = -7.192 * pi / 180;
% [rad]Aircraft yaw angle.

Gs.Lat = (32 + 44 / 60 + 52 / 3600) * pi / 180;
% [rad]Ground station latitude.

Gs.Long = -(97 + 5 / 60 + 34 / 3600) * pi / 180;
% [rad]Ground station longitude.

Gs.hgs = 0.185;
% [km]Ground station altitude above mean equator.

Icg = [ ...
10968.565, 0, 1762.563; ...
0, 35115.678, 0; ...
1762.563, 0, 39589.876] * 1E-6;
% [kg-km^2]Aircraft inertia tensor.

%% Problem A:
Enz.Rgse = (Re + Gs.hgs) * [0; 0; 1];
% [km]Ground station position WRT the Earth in ENZ coordinates.

Enz.Rcge = Enz.Rgse + Enz.Rcggs;
% [km]Aircraft position WRT the Earth in ENZ coordinates.

EcefToEnz = [ ...
-sin(Gs.Long), cos(Gs.Long), 0; ...
-sin(Gs.Lat) * cos(Gs.Long), -sin(Gs.Lat) * sin(Gs.Long), cos(Gs.Lat); ...
cos(Gs.Lat) * cos(Gs.Long), cos(Gs.Lat) * sin(Gs.Long), sin(Gs.Lat)];
% []Matrix that transforms vectors from ECEF coordinates to ENZ coordinates.

EnzToEcef = transpose(EcefToEnz);
% []Matrix that transforms vectors from ENZ coordinates to ECEF coordinates.

Ecef.Rcge = EnzToEcef * Enz.Rcge;
% [km]Aircraft position WRT the Earth in ECEF coordinates.
x = Ecef.Rcge(1);

% [km]Aircraft x-displacement WRT the Earth in ECEF coordinates.
y = Ecef.Rcge(2);

% [km]Aircraft y-displacement WRT the Earth in ECEF coordinates.
z = Ecef.Rcge(3);

% [km]Aircraft z-displacement WRT the Earth in ECEF coordinates.
rcge = norm(Ecef.Rcge);

% [km]Aircraft range WRT the Earth.
Lat = asin(z / rcge);

% [rad]Aircraft latitude.
Long = atan2(y,x);

% [rad]Aircraft longitude.
hcg = rcge - Re;
% [km]Aircraft altitude above mean equator.

%% Problem B:
Ecef.Rcggs = EnzToEcef * Enz.Rcggs;
% [km]Aircraft position relative to the ground station in ECEF coordinates.

EcefToNed = [ ...
-sin(Lat) * cos(Long), -sin(Lat) * sin(Long), cos(Lat); ...
-sin(Long), cos(Long), 0; ...
-cos(Lat) * cos(Long), -cos(Lat) * sin(Long), -sin(Lat)];
% []Matrix that transforms vectors from ECEF coordinates to NED coordinates.

Ned.Rcggs = EcefToNed * Ecef.Rcggs;
% [km]Aircraft position relative to the ground station in NED coordinates.

T1 = [ ...
1, 0, 0; ...
0, cos(Roll), sin(Roll); ...
0, -sin(Roll), cos(Roll)];
% []Matrix that transforms vectors about the 1-axis by an angle Roll.

T2 = [ ...
cos(Pitch), 0, -sin(Pitch); ...
0, 1, 0; ...
sin(Pitch), 0, cos(Pitch)];
% []Matrix that transforms vectors about the 2-axis by an angle Pitch.

T3 = [ ...
cos(Yaw), sin(Yaw), 0; ...
-sin(Yaw), cos(Yaw), 0;
0, 0, 1];
% []Matrix that tranforms vectors about the 3-axis by an angle Yaw.

NedToBody = T1 * T2 * T3;
% []Matrix that transforms vectors from NED coordinates to Body coordinates.

Body.Rcggs = NedToBody * Ned.Rcggs;
% [km]Aircraft position relative to the ground station in NED coordinates.

Body.Rgscg = -Body.Rcggs;
% [km]Ground station position relative to the aircraft in NED coordinates.

%% Problem C:

EnzToBody = NedToBody * EcefToNed * EnzToEcef;
% []Matrix that transforms vectors from ENZ coordinates to Body coordinates.

Body.Vcggs = EnzToBody * Enz.Vcggs;
% [km/s]Aircraft velocity relative to the ground station in Body coordinates.

Body.Vgscg = -Body.Vcggs;
% [km/s]Ground station velocity relative to the aircraft in Body coordinates.

%% Problem D:

Enz.We = we * [0; cos(Gs.Lat); sin(Gs.Long)];
% [rad/s]Earth rotational velocity in ENZ coordinates.

Enz.Vgse = cross(Enz.We,Enz.Rgse);
% [km/s]Ground station velocity WRT the Earth in ENZ coordinates.

Enz.Vcge = Enz.Vgse + cross(Enz.We,Enz.Rcggs) + Enz.Vcggs;
% [kms]Aircraft velocity WRT the Earth in ENZ coordinates.

Enz.Vatm = cross(Enz.We,Enz.Rcge);
% [km/s]Atmospheric velocity WRT the Earth in ENZ coordinates.

Enz.Vinf = Enz.Vcge - Enz.Vatm;
% [km/s]True air velocity in ENZ coordinates.

Body.Vinf = EnzToBody * Enz.Vinf;
% [km/s]True air velocity in Body coordinates.

%% Problem E:

Enz.Agse = cross(Enz.We,Enz.Vgse);
% [km/s^2]Ground station acceleration WRT the Earth in ENZ coordinates.

Enz.Acge = Enz.Agse + cross(Enz.We,cross(Enz.We,Enz.Rcggs)) + 2 * cross(Enz.We,Enz.Vcggs) + Enz.Acggs;
% [km/s^2]Aircraft inertial acceleration WRT the Earth in ENZ coordinates.

Body.Acge = EnzToBody * Enz.Acge;
% [km/s^2]Aircraft inertial acceleration WRT the Earth in Body coordinates.

%% Problem F:

Enz.g = -u * Enz.Rcge / rcge^3;
% [km/s^2]Acceleration due to gravity in ENZ coordinates.

Body.g = EnzToBody * Enz.g;
% [km/s^2]Acceleration due to gravity in Body coordinates.

%% Problem G:

Body.dWcg = Icg \ cross(-Body.Wcg,Icg * Body.Wcg);
% [rad/s^2]Aircraft rotational acceleration in Body coordinates.

%% Problem H:

Map = [ ...
1, sin(Roll) * tan(Pitch), cos(Roll) * tan(Pitch); ...
0, cos(Roll), -sin(Roll); ...
0, sin(Roll) * sec(Pitch), cos(Roll) * sec(Pitch)];
% []Euler angle rate mapping matrix.

dTheta = Map * Body.Wcg;
% [rad/s]Euler angle rates of change.

%% Problem I:

T = NedToBody;
% []Matrix that transforms vectors from NED coordinates to Body coordinates.

Q = zeros(4,1);
% []Allocates memory for the quaternion.

Q(4) = 0.5 * sqrt(1 + trace(T));
% []Fourth quaternion component.

D = 4 * Q(4);
% []Common denominator.

Q(3) = (T(1,2) - T(2,1)) / D;
% []Third quaternion component.

Q(2) = (T(3,1) - T(1,3)) / D;
% []Second quaternion component.

Q(1) = (T(2,3) - T(3,2)) / D;
% []First quaternion component.

%% Problem J:

wx = Body.Wcg(1);
% [rad/s]Aircraft rotational velocity x-component in Body coordinates.

wy = Body.Wcg(2);
% [rad/s]Aircraft rotational velocity y-component in Body coordinates.

wz = Body.Wcg(3);
% [rad/s]Aircraft rotational velocity z-component in Body coordinates.

Omega = [ ...
0, wz, -wy, wx; ...
-wz, 0, wx, wy; ...
wy, -wx, 0, wz; ...
-wx, -wy, -wz, 0];
% []Quaternion rate of change mapping matrix.

Qdot = 0.5 * Omega * Q;
% []Aircraft quaternion rate of change.

%% Print Results:

String = [ ...
'A) Aircraft coordinates:\n', ...
' \x03C6 = %2.0f\x00B0 %02.0f\x2032 %02.0f\x2033 N\n', ...
' \x03BB = %2.0f\x00B0 %02.0f\x2032 %02.0f\x2033 W\n', ...
' h = %0.3f m\n'];
% []Formatted string.

fprintf(String,degrees2dms(Lat*180/pi),degrees2dms(abs(Long)*180/pi),hcg*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------
String = strcat( ...
'B) Ground station position with respect to the aircraft in Body coordinates:\n', ...
'      [%10.3f]\n', ...
' \x03B4R = [%10.3f] m\n', ...
'      [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.Rgscg*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.
%----------------------------------------------------------------------------------

String = strcat( ...
'C) Ground station velocity with respect to the aircraft in Body coordinates:\n', ...
'      [%10.3f]\n', ...
' \x03B4V = [%10.3f] m/s\n', ...
'      [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.Vgscg*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------

String = strcat( ...
'D) Aircraft true air velocity in Body coordinates:\n', ...
'     [%10.3f]\n', ...
' V = [%10.3f] m/s\n', ...
'     [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.Vinf*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------

String = strcat( ...
'E) Aircraft inertial acceleration with respect to the Earth in Body coordinates:\n', ...
'     [%10.3f]\n', ...
' A = [%10.3f] m/s\x00B2\n', ...
'     [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.Acge*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------
String = strcat( ...
'F) Acceleration due to gravity in Body coordinates:\n', ...
'     [%10.3f]\n', ...
' g = [%10.3f] m/s\x00B2\n', ...
'     [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.g*1000);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------

String = strcat( ...
'G) Aircraft rotational acceleration in Body coordinates:\n', ...
'      [%10.3f]\n', ...
' d\x03C9 = [%10.3f] \x00B0/s\x00B2\n', ...
'      [%10.3f]\n');
% []Formatted string.

fprintf(String,Body.dWcg*180/pi);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------
String = strcat( ...
'H) Roll, pitch, and yaw rates of change:\n', ...
' d\x03B8\x2081 = %5.3f \x00B0/s\n', ...
' d\x03B8\x2082 = %5.3f \x00B0/s\n', ...
' d\x03B8\x2083 = %5.3f \x00B0/s\n');
% []Formatted string.

fprintf(String,dTheta(1)*180/pi,-dTheta(2)*180/pi,dTheta(3)*180/pi);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------
String = strcat( ...
'I) Aircraft quaternion:\n', ...
'     [%10.3f]\n', ...
' Q = [%10.3f]\n', ...
'     [%10.3f]\n', ...
'     [%10.3f]\n');
% []Formatted string.

fprintf(String,Q);
% []Prints the formatted string on the command window.

fprintf(Dash);
% []Prints the formatted string on the command window.

%----------------------------------------------------------------------------------

String = strcat( ...
'J) Aircraft quaternion rate of change with respect to time:\n', ...
'      [%10.3f] s\x207B\x00B9\n', ...
' dQ = [%10.3f] s\x207B\x00B9\n', ...
'      [%10.3f] s\x207B\x00B9\n', ...
'      [%10.3f] s\x207B\x00B9\n');
% []Formatted string.

fprintf(String,Qdot);
% []Prints the formatted string on the command window.

%% Print Simulation Time:
fprintf(Equal);
% []Prints the formatted string on the command window.

SimulationTime = toc;
% []Stops the program timer.

SimulationTimeString = 'Simulation Complete! (%0.3f seconds)\n';
% []Formatted string.

fprintf(SimulationTimeString,SimulationTime);
% []Prints the simulation time on the command window.

%==================================================================================