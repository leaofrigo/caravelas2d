% resulant force and direction

% resulant force and direction for each cell
for n=1:vcels
	vrsf(i,:,n)=vfd(i,:,n)+vfl(i,:,n)+vfad(i,:,n)+vfeng(i,:,n)+vfrud(i,:,n);
    %vrsf(i,:,n)=vfl(i,:,n)+vfad(i,:,n)+vfeng(i,:,n)+vfrud(i,:,n);

end

% resultant force and direction for the vessel
for n=1:vcels
	vrsf_aux(n,:)=vfd(i,:,n)+vfl(i,:,n)+vfad(i,:,n)+vfeng(i,:,n)+vfrud(i,:,n);
   	%vrsf_aux(n,:)=vfl(i,:,n)+vfad(i,:,n)+vfeng(i,:,n)+vfrud(i,:,n);

end
if vcels==1
	vrsf_res(i,:)=vrsf_aux;
else  
	vrsf_res(i,:)=sum(vrsf_aux)+vfrot(i,:); 
end

% calculation of resultant acceleration
vares(i,:)=((vrsf_res(i,:))/(vmass));
varesmag(i)=norm(vares(i,:));
varesth(i)=mod((atan2d(vares(i,2),vares(i,1))+360),360);

% script check
%disp('force_result - OK')
