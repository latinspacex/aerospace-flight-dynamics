function C = ConstantsEom

    C.Gm = 3.98600435436E14;
    % [m^3/s^2]Gravitational parameter of the Earth.

    C.Re = 6378137;
    % [m]Mean equatorial radius of the Earth.

    C.we = 2 * pi / 86164.1;
    % [rad/s]Rotational speed of the Earth.

    C.g = 9.80665;
    % [m/s^2]Standard acceleration due to gravity.

    C.q0   = [1; 0; 0; 0];    
    % [–] initial attitude (identity quaternion)

    C.omega0 = [0; 0; 0];
    % [rad/s] initial body‐rate (no spin) 
    


    %----------------------------------------------------------------------
    % GROUND STATION: AT&T STADIUM

    C.phigs = deg2rad(dms2degrees([32, 44, 52]));
    % [rad]Ground station latitude.

    C.lambdags = -deg2rad(dms2degrees([97, 5, 34]));
    % [rad]Ground station longitude.

    C.hgs = 185;
    % [m]Ground station altitude above mean equator.

    %--------------------------------------------------------------------


    C.We = C.we * [0; cos(C.phigs); sin(C.phigs)];
    % [rad/s]Rotational velocity of the Earth in ENZ coordinates.

    C.Rgse = (C.Re + C.hgs) * [0; 0; 1];
    % [m]Ground station position WRT the Earth in ENZ coordinates

    C.Vgse = cross(C.We,C.Rgse);
    % [m/s]Ground station velocity WRT the Earth in ENZ coordinates.

    C.Agse = cross(C.We,C.Vgse);
    % [m/s]Ground station acceleration WRT the Earth in ENZ coordinates.

    %----------------------------------------------------------------------
    
    C.acg = (6.00225E-3) * pi;
    % [m^2]Vehicle reference area.

    C.Cl = 0.173;
    % []Magnus coefficient

    C.Cd = 0.82;
    % []Vehicle drag coefficient.

    C.mcg = 35;
    % [kg]Vehicle mass.

    C.Ixx = 0.0630656250;
    % [kg-m^2]Inertial tensor, xx component.

    C.Iyy = 01.3440328125;
    % [kg-m^2]Inertial tensor, yy component.

    C.Izz = C.Iyy;
    % [kg-m^2]Inertial tensor, zz component.

    C.Ixy = 0.1579431538;
    % [kg-m^2]Inertial tensor, xy component.

    C.Ixz = Ixy;
    % [kg-m^2]Inertial tensor, xz component.

    C.Iyz = Ixy;
    % [kg-m^2]Inertial tensor, yz component.

    C.Icg = [...
           Ixx,  0, Ixz; ...
           0,  Iyy,   0; ...
           Ixz,  0, Izz];
    % [kg-m^2]Inertial tensor.

    %----------------------------------------------------------------------
    % INITIAL CONDITIONS

    C.az = deg2rad(107);
    % [rad]Initial vehicle azimuth angle.

    C.el = deg2rad(45);
    % [rad]Initial vehicle elevation angle.

    C.Rcggs = [0; 0; 0];
    % [m]Initial projectile position WRT the ground station in ENZ coordinates.

    %----------------------------------------------------------------------

    C.Options = odeset('RelTol',1E-10);
    % []Adjusts the properties of the numerical integrator.

end