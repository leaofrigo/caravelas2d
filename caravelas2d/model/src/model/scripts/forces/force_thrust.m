% engine force calculation

if check_engine==1
    % define max speed
    maxspeed=3.5; % mudei aqui
    if i>1 && norm(vv(i-1,1:2)) > maxspeed
        feng=(0.5)*vfeng0;
    else
        feng=vfeng0;
    end
    
    if i==1
        vfeng(i,1,1)=feng*cosd(vth0);
        vfeng(i,2,1)=feng*sind(vth0);
    else
        vfeng(i,1,1)=feng*cosd(vth(i-1));
        vfeng(i,2,1)=feng*sind(vth(i-1));
    end
end

% script check
%disp('force_thrust - OK')
