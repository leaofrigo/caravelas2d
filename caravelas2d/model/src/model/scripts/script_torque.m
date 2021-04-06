% resultant torque script

% cells position and distance to cgv (vpc2) to calculate torque
for n=1:vcels
    vdscgv(n,:)= [abs(vpc(i,:,n)-vpc(i,:,2))];
end

% torque in cells due resultant forces
for n=1:vcels
    for j=1:3
        if j==1
            vtrv(i,j,n)=[vrsf(i,j,n).*(vdscgv(n,2))];
            if vpc(i,2,n)>vpc(i,2,2);
                vtrv(i,j,n)=vtrv(i,j,n)*-1;
            else
                vtrv(i,j,n)=vtrv(i,j,n);
            end
        end
        if j==2
            vtrv(i,j,n)=[vrsf(i,j,n).*(vdscgv(n,1))];
            if vpc(i,1,n)<vpc(i,1,2);
                vtrv(i,j,n)=vtrv(i,j,n)*-1;
            else
                vtrv(i,j,n)=vtrv(i,j,n);
            end
        end
        if j==3
            vtrv(i,j,n)=[vrsf(i,j,n).*(vdscgv(n,3))];
        end
    end
end

% resultant torque calculation (all sections)
vtrvres(i)=sum(vtrv(i,:));

% angular acceleration in degrees/s2
valpha(i)=vtrvres(i)/vmine;

% angular velocity in deg/s1
if i==1
    vangvel(i)=0+valpha(i)*dt;
else % verificar
    vangvel_0(i)=abs((1/(vlen/2))*(norm(vv(i-1,1:2))*(cosd(vth(i-1)+90-mod((vvth(i-1)+360),360)))));
    if cosd(vth(i-1)+90-mod((vvth(i-1)+360),360)) <=0 
        vangvel_0(i)=vangvel_0(i)*(-1); % clockwise
    else
        vangvel_0(i)=vangvel_0(i)*(+1); % anti-clockwise
    end
    
    vangvel(i)=vangvel_0(i)+valpha(i)*dt;

    %vangvel(i)=valpha(i)*dt; 

    % vangvel(i)=vangvel(i-1)+valpha(i)*dt; %alterei aqui
    %vangvel(i)=valpha(i)*dt;
end

if i==1
    dvth(i)=0.5*valpha(i)*(dt^2);
else
    dvth(i)=vangvel(i-1)*dt+0.5*valpha(i)*(dt^2); %last
end

% if i>1
%     %vth(i)=vth(i-1)+radtodeg(dvth(i));
%     vth(i+1)=vth(i)+radtodeg(dvth(i));
% end

if i==1
    vth(i)=vth0;
else
    vth(i)=vth(i-1)+ (180/pi)*(dvth(i));
end

% script check
%disp('script_torque - OK')
