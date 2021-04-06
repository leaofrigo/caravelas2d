% field flow script

% position to obtain velocity field magnitude and direction
vpc(i,:,1)=vpc1(i,:);
vpc(i,:,2)=vpc2(i,:);
vpc(i,:,3)=vpc3(i,:);
vpc(i,:,4)=vpr1(i,:);
vpc(i,:,5)=vpr2(i,:);
vpc(i,:,6)=vpr3(i,:);
vpc(i,:,7)=vpl1(i,:);
vpc(i,:,8)=vpl2(i,:);
vpc(i,:,9)=vpl3(i,:);

% select velocity field mode:
% [1] velocity field for constant velocity and direction
% [2] velocity field for 1D data
% [3] velocity field for 2D data

% [1] velocity field for constant velocity and direction
if check_river_flow_synthetic==1
    for n=1:vcels
        rcurvelth(i,n)=simul_flowangle;
        vvcels(i,1,n)=simul_flowvel*cosd(simul_flowangle);
        vvcels(i,2,n)=simul_flowvel*sind(simul_flowangle);
    end
else
end

% [2] one dimensional velocity field
if check_river_flow_measured==1 && ndim==1
    % ship position
    p1_scriptfield = vpc(i,1:2,3);
    % closest flow velocity point to the ship
    [k_scriptfield,t_scriptfield]=dsearchn(p1_scriptfield,flow_field(:,1:2));
    [m_scriptfield,n_scriptfield] = sort(t_scriptfield);
    % 1d velocity angle is the channel longitudinal angle
    p2_scriptfield = flow_field(n_scriptfield(1),1:2);
    [k2_scriptfield,t2_scriptfield]=dsearchn(p2_scriptfield,fairway_path(:,1:2));
    [m2_scriptfield,n2_scriptfield] = sort(t2_scriptfield);
    rcurvelth(i,:)=fairway_path(n2_scriptfield(1),3);
    % resultant flow velocity on the ship
    vvabs_shp(i)=flow_field(n_scriptfield(1),3);
    vvcels(i,1,:)=vvabs_shp(i)*cosd(rcurvelth(i,1));
    vvcels(i,2,:)=vvabs_shp(i)*sind(rcurvelth(i,1));
end


% [3] velocity field for BAW data
if check_river_flow_measured==1 && ndim==2
    % aqui suponho na direcao do escoamento mudar para vv vu
    %[m_ind,n_ind]=pdist2(fairway_path(:,1:2),vpc(i,1:2,3),'euclidean','smallest',1);
    
    %[n_ind,m_ind]=dsearchn(fairway_path(:,1:2),vpc(i,1:2,3));
    %rcurvelth(i,:)=fairway_path(n_ind,3);
    
    x1= vpc(i,1,9);
    x2= vpc(i,1,6);
    x3= vpc(i,1,7);
    x4= vpc(i,1,4);
    y1= vpc(i,2,9);
    y2= vpc(i,2,6);
    y3= vpc(i,2,7);
    y4= vpc(i,2,4);
    % ship x points
    xv_shp = [x1 x2 x3 x4 x1];
    % ship y points
    yv_shp = [y1 y2 y3 y4 y1];
    % vector inside/outside 1/0
    pvel_in_ship = inpolygon(xq_shp,yq_shp,xv_shp,yv_shp);
    count_vel_shp=0;
    vel_mean_dbf_shp_temp=0;
    vel_mean_dbf_shp_temp_vv=0;
    vel_mean_dbf_shp_temp_vu=0;
    for i_shp=1:size_shape1(1)
        if pvel_in_ship(i_shp)==1
            count_vel_shp=count_vel_shp+1;
            vel_mean_dbf_shp_temp=vel_mean_dbf_shp_temp+S1(i_shp).v;
            vel_mean_dbf_shp_temp_vv=vel_mean_dbf_shp_temp_vv+S1(i_shp).vv;
            vel_mean_dbf_shp_temp_vu=vel_mean_dbf_shp_temp_vu+S1(i_shp).vu;
        else
        end
    end
    vvabs_shp_vv(i)=vel_mean_dbf_shp_temp_vv/count_vel_shp;
    vvabs_shp_vu(i)=vel_mean_dbf_shp_temp_vu/count_vel_shp;
    rcurvelth(i,:)=mod(atan2d(vvabs_shp_vv(i),vvabs_shp_vu(i))+360,360);
    vvabs_shp(i)=vel_mean_dbf_shp_temp/count_vel_shp;
    vvcels(i,1,:)=vvabs_shp(i)*cosd(rcurvelth(i,1));
    vvcels(i,2,:)=vvabs_shp(i)*sind(rcurvelth(i,1));
    
    
    
end
%% script check
%disp('script_field - OK')
