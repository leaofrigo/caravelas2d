% ship discrete points calculation

% cells initial position

% vpc2 - center of mass
vpos(1,:,2)=vpc0;
% vpc1
if vcels>=2
    %vpos(1,:,1)=[vpos(1,:,2)-vpc1dx,vpc2(i,2)-vpc1dy,0];
    %     vpc1dx=vdlen*cosd(vth0);
    %     vpc1dy=vdlen*sind(vth0);
    %     vpos(1,:,1)=[vpc0-vpc1dx,vpc0-vpc1dy,0];
    
    vpc1dx=vdlen*cosd(vth0);
    vpc1dy=vdlen*sind(vth0);
    vpos(1,:,1)=vpos(1,:,2)-[vpc1dx,vpc1dy,0];
end
% vpc3
if vcels>=3
    %vpos(1,:,3)=vpc0+[0  vlen 0];
    %     vpc3dx=vdlen*cosd(vth0);
    %     vpc3dy=vdlen*sind(vth0);
    %     vpos(1,:,3)=[vpc0+vpc1dx,vpc0+vpc1dy,0];
    
    vpc3dx=vdlen*cosd(vth0);
    vpc3dy=vdlen*sind(vth0);
    vpos(1,:,3)=vpos(1,:,2)+[vpc3dx,vpc3dy,0];
    
    
end
% vpr1
if vcels>=4
    %vpos(1,:,4)=vpc0+[vbeam/2  0 0];
    %     vpr1dx=vdbeam*cosd(360-(90-vth(i-1)));
    %     vpr1dy=vdbeam*sind(360-(90-vth(i-1)));
    %     vpos(1,:,4)=[vpc1(i,1)+vpr1dx,vpc1(i,2)+vpr1dy,0];
    %
    vpr1dx=vdbeam*cosd(360-(90-vth0));
    vpr1dy=vdbeam*sind(360-(90-vth0));
    vpos(1,:,4)=vpos(1,:,1)+[vpr1dx,vpr1dy,0];
    
    
    
end
% vpr2
if vcels>=5
    %vpos(1,:,5)=vpc0+[vbeam/2  vlen/2 0];
    vpr2dx=vdbeam*cosd(360-(90-vth0));
    vpr2dy=vdbeam*sind(360-(90-vth0));
    %vpos(1,:,5)=[vpc2(i,1)+vpr2dx,vpc2(i,2)+vpr2dy,0];
    vpos(1,:,5)=vpos(1,:,2)+[vpr2dx,vpr2dy,0];
   
end
% vpr3
if vcels>=6
    %vpos(1,:,6)=vpc0+[vbeam/2  vlen 0];
    vpr3dx=vdbeam*cosd(360-(90-vth0));
    vpr3dy=vdbeam*sind(360-(90-vth0));
    %vpos(1,:,6)=[vpc3(i,1)+vpr3dx,vpc3(i,2)+vpr3dy,0];
    vpos(1,:,6)=vpos(1,:,3)+[vpr3dx,vpr3dy,0];
    
end
% vpl1
if vcels>=7
    % vpos(1,:,7)=vpc0+[-vbeam/2  0 0];
    vpl1dx=vdbeam*cosd(180-(90-vth0));
    vpl1dy=vdbeam*sind(180-(90-vth0));
    %vpos(1,:,7)=[vpc1(i,1)+vpl1dx,vpc1(i,2)+vpl1dy,0];
    vpos(1,:,7)=vpos(1,:,1)+[vpl1dx,vpl1dy,0];
    
    
end
% vpl2
if vcels>=8
    %vpos(1,:,8)=vpc0+[-vbeam/2  vlen/2 0];
    vpl2dx=vdbeam*cosd(180-(90-vth0));
    vpl2dy=vdbeam*sind(180-(90-vth0));
    %vpos(1,:,8)=[vpc2(i,1)+vpl2dx,vpc2(i,2)+vpl2dy,0];
    vpos(1,:,8)=vpos(1,:,2)+[vpl2dx,vpl2dy,0];
    
    
end
% vpl3
if vcels>=9
    % vpos(1,:,9)=vpc0+[-vbeam/2  vlen 0];
    vpl3dx=vdbeam*cosd(180-(90-vth0));
    vpl3dy=vdbeam*sind(180-(90-vth0));
    %vpos(1,:,9)=[vpc3(i,1)+vpl3dx,vpc3(i,2)+vpl3dy,0];
    vpos(1,:,9)=vpos(1,:,3)+[vpl3dx,vpl3dy,0];
    
    
end

% wetted areas for each cell
areacell(1)=vbeam*vdraft;
areacell(2)=vlen*vbeam;
areacell(3)=vbeam*vdraft;
areacell(4)=(vlen*vdraft*(1/3));
areacell(5)=(vlen*vdraft*(1/3));
areacell(6)=(vlen*vdraft*(1/3));
areacell(8)=(vlen*vdraft*(1/3));
areacell(7)=(vlen*vdraft*(1/3));
areacell(9)=(vlen*vdraft*(1/3));

% script check
%disp('data_cells.m - OK')
