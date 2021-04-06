% added mass force calculation

if check_addedmass==1
    for n=1:vcels
        vfad(i,:,n)=0;
        
        %vfad_fx=
        %vfad_fy=
        %vfad_mz=
        
    end
else
    vfad(i,:,:)=0;
end

% script check
%disp('force_addedmass - OK')
