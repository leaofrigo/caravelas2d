% rudder/azimutal thruster action and force calculation
 
if autopilot_selection == 1 && check_river_parameters_measured==1
    vfrudmagmax(i)=vessel_bowforce;
     
    % teste para calcular a forca exata necessaria
     
%     if i>1 %&& mod(dt*i,0.5)==0
%     frud2= ((difangrud - vangvel(i-1)*0.5)/(0.5*0.5*0.5))*(vmine/(vlen/2));
%     vfrudmagmax(i)=abs(frud2);
%     else
%             vfrudmagmax(i)=0;
%     end
     
%     if vfrudmagmax(i) > vessel_engine %&& mod(dt*i,0.5)==0
%         vfrudmagmax(i)=vessel_engine*0.5;
%     end
     
    %rudmaxangle=90; % tava 45
    %vfrudthres(i)=wrapTo360(vth(i)+180-rudmaxangle);
     
        %rudmaxangle=25; % tava 45
        rudmaxangle=vess_ang_cal;
        if i==1
            vfrudthres(i)=abs(vth0-rudmaxangle-90);
        else
            vfrudthres(i)=abs(vth(i-1)-rudmaxangle-90);
        end
     
        %     vfrudthres(i)=vth(i)-rudmaxangle;
 
         
    % rudder initial position [0,+1,-1]
    if i==1
        ruddir=0;
    else
        % if the distance is below a distance limit turn force
        if  verf(i-1)==7 || verf(i-1)==8
            vfrudmag(i)=vfrudmagmax(i); 
        elseif verf(i-1)==10 ||  verf(i-1)==11
            vfrudmag(i)=vfrudmagmax(i);
        elseif verf(i-1)==1 ||  verf(i-1)==2
            vfrudmag(i)=vfrudmagmax(i);
        else
            vfrudmag(i)=vfrudmagmax(i);
        end
        if check_rudder==1 && i>1
            % stern thrust
            vfrud(i,1,1)=vfrudmag(i)*cosd(vfrudthres(i))*ruddir*(1); % add o -1 pra um teste
            vfrud(i,2,1)=vfrudmag(i)*sind(vfrudthres(i))*ruddir*(1);
            % bow thrust - remove comment to activate
            %vfrud(i,1,3)=vfrudmag(i)*cosd(vfrudthres(i))*(-ruddir);
            %vfrud(i,2,3)=vfrudmag(i)*sind(vfrudthres(i))*(-ruddir);
        else
            % stern thrust
            vfrud(i,1,1)=0;
            vfrud(i,2,1)=0;
            % bow thrust - remove comment to activate
            %vfrud(i,1,3)=0;
            %vfrud(i,2,3)=0
        end
    end
end
 
% script check
%disp('force_rudder - OK')
