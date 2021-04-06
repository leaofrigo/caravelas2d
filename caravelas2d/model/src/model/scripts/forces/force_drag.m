% drag force calculation

if check_drag==1
    % vessel-current overall velocity difference
    if i==1
        vv(i,:)=[vivel];	% vessel initial velocity
        for n=1:vcels
            vdv(i,:,n)=vvcels(i,:,n)-vv(i,:);	% velocity difference from the cells (field) and the vessel
            vdvmag(i,n)=norm(vdv(i,:,n));	% vdv mag to be used in the drag equation
        end
    else
        for n=1:vcels
            vdv(i,:,n)=vvcels(i,:,n)-vv(i-1,:);	% velocity difference from the cells (field) and the vessel
            vdvmag(i,n)=norm(vdv(i,:,n));	% vdv mag to be used in the drag equation
        end
    end
    
    % flow velocity calculation for drag friction and pressure direction
    for n=1:vcels
        % velocity direction in the bow and stern
        if n==1 || n==3
            vflow=norm(vvcels(i,:,n));	% flow velocity magnitude
            vflowth=rcurvelth(i,n);	% flow velocity direction
            if i==1
                vesselth=vth0;	% vessel direction
            else
                vesselth=vth(i-1);
            end
            dthflow=abs(vflowth-vesselth);	% angle direction difference vessel-flow
            % velocity friction direction
            vfricmod(i,n)=abs(sind(dthflow))*vflow;	% flow velocity magnitude in the friction (parallel) direction
            vfric(i,:,n)=vfricmod(i,n)*[cosd(vflowth) sind(vflowth) 0];	% flow velocity in the friction (parallel) direction
            % velocity pressure direction
            vpressmod(i,n)=abs(cosd(dthflow))*vflow;	% flow velocity magnitude in the pressure (normal) direction
            vpress(i,:,n)=vpressmod(i,n)*[cosd(vflowth) sind(vflowth) 0];	% flow velocity in the pressure (normal) direction
        end
        % velocity direction in the port side
        if n==4 || n==5 || n==6
            vflow=norm(vvcels(i,:,n));	% flow velocity magnitude
            vflowth=rcurvelth(i,n);	% flow velocity direction
            if i==1
                vesselth=vth0;	% vessel direction
            else
                vesselth=vth(i-1);
            end
            dthflow=abs(vflowth-vesselth);	% angle direction difference vessel-flow
            % velocity friction direction
            vfricmod(i,n)=abs(cosd(dthflow))*vflow;	% flow velocity magnitude in the friction (parallel) direction
            vfric(i,:,n)=vfricmod(i,n)*[cosd(vflowth) sind(vflowth) 0];	% flow velocity in the friction (parallel) direction
            % velocity pressure direction
            vpressmod(i,n)=abs(sind(dthflow))*vflow;	% flow velocity magnitude in the pressure (normal) direction
            vpress(i,:,n)=vpressmod(i,n)*[cosd(vflowth) sind(vflowth) 0];   % flow velocity in the pressure (normal) direction
        end
        % velocity direction in the starboard side
        if n==7 || n==8 || n==9
            vflow=norm(vvcels(i,:,n));	% flow velocity magnitude
            vflowth=rcurvelth(i,n);	% flow velocity direction
            if i==1
                vesselth=vth0;	% vessel direction
            else
                vesselth=vth(i-1);
            end
            dthflow=abs(vflowth-vesselth);	% angle direction difference vessel-flow
            % velocity friction direction
            vfricmod(i,n)=abs(cosd(dthflow))*vflow;	% flow velocity magnitude in the friction (parallel) direction
            vfric(i,:,n)=vfricmod(i,n)*[cosd(vflowth) sind(vflowth) 0];	% flow velocity in the friction (parallel) direction
            % velocity pressure direction
            vpressmod(i,n)=abs(sind(dthflow))*vflow;	% flow velocity magnitude in the pressure (normal) direction
            vpress(i,:,n)=vpressmod(i,n)*[cosd(vflowth) sind(vflowth) 0];	% flow velocity in the pressure (normal) direction
        end
    end
    
    % vessel velocity difference for drag friction and pressure direction
    if i==1
        vvmag(i)=norm(vv(i,:)); % vessel velocity magnitude
        vvth(i)= mod((atan2d(vv(i,2),vv(i,1))+360),360);	% vessel velocity direction (due to vv)
    else
        vvmag(i)=norm(vv(i-1,:));   % vessel velocity magnitude
        vvth(i)= mod((atan2d(vv(i-1,2),vv(i-1,1))+360),360);	% vessel velocity direction (due to vv)
    end
    if i==1
        dthvv(i)=abs(vvth(i)-vth0);	% angle difference for velocity vector on the vessel and vessel direction
    else
        dthvv(i)=abs(vvth(i)-vth(i-1));	% angle difference for velocity vector on the vessel and vessel direction
    end
    for n=1:vcels
        if n==1 || n==3
            % velocity pressure direction
            vvpressmod(i,n)=abs(cosd(dthvv(i)))*vvmag(i);	% vessel velocity magnitude in the pressure (normal)
            vvpress(i,:,n)=vvpressmod(i,n)*[cosd(vvth(i)) sind(vvth(i)) 0];	% vessel velocity in the pressure (normal) direction
            % velocity friction direction
            vvfricmod(i,n)=abs(sind(dthvv(i)))*vvmag(i);	% vessel velocity magnitude in the friction (parallel) direction
            vvfric(i,:,n)=vvfricmod(i,n)*[cosd(vvth(i)) sind(vvth(i)) 0];	% vessel velocity in the friction (parallel) direction
        end
        if n==4 || n==5 || n==6 || n==7 || n==8 || n==9
            % velocity pressure direction
            vvpressmod(i,n)=abs(sind(dthvv(i)))*vvmag(i);	% vessel velocity magnitude in the pressure (normal)
            vvpress(i,:,n)=vvpressmod(i,n)*[cosd(vvth(i)) sind(vvth(i)) 0];	% vessel velocity in the pressure (normal) direction
            % velocity friction direction
            vvfricmod(i,n)=abs(cosd(dthvv(i)))*vvmag(i);	% vessel velocity magnitude in the friction (parallel) direction
            vvfric(i,:,n)=vvfricmod(i,n)*[cosd(vvth(i)) sind(vvth(i)) 0];	% vessel velocity in the pressure (normal) direction
        end
    end
    
    % pressure drag force calculation
    for n=1:vcels
        vdvpress(i,:,n)=vpress(i,:,n)-vvpress(i,:,n);	% vessel-current velocity difference in pressure (normal) direction
        vdvpressmag(i,n)=norm(vdvpress(i,:,n));	% vessel-current velocity magnitude difference in pressure (normal) direction
        vdvpressth(i,n)=mod((atan2d(vdvpress(i,2,n),vdvpress(i,1,n))+360),360);
    end
    for n=1:vcels
        vfdpressmag(i,n)=0.5*(vcdrag)*(areacell(n))*(rho)*(((vdvpressmag(i,n))).*(vdvpressmag(i,n))); % troquei aqui
        vfdpress(i,:,n)=vfdpressmag(i,n)*[cosd(vdvpressth(i,n)) sind(vdvpressth(i,n)) 0];
        vfdpressthres(i,:)=mod((atan2d(vfdpress(i,2,n),vfdpress(i,1,n))+360),360);
    end
    
    % friction drag force calculation
    for n=1:vcels
        vdvfric(i,:,n)=vfric(i,:,n)-vvfric(i,:,n);	% vessel-current velocity difference in friction (parallel) direction
        vdvfricmag(i,n)=norm(vdvfric(i,:,n));   % vessel-current velocity magnitude difference in friction (parallel) direction
        vdvfricth(i,n)=mod((atan2d(vdvfric(i,2,n),vdvfric(i,1,n))+360),360);
    end
    for n=1:vcels
        vfdfricmag(i,:,n)=0.5*(vcfric)*(areacell(n)+(areacell(2)/8))*(rho)*(((vdvfricmag(i,n))).*(vdvfricmag(i,n))); % troquei aqui
        vfdfric(i,:,n)=vfdfricmag(i,n)*[cosd(vdvfricth(i,n)) sind(vdvfricth(i,n)) 0];
        vfdfricthres(i,:)=mod((atan2d(vfdfric(i,2,n),vfdfric(i,1,n))+360),360);
    end
    
    % resultant drag force
    vfd(i,:,:)=vfdfric(i,:,:)+vfdpress(i,:,:);
    
    for n=1:vcels
        vfdmag(i,:,n)=norm(vfd(i,:,n));
    end
    vfdthres(i,:)=mod((atan2d(vfd(i,2,n),vfd(i,1,n))+360),360);
else
    vfd(i,:,:)=0;
    for n=1:vcels
        vfdmag(i,:,n)=norm(vfd(i,:,n));
    end
    vfdthres(i,:)=mod((atan2d(vfd(i,2,n),vfd(i,1,n))+360),360);
end

% script check
%disp('force_drag - OK')
