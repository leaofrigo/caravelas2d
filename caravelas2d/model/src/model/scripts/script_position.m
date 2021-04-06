% vessel position and shape script

% cell position calculation
% vpc2
if i==1
    vpc2(i,:)=vpc0;
else
    vpc2(i,:)=vpos(i-1,:,2);
end


% temporary
if i==1
    % vpc1
    vpc1dx=vdlen*cosd(vth0);
    vpc1dy=vdlen*sind(vth0);
    vpc1(i,:)=[vpc2(i,1)-vpc1dx,vpc2(i,2)-vpc1dy,0];
    % vpc3
    vpc3dx=vdlen*cosd(vth0);
    vpc3dy=vdlen*sind(vth0);
    vpc3(i,:)=[vpc2(i,1)+vpc3dx,vpc2(i,2)+vpc3dy,0];
    % vpr1
    vpr1dx=vdbeam*cosd(360-(90-vth0));
    vpr1dy=vdbeam*sind(360-(90-vth0));
    vpr1(i,:)=[vpc1(i,1)+vpr1dx,vpc1(i,2)+vpr1dy,0];
    % vpr2
    vpr2dx=vdbeam*cosd(360-(90-vth0));
    vpr2dy=vdbeam*sind(360-(90-vth0));
    vpr2(i,:)=[vpc2(i,1)+vpr2dx,vpc2(i,2)+vpr2dy,0];
    % vpr3
    vpr3dx=vdbeam*cosd(360-(90-vth0));
    vpr3dy=vdbeam*sind(360-(90-vth0));
    vpr3(i,:)=[vpc3(i,1)+vpr3dx,vpc3(i,2)+vpr3dy,0];
    % vpl1
    vpl1dx=vdbeam*cosd(180-(90-vth0));
    vpl1dy=vdbeam*sind(180-(90-vth0));
    vpl1(i,:)=[vpc1(i,1)+vpl1dx,vpc1(i,2)+vpl1dy,0];
    % vpl2
    vpl2dx=vdbeam*cosd(180-(90-vth0));
    vpl2dy=vdbeam*sind(180-(90-vth0));
    vpl2(i,:)=[vpc2(i,1)+vpl2dx,vpc2(i,2)+vpl2dy,0];
    % vpl3
    vpl3dx=vdbeam*cosd(180-(90-vth0));
    vpl3dy=vdbeam*sind(180-(90-vth0));
    vpl3(i,:)=[vpc3(i,1)+vpl3dx,vpc3(i,2)+vpl3dy,0];
    % vessel polygon shape
    X(i,:) = [vpl1(i,1,1) vpc1(i,1,1) vpr1(i,1,1) vpr2(i,1,1) vpr3(i,1,1) vpc3(i,1,1)  vpl3(i,1,1) vpl1(i,1,1)]';
    Y(i,:) = [vpl1(i,2,1) vpc1(i,2,1) vpr1(i,2,1) vpr2(i,2,1) vpr3(i,2,1) vpc3(i,2,1)  vpl3(i,2,1) vpl1(i,2,1)]';
else 
    
    % vpc1
    vpc1dx=vdlen*cosd(vth(i-1));
    vpc1dy=vdlen*sind(vth(i-1));
    vpc1(i,:)=[vpc2(i,1)-vpc1dx,vpc2(i,2)-vpc1dy,0];
    % vpc3
    vpc3dx=vdlen*cosd(vth(i-1));
    vpc3dy=vdlen*sind(vth(i-1));
    vpc3(i,:)=[vpc2(i,1)+vpc3dx,vpc2(i,2)+vpc3dy,0];
    % vpr1
    vpr1dx=vdbeam*cosd(360-(90-vth(i-1)));
    vpr1dy=vdbeam*sind(360-(90-vth(i-1)));
    vpr1(i,:)=[vpc1(i,1)+vpr1dx,vpc1(i,2)+vpr1dy,0];
    % vpr2
    vpr2dx=vdbeam*cosd(360-(90-vth(i-1)));
    vpr2dy=vdbeam*sind(360-(90-vth(i-1)));
    vpr2(i,:)=[vpc2(i,1)+vpr2dx,vpc2(i,2)+vpr2dy,0];
    % vpr3
    vpr3dx=vdbeam*cosd(360-(90-vth(i-1)));
    vpr3dy=vdbeam*sind(360-(90-vth(i-1)));
    vpr3(i,:)=[vpc3(i,1)+vpr3dx,vpc3(i,2)+vpr3dy,0];
    % vpl1
    vpl1dx=vdbeam*cosd(180-(90-vth(i-1)));
    vpl1dy=vdbeam*sind(180-(90-vth(i-1)));
    vpl1(i,:)=[vpc1(i,1)+vpl1dx,vpc1(i,2)+vpl1dy,0];
    % vpl2
    vpl2dx=vdbeam*cosd(180-(90-vth(i-1)));
    vpl2dy=vdbeam*sind(180-(90-vth(i-1)));
    vpl2(i,:)=[vpc2(i,1)+vpl2dx,vpc2(i,2)+vpl2dy,0];
    % vpl3
    vpl3dx=vdbeam*cosd(180-(90-vth(i-1)));
    vpl3dy=vdbeam*sind(180-(90-vth(i-1)));
    vpl3(i,:)=[vpc3(i,1)+vpl3dx,vpc3(i,2)+vpl3dy,0];
    % vessel polygon shape
    X(i,:) = [vpl1(i,1,1) vpc1(i,1,1) vpr1(i,1,1) vpr2(i,1,1) vpr3(i,1,1) vpc3(i,1,1)  vpl3(i,1,1) vpl1(i,1,1)]';
    Y(i,:) = [vpl1(i,2,1) vpc1(i,2,1) vpr1(i,2,1) vpr2(i,2,1) vpr3(i,2,1) vpc3(i,2,1)  vpl3(i,2,1) vpl1(i,2,1)]';
    
end

% script check
%disp('script_position - OK')
