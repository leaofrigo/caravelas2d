% force script calculation

if ispc==1
    % drag force
    run ('forces\force_drag.m');
    % lift force
    run ('forces\force_lift.m');
    % rotation force
    run ('forces\force_rotation');
    % added mass force
    run ('forces\force_addmass');
    % thrust force
    run('forces\force_thrust');
    % rudder force calculation
    run('forces\force_rudder');
    % resultant force
    run('forces\force_result');
else
    % drag force
    run ('forces/force_drag.m');
    % lift force
    run ('forces/force_lift.m');
    % rotation force
    run ('forces/force_rotation');
    % added mass force
    run ('forces/force_addmass');
    % thrust force
    run('forces/force_thrust');
    % rudder force calculation
    run('forces/force_rudder');
    % resultant force
    run('forces/force_result');
end

% script check
%disp('script_force - OK')
