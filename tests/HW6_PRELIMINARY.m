clc;
clear;
format 'longg'

%% Constants
r.Earth = 6378.137;
% [km]Mean equatorial radius of Earth.

w.Earth = 2 * pi / 86164.1;
% [rad/s]Rotational speed of the Earth.

%% GIVEN
% -------------------------------------------------------------------------

UTC = [2025,12,13,14,15,26];
% [yyyy,MM,dd,HH,mm,ss]Coordinated universal time.

phi.gs = deg2rad(34 + 54/60 + 2/3600);
% [rad]Latitude North of GS.

lambda.gs = deg2rad(- (117 + 53/60 + 1/3600)); 
% [rad]Longitude West of GS.

h.gs = 0.914; 
% [km]Altitude above mean equator of GS.

h.cg = 9.637; 
% [km]Altitude above mean equator of F-15E.

% -------------------------------------------------------------------------

vv.inf.body = [0.681; 0.001; -0.005];
% [km/s]Aicraft's true air velocity in body coordinates.

wv.cg.body = deg2rad([1.814; 1.059; 1.164]);
% [rad/s]Aircraft's rotational velocity WRT its CG in body coordinates.

Q = [0.0182830462427466; 0.285320133098212; ...
     0.335270344350527; 0.897692568794007;];
% []Aircrafts quaternion.

% -------------------------------------------------------------------------
%% A. What is the ground station’s position relative to the aircraft in Body coordinates at this instant?

rv.gs_ea.enz = (r.Earth + h.gs) * [0; 0; 1];
% [km]Absolute position of ground station WRT Earth in ENZ coordinates.

rv.gs_ea.ecef = ENZ2ECEF(phi.gs,lambda.gs) * rv.gs_ea.enz;
% [km]Absolute position of ground station WRT Earth in ECEF coordinates.

rv.cg_ea.enz = (r.Earth + h.cg) * [0; 0; 1];
% [km]Absolute position of Aircraft WRT Earth in ENZ coordinates.

rv.cg_ea.ecef = ENZ2ECEF(phi.gs,lambda.gs) * rv.cg_ea.enz;
% [km]Absolute position of Aircraft WRT Earth in ECEF coordinates.

rv.gs_cg.ecef = rv.gs_ea.ecef - rv.cg_ea.ecef;
% [km]Relative position of ground station WRT Aircraft in ECEF coordinates.

NED2BODY = [Q(1)^2 - Q(2)^2 - Q(3) + Q(4)^2, 2 * (Q(1) * Q(2) + Q(3) * Q(4)),  2 * (Q(1) * Q(3) - Q(2) * Q(4)); ...
             2 * (Q(1) * Q(2) - Q(3) * Q(4)), -Q(1)^2 + Q(2)^2 - Q(3)^2 + Q(4)^2, 2 * (Q(2) * Q(3) + Q(1) * Q(4)); ...
             2 * (Q(1) * Q(3) + Q(2) * Q(4)), 2 * (Q(2) * Q(3) - Q(1) * Q(4)), -Q(1)^2 - Q(2)^2 + Q(3) + Q(4)^2 ];
% []Tranformation matrix from NED to BODY coordinates.

rv.gs_cg.body = NED2BODY * ECEF2NED(phi.gs,lambda.gs) * rv.gs_cg.ecef;

%% B. What is the aircraft’s velocity relative to the ground station in ENZ coordinates at this instant?

BODY2ENZ = ECEF2ENZ(phi.gs,lambda.gs) * NED2ECEF(phi.gs,lambda.gs) * transpose(NED2BODY);

vv.cg_ea.enz = BODY2ENZ * vv.inf.body;

wv.ea.enz = w.Earth * [0; cos(phi.gs); sin(phi.gs)];

vv.gs_ea.enz = cross(wv.ea.enz,rv.gs_ea.enz);

rv.cg_gs.enz = rv.cg_ea.enz - rv.gs_ea.enz;

vv.cg_gs.enz = vv.cg_ea.enz - vv.gs_ea.enz - cross(wv.ea.enz,rv.cg_gs.enz);

%% C. What is the aircraft’s absolute position with respect to the Earth in ECEF coordinates at this instant?

rv.cg_ea.enz = (r.Earth + h.cg) * [0; 0; 1];
% [km]Absolute position of Aircraft WRT Earth in ENZ coordinates.

rv.cg_ea.ecef = ENZ2ECEF(phi.gs,lambda.gs) * rv.cg_ea.enz;
% [km]Absolute position of Aircraft WRT Earth in ECEF coordinates.

%% D. What is the aircraft’s absolute velocity with respect to the Earth in ECI coordinates at this instant?

JD = juliandate(UTC);
% Days since J2000

days_u = JD - 2451545;
% Earth rotation angle (ERA)

ERA = 2*pi*(0.779057273264 + 1.00273781191135448 * days_u);
% Rotation about z by -ERA

ECEF2ECI = [cos(-ERA), -sin(-ERA), 0; sin(-ERA), cos(-ERA), 0; 0, 0, 1];

vv.cg_ea.eci =  ECEF2ECI * vv.cg_ea.enz;

%% E. What are the aircraft’s roll, pitch, and yaw angles at this instant?

phi = rad2deg(atan2(NED2BODY(2,3),NED2BODY(3,3)));

tht = rad2deg(asin(-NED2BODY(1,3)));

psi = rad2deg(atan2(NED2BODY(1,2),NED2BODY(1,1)));


%% F. What are the aircraft’s roll, pitch, and yaw angle rates of change at this instant?

phi_tht_psi.rates = [1, sind(phi)*tand(tht), cosd(phi)*tand(tht); 0, cosd(phi), -sind(phi);...
                    0, sind(phi)/cosd(tht), cosd(phi)/cosd(tht)] * rad2deg(wv.cg.body);

%% G. What is the aircraft’s quaternion rate of change at this instant? 

PQR = wv.cg.body; 

OMG = [0, -PQR(1), -PQR(2), -PQR(3); ...
       PQR(1), 0, PQR(3), -PQR(2); ...
       PQR(2), -PQR(3), 0, PQR(1); ...
       PQR(3), PQR(2), -PQR(1), 0];

Q_rate = 0.5 * OMG * Q;

