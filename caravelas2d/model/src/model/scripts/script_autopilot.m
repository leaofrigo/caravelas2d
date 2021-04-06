% autopilot system
if autopilot_selection == 1 && check_river_parameters_measured==1
    
    % part I - load data and variables
    if i==1
        % fairway points
        fairway_points=fairway_path(:,1:2);
        % fairway direction
        fairway_angle=fairway_path(:,3);
        % angle limit for the ship to detect point in the bow
        th2_bound=120;
        % maximum ship-to-point detection distance to action
        pmax_dist=250;
        % N closest points from the ship to be detected
        nclosep=100;
        % ship-to-points angles
        tt1=zeros(nclosep,1);
        % auxiliary index
        point_check_pilot=0;
        % minimum ship-to-point detection distance to action
        pmin_dist=0;
        % minimum ship-to-point detection distance to action
        pmin_dist_side=1*vessel_beam;
        % auto-pilot response time
        rst=dt*2;
        % ship-to-channel maximum angle difference
        limit_aps_ang=10;
        % navigation channel angle for each i
        p3ang=zeros(ni,1);
        % selected points
        vec_okps=zeros(ni,1);
    end
    % vessel position for i (bow)
    p1 = vpc(i,1:2,3);
    % vessel direction for i
    th2=mod((vth(i)+360),360);
    % auxiliary index iterator from 1 to nclosep
    ap=1;
    % vector with detected points
    close_ok_point=zeros(nclosep,1);
    
    % part II - detect target
    % ship-to-point vector m-distance and n-index
    %[m,n]=pdist2(fairway_points,p1,'euclidean','smallest',nclosep);
    % m is the distance
    % n is the index
    [k_temp,t_temp]=dsearchn(p1,fairway_points);
    % k_temp: index not used
    % t_temp: distances from p1 to vector
    %[m,n]=min(t_temp)
    % m is the distance
    % n is the index
    [m,n] = sort(t_temp);
    
    % loop for condition to choose target
    while point_check_pilot==0 && ap < nclosep
        % load fairway point
        p2=fairway_points(n(ap),:);
        dp=p2-p1;
        % angle between ship and point
        tt1=atan2d(dp(2),dp(1));
        tt1=mod((tt1+180),180); % TROQUEI AQUI POR 180 AO INVES DE 360
        % vessel direction angle
        th2=mod((th2+360),360);
        % condition to define target
        %if m(ap) < pmax_dist && abs(tt1-th2) < th2_bound && m(ap) >
        %pmin_dist %% troquei!!! 15NOVEMBRO2017
         if m(ap) < pmax_dist && tt1 < 90 && m(ap) > pmin_dist %% troquei!!!
        % 1. target distance within detection range - m(ap) < pmax_dist
            % 2. target angle within detection range - abs(tt1-th2) < th2_bound
            % 3. target distance within detection range - m(ap) > pmin_dist
            dcheck=dcheck+1;
            close_ok_point=ap;
            point_check_pilot=1;
        else
            % test other targets
            point_check_pilot=0;
            ap=ap+1;
        end
    end
    if point_check_pilot==0
        ruddir=0;
    end
    
    
    
    % part III - define rudder maneuver
    if point_check_pilot==1
        % selected fairway target
        p3=fairway_points(n(close_ok_point),:);
        vec_okps(i)=n(close_ok_point);
        % ship-to-point distance
        dp=p3-p1;
        % fairway closest point direction of navigation (mean of 5)
        %p3ang(i)=mean(fairway_angle(n(1:5)));
        % fairway select point direction of navigation
        p3ang(i)=fairway_angle(n(close_ok_point));
        % auxiliary variable
        acheck=acheck+1;
        % angle between ship and point
        tt1f=atan2d(dp(2),dp(1));
        th1=tt1f;
        th1=mod((th1+360),360);
        

         if norm(dp)< pmin_dist_side
             % if the distance is small take the channel angle
             thetanew=mod(((p3ang(i)-th2)+360),360);
             thetaoption(i)=1;
         else
             % take the point angle
             thetanew=mod(((th1-th2)+360),360);
             thetaoption(i)=2;
         end


        
        % rudder maneuver in relation to the position
        %  (right)
        if thetanew >= 0.0 && thetanew <= 90.0 && mod(dt*i,rst)==0
            verf(i)=1;
            %ruddir=+1;
            ruddir=-1;
            %  (left)
        elseif thetanew >= 270.0 && thetanew <= 360.0 && mod(dt*i,rst)==0
            verf(i)=2;
            %ruddir=-1;
            ruddir=+1;
            %  (right)
        elseif thetanew >= 90.0 && thetanew <= 180.0 && mod(dt*i,rst)==0
            verf(i)=3;
            %ruddir=+1;
            ruddir=-1;
            % (left)
        elseif thetanew >= 180.0 && thetanew <= 270.0 && mod(dt*i,rst)==0
            verf(i)=4;
            %ruddir=-1;
            ruddir=+1;
            % no maneuver
        else
            verf(i)=5;
            ruddir=0;
        end
        
        % rudder maneuver in relation to the angle
        % ship direction - navigation direction
        difang=abs(th2-p3ang(i));
        difangrud=(th2-p3ang(i));
        % ship-to-channel closest distance
        p4=fairway_points(n(close_ok_point),:); %n(1) ou close ok?
        dp2=abs(p1-p4);
        
        % if close to the channel and the angle dif is small
        if i>1 && norm(dp2) < pmin_dist_side && difang < limit_aps_ang
            ruddir=0;
            verf(i)=6;
        end
        
        %         % small distance and great angle
        thetanew2=mod(((p3ang(i)-th2)+360),360);
        if i>1 && norm(dp2) < pmin_dist_side && difang > limit_aps_ang
            
            if thetanew2 >= 0.0 && thetanew2 <= 90.0  && mod(dt*i,rst)==0
                verf(i)=7;
                ruddir=+1;
                % starboard side turn (right)
            elseif thetanew2 >= 270.0 && thetanew2 <= 360.0 && mod(dt*i,rst)==0
                verf(i)=8;
                ruddir=-1;
                % port side turn (left)
            elseif thetanew2 >= 90.0 && thetanew2 <= 180.0 && mod(dt*i,rst)==0
                verf(i)=7;
                ruddir=+1;
                % starboard side turn (right)
            elseif thetanew2 >= 180.0 && thetanew2 <= 270.0 && mod(dt*i,rst)==0
                verf(i)=8;
                ruddir=-1;
                % no maneuver
            else
                verf(i)=9;
                %ruddir=0;
            end
        end
        %
        %
        wexc=1.75; %1.5 melhor
        %
        %         %TALVEZ ADD AQUI A RELACAO COM O ANGULO DO CANAL
        %         %
        %
        if i>1 && vangvel(i-1) > 0 && vangvel(i-1) > +wexc
            verf(i)=10;
            ruddir=-1;
        elseif i>1 && vangvel(i-1) < 0 && vangvel(i-1) < -wexc
            verf(i)=11;
            ruddir=+1;
        end
        %
        
        
        
        % check vectors
        ruddir_vec(i)=ruddir;
        p2points(i,:)=p3;
        dpvec(i,:)=dp;
        dth=th2-th1;
        dthvec(i,:)=[th2 th1 dth];
    else
        %ruddir=-1; %% tirar isso eh problema de qnd nao pega ponto
        bcheck=bcheck+1;
    end
    point_check_pilot=0;
end
%% script check
%disp('script_autopilot - OK')
