  % vessel motion calculation

%% vessel motion calculation
if i==1
    vv(i,:)=vivel;
else
    for n=1:vcels
        vds(i,:)=dt*vv(i-1,:)+0.5*vares(i-1,:)*dt^2;
        vpos(i,:,n)=vpos(i-1,:,n)+vds(i,:);
        vv(i,:)=vv(i-1,:)+vares(i-1,:)*dt;
    end
end

dvfroude=[vv(i,1)-(vvcels(i,1,2).*cosd(rcurvelth(i)))  vv(i,2)-(vvcels(i,2,2).*sind(rcurvelth(i)))];
vfroude(i)=(norm(dvfroude)/sqrt(ag*vdraft));


%% script check
%disp('script_motion - OK')
