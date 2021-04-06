% declaration of the  model general vector, matrix and parameters

% general constants
ag=9.81;	% gravity acceleration [m/s2]

% vessel motion variables
vds=zeros(ni,3);    % vessel dif position (x,y,z) [m]
vpos=zeros(ni,3,vcels); % vessel cell real position (x,y,z) [m]
vth=zeros(ni,1);    % vessel angle [deg]
vth(1) = vth0;	% initial angle for vessel to north [deg]

% vessel velocity variables
vv=zeros(ni,3);	% vessel velocity u,v,w [m/s]
vdv=zeros(ni,3,vcels);	% cell vessel current dif vel [m/s]
vdvmag=zeros(ni,1,vcels);	% celrl vessel current dif vmag [m/s]
vvres=zeros(ni,3);	% vessel velocity resultant [m/s]
vvmag=zeros(ni,1);	% vessel resultant magnitude [m/s]
vvthres=zeros(ni,3);	% vessel velocity resultant th [m/s]
vvth=zeros(ni,1);	% vessel velocity direction
dthvv=zeros(ni,1);	% angle between vessel velocity vector and vessel direction

% vessel acceleration variables
vares=zeros(ni,3);      % vessel resultant acceleration [m/s2]
varesmag=zeros(ni,1);	% vessel resultant acc mag [m/s2]
varesth=zeros(ni,1);	% vessel resultant acc angle [deg]

% ship drag force variables
vfd=zeros(ni,3,vcels);  % drag force vector [N]
vfdmag=zeros(ni,1,vcels); % drag force magnitude [N]
vfdth=zeros(ni,vcels);  % drag force angle [deg]
vfdres=zeros(ni,3); % vessel fd resultant [N]
vfdthres=zeros(ni,1); % vessel fd resultant th [deg]

% ship drag force variables
vfdf=zeros(ni,3,vcels); % drag force vector [N]
vfdfcmag=zeros(ni,1,vcels); % drag force magnitude [N]
vfdfth=zeros(ni,vcels); % drag force angle [deg]
vfdfres=zeros(ni,3);  % vessel fd resultant [N]
vfdfthres=zeros(ni,1);  % vessel fd resultant th [deg]

% velocity friction direction
vfricmod=zeros(ni,vcels); % friction velocity magnitude [m/s]
vfric=zeros(ni,3,vcels);  % friction velocity vxvyvz [m/s]
vdvfric=zeros(ni,3,vcels);	% cell vessel current dif vel [m/s]
vdvfricmag=zeros(ni,1,vcels);	% cell vessel current dif vmag [m/s]
vfdfric=zeros(ni,3,vcels);	% force due to friction [N]
vfdfricmag=zeros(ni,1,vcels);	% mag of the force due to friction [N]
vfdfricthres=zeros(ni,1);	% angle force due to friction [N]
vvfricmod=zeros(ni,vcels);  % vessel magnitude velocity for friction forces direction
vvfric=zeros(ni,3,vcels);	% vessel velocity for friction forces direction

% velocity pressure direction
vpressmod=zeros(ni,vcels);	% pressure velocity magnitude [m/s]
vpress=zeros(ni,3,vcels);	% pressure velocity vxvyvz [m/s]
vdvpress=zeros(ni,3,vcels);	% cell vessel current dif vel [m/s]
vdvpressmag=zeros(ni,1,vcels);	% cell vessel current dif vmag [m/s]
vfdpress=zeros(ni,3,vcels); % force due to pressure [N]
vfdpressmag=zeros(ni,1,vcels);	% mag of the force due to pressure [N]
vfdpressthres=zeros(ni,1);	% angle force due to pressure [N]
vvpressmod=zeros(ni,vcels);	% vessel magnitude velocity for pressure forces direction
vvpress=zeros(ni,3,vcels);	% vessel velocity for pressure forces direction

% ship lift force variables
vfl=zeros(ni,3,vcels); 	% lift force vector [N]
vflmag=zeros(ni,1,vcels);	% lift force magnitude [N]
vflth=zeros(ni,vcels);	% lift force angle [deg]
vflres=zeros(ni,3);	% vessel fl resultant [N]
vflthres=zeros(ni,1);	% vessel fl resultant th [deg]

% ship engine force variables
feng=vessel_engine;	% maximal engine force [N]
vfeng=zeros(ni,3,vcels);	% engine force vector [N]
vfengmag=zeros(ni,1,vcels);	% engine force magnitude [N]
vfength=zeros(ni,vcels);	% engine force angle [deg]
vfengres=zeros(ni,3);	% vessel resultant [N]
vfengthres=zeros(ni,1);	% vessel resultant th [deg]

% ship rotational force variables
vfrot=zeros(ni,3);	% rotational force vector [N]
vfrotmag=zeros(ni,1);	% rotational force magnitude [N]
vfrotth=zeros(ni);	% rotation force angle [deg]

% ship rudder force variables
frud=1;	% rudder force to be add as a func [N]
maxrudth=45;	% maximal rudder angle [deg]
vfrud=zeros(ni,3,vcels);	% rudder force vector [N]
vfrudmag=zeros(ni,1,1);	% rudder force magnitude [N]
vfrudth=zeros(ni,vcels);	% rudder force angle [deg]
vfrudres=zeros(ni,3);	% vessel resultant [N]
vfrudthres=zeros(ni,1);	% vessel rudder th [deg]
ruddir=0;	% rudder initial direction [-1,0,+1]

% resultant force
vrsf=zeros(ni,3);	% resultant force vector [N]
vrsf_aux=zeros(vcels,3);	% auxilixar vector for vrsf

% vessel resultant torque varibles
vtrv=zeros(ni,3,vcels);	% vessel-current torque [n.m]
vtrvres=zeros(ni,1);	% vessel-current resultant torque [n.m]
valpha=zeros(ni,1);	% angular acceleration [rad/s2]
vangvel=zeros(ni,1);	% angular velocity [rad/s]
dvth=zeros(ni,1);	% angular variation [rad]

% vessel cells and shape variables (9 cells case)
vpc=zeros(ni,3,9);
vpc1=zeros(ni,3);
vpc1(1,:)=vpc0;
vpc2=zeros(ni,3);
vpc3=zeros(ni,3);
vpr1=zeros(ni,3);
vpr2=zeros(ni,3);
vpr3=zeros(ni,3);
vpl1=zeros(ni,3);
vpl2=zeros(ni,3);
vpl3=zeros(ni,3);
X=zeros(ni,8);
Y=zeros(ni,8);

% river-vessel constrain variables
cin_left=0;	% detection inside polygon
con_left=0;	% detection on polygon
cout_left=0;	% detection outside polygon
cin_right=0;	% detection inside polygon
con_right=0;	% detection on polygon
cout_right=0;	% detection outside polygon

% river current variables
vvcels=zeros(ni,3,vcels);	% u,v,w velocity for each cell [m/s]
rcurvelth=zeros(ni,vcels);	% field velocity angles [deg]
rho=1000;	% river water density [kg/m3]

% analysis variables
vfroude=zeros(ni);	% cell vessel froude number

% output variables
legtextpos=[90,15];

% autopilot parameters
p2points=zeros(ni,2);
verf=zeros(ni,1);
acheck=0;
bcheck=0;
ccheck=0;
dcheck=0;
ruddir_vec=zeros(ni,1);
dpvec=zeros(ni,2);
dth=0;
dthvec=zeros(ni,3);

% script check
%disp('data_variables - OK')
