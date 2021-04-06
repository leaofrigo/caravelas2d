% lift force calculation

if check_lift==1
    for n=1:vcels
        vfl(i,:,n)=0;
    end
else
    vfl(i,:,n)=0;
end

% script check
%disp('force_lift - OK')
