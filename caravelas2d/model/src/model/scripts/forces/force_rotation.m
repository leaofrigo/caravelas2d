% rotational force calculation

if check_rotational==1
    if i==1
        vfrot(i,1)=0;
        vfrot(i,2)=0;
        vfrot(i,3)=0;
        vfrotmag(i,:)=norm(vfrot(i,:));
        vfrothres(i,:) = (180/pi*atan2(vfrot(i,2),vfrot(i,1)));
    else
        vfrot(i,1)=(+1)*vv(i-1,2)*vangvel(i-1)*(vmass*(1));
        vfrot(i,2)=(-1)*vv(i-1,1)*vangvel(i-1)*(vmass*(1));
        vfrot(i,3)=0;
        vfrotmag(i,:)=norm(vfrot(i,:));
        vfrothres(i,:) = (180/pi*atan2(vfrot(i,2),vfrot(i,1)));
    end
else
    vfrot(i,1)=0;
    vfrot(i,2)=0;
end
%% script check
%disp('force_rotation - OK')