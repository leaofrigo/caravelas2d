% ship data input

% ship main setup
vbeam=vessel_beam;	% vessel beam [m]
vdbeam=vbeam/2;	% distance for vessel beam points [m]
vlen=vessel_length;	% vessel lenght [m]
vdlen=vlen/2;	% distance for vessel lenght points [m]


vpc0=[simul_xpos,simul_ypos,0];	% initial position for point vpc1 - lon,lat [m]
vth0=vessel_angle;	% initial angle for vessel to north [deg]




vdraft=vessel_draft;	% vessel draft [m]
% vcdrag=1.0;
% vcfric=0.005;
vclift=1.0;	% vessel lift coefficient [-]
vmass=vessel_mass;	% vessel mass;
vivel=[(vessel_velocity*cosd(vth0))+cosd(vth0)*0.00001,...
    (vessel_velocity*sind(vth0)+0.00001*sind(vth0)),0];	% vessel initial velocity [m/s]
vcels=9;	% number of vessel discrete points [-]
vcg=[0.5*vbeam 0.5*vlen 0];	% vessel gravity center for homogeneous case [m]
vweta=zeros(vcels,1);	%cell - vessel wet area [m2]
vfeng0=vessel_engine;	% vessel initial engine force [N]

% vessel definitions [on/off]
autopilot_selection=autopilot;
force_drag_selection=check_drag;
force_lift_selection=check_lift;
force_addedmass_selection=check_addedmass;
force_rotation_selecton=check_rotational;
force_propulsion_selection=check_engine;
force_rudder_selection=check_rudder;

% inertia moment of the vessel
vmine=vmass*(vlen^2+vbeam^2)/12;	% vessel moment of inertia [kg.m2]

% ship cells setup - cells position in relation to the ship
vc1v=[vbeam/2 0 0];
vc2v=[vbeam/2 vlen/2 0];
vc3v=[vbeam/2 vlen 0];
vl1v=[0 0 0];
vl2v=[0 vlen/2 0];
vl3v=[0 vlen 0];
vr1v=[vbeam 0 0];
vr2v=[vbeam vlen/2 0];
vr3v=[vbeam vlen 0];

% cell position and distance from the ship center of gravity
vdscgv=zeros(9,3);
vdscgvc1=[vcg-vc1v];
vdscgvc2=[vcg-vc2v];
vdscgvc3=[vcg-vc3v];
vdscgvl1=[vl1v-vcg];
vdscgvl2=[vl2v-vcg];
vdscgvl3=[vl3v-vcg];
vdscgvr1=[vr1v-vcg];
vdscgvr2=[vr2v-vcg];
vdscgvr3=[vr3v-vcg];

% cell influence area
valatcell=vlen*vdraft/3;	% cell 4,5,6,7,8,9 (total lateral area / 3)
vafrocell=vbeam*vdraft;	% cell 1,3 (entire front of the vessel)
vacentercell=0;	% cell 2 (zero)
vweta(1)=vafrocell;
vweta(2)=vacentercell;
vweta(3)=vafrocell;
vweta(4)=valatcell;
vweta(5)=valatcell;
vweta(6)=valatcell;
vweta(7)=valatcell;
vweta(8)=valatcell;
vweta(9)=valatcell;

% script check
%disp('data_ship - OK')
