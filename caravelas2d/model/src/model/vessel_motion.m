% calibration script for Caravelas 2D
% date march/2017

% clear memory
clear all
clc
tic

% initialize program
disp('Running Caravelas2D calibration')

% aux variables
cal_parameters=1;
cal_npar=0;

% select calibration parameter
calibrate_tstep=1;
calibrate_mass=1;
calibrate_drag_press=1;
calibrate_drag_fric=1;
calibrate_engine=1;
calibrate_rudderforce=1;
calibrate_autopilot=1;

% select parameter range
if calibrate_tstep==1           %[1]
    cal_tstep=[0.1];
    cal_parameters=cal_parameters*numel(cal_tstep);
    cal_npar=cal_npar+1;
end
if calibrate_mass==1            %[2]
    cal_mass=[7e+6 * 0.5];
    cal_parameters=cal_parameters*numel(cal_mass);
    cal_npar=cal_npar+1;
end
if calibrate_drag_fric==1       %[3]
    cal_fric=[0.005]; %correto
    cal_parameters=cal_parameters*numel(cal_fric);
    cal_npar=cal_npar+1;
end
if calibrate_drag_press==1      %[4]
    cal_press=[0.5];
    cal_parameters=cal_parameters*numel(cal_press);
    cal_npar=cal_npar+1;
end
if calibrate_engine==1          %[5]
    cal_engine=[8.5e+5*(1)];
    %maxspeed=3.5
    %cal_engine=[0.0];
    cal_parameters=cal_parameters*numel(cal_engine);
    cal_npar=cal_npar+1;
end
if calibrate_rudderforce==1
    %cal_rudder=cal_engine*[1];
    %cal_rudder=cal_engine*[1];
    
    cal_rudder=cal_engine*[0.5]; % trocado aqui
    %cal_rudder=cal_engine*[0.5]; % trocado aqui
    
    %cal_rudder=[0.25e+5:0.25e+5:2e+5];
    cal_parameters=cal_parameters*numel(cal_rudder);
    cal_npar=cal_npar+1;
end
% autopilot
if calibrate_autopilot==1
    %cal_auto=[0    45    90   135   180   225   270   315   360];             %[7]
    cal_auto=[0];
    cal_parameters=cal_parameters*numel(cal_auto);
    cal_npar=cal_npar+1;
end

% allocate vector for result
ncal=cal_parameters;
cal_result=zeros(cal_parameters,2);
cal_comb_aux=0;
cal_comb=zeros(ncal,7);
calibration_result=zeros(ncal,3);

% sort matrix of parameteres
sort_repeat=1;
for iq=1:ncal
    while sort_repeat==1
        if calibrate_tstep==1
            cal_comb_aux(1)=cal_tstep(randperm(numel(cal_tstep),1));
        else
            cal_comb_aux(1)=0;
        end
        if calibrate_mass==1
            cal_comb_aux(2)=cal_mass(randperm(numel(cal_mass),1));
        else
            cal_comb_aux(2)=0;
        end
        if calibrate_drag_fric==1
            cal_comb_aux(3)=cal_fric(randperm(numel(cal_fric),1));
        else
            cal_comb_aux(3)=0;
        end
        if calibrate_drag_press==1
            cal_comb_aux(4)=cal_press(randperm(numel(cal_press),1));
        else
            cal_comb_aux(4)=0;
        end
        if calibrate_engine==1
            cal_comb_aux(5)=cal_engine(randperm(numel(cal_engine),1));
        else
            cal_comb_aux(5)=0;
        end
        if calibrate_rudderforce==1
            cal_comb_aux(6)=cal_rudder(randperm(numel(cal_rudder),1));
        else
            cal_comb_aux(6)=0;
        end
        if calibrate_autopilot==1
            cal_comb_aux(7)=cal_auto(randperm(numel(cal_auto),1));
        else
            cal_comb_aux(7)=0;
        end
        cal_comb(iq,:)=cal_comb_aux(:);
        if ismember(cal_comb_aux,cal_comb(1:iq-1,:),'rows')==1
            sort_repeat=1;
        else
            sort_repeat=0;
        end
    end
    sort_repeat=1;
end

% number of sections
totalsections=1;


for nsection=1:totalsections
    
    if ispc==1
        run ('..\..\create_inputdata.m');
    else
        run ('../../create_inputdata.m');
    end
    
    
    for ical=1:ncal
        disp(strcat('section:',num2str(nsection)))
        display=['Iteration',' ',num2str(ical),' ','of',' ',num2str(ncal)];
        disp(display)
        % load input data
        load('input_data.mat')
        
        % time-step
        if calibrate_tstep==1
            simul_tstep=cal_comb(ical,1);
        else
            % load from input data
        end
        
        % mass
        if calibrate_mass==1
            vessel_mass=cal_comb(ical,2);
        else
            % load from input data
        end
        
        % drag
        if calibrate_drag_fric==1
            vcfric=cal_comb(ical,3);
        else
            vcfric=0.005;
        end
        if calibrate_drag_press==1
            vcdrag=cal_comb(ical,4);
        else
            vcdrag=1.0;
        end
        
        % engine
        if calibrate_engine==1
            vessel_engine=cal_comb(ical,5);
        else
            % load from input data
        end
        
        % rudder
        if calibrate_rudderforce==1
            vessel_bowforce=cal_comb(ical,6);
        else
            % load from input data
        end
        
        % autopilot
        if calibrate_autopilot==1
            vess_ang_cal=cal_comb(ical,7);
        else
            % load from input data
        end
        
        if ispc==1
            %disp ('loading simulation data');
            run ('input\data_simulation.m');
            %disp ('loading current data');
            run ('input\data_flow.m');
            %disp ('loading vessel data');
            run ('input\data_ship.m');
            %disp ('loading fairway data');
            run ('input\data_fairway.m');
            %disp ('loading variable list');
            run ('input\data_variables.m');
            %disp ('loading cells data');
            run ('input\data_cells.m');
            % start simulation
            for i=1:ni
                if i==1
                    disp('Simulation running')
                end
                %disp ('vessel position script');
                run ('scripts\script_position.m');
                %disp ('velocity field script');
                run ('scripts\script_field.m');
                %disp ('vessel force script');
                run ('scripts\script_force.m');
                %disp ('vessel resultant motion script');
                run ('scripts\script_motion.m');
                %disp ('vessel resultant torque script');
                run ('scripts\script_torque.m');
                %disp ('vessel constrain script');
                run ('scripts\script_constrain.m');
                %disp ('vessel autopilot script');
                run ('scripts\script_autopilot.m');
            end
            % output data script
            run ('scripts\script_savedata.m');
            % save msg
            filetemp=fix(clock);
            savemsg=strcat('File saved as:   ', '\output\sim_files\',num2str(filetemp(1)),'',num2str(filetemp(3)),...
                '_',num2str(filetemp(2)),'_',num2str(filetemp(4)),':',num2str(filetemp(5)));
            %h = msgbox(savemsg,'Success');
            toc
        else %running for unixOS/macOS
            %disp ('loading simulation data');
            run ('input/data_simulation.m');
            %disp ('loading current data');
            run ('input/data_flow.m');
            %disp ('loading vessel data');
            run ('input/data_ship.m');
            %disp ('loading fairway data');
            run ('input/data_fairway.m');
            %disp ('loading variable list');
            run ('input/data_variables.m');
            %disp ('loading cells data');
            run ('input/data_cells.m');
            % start simulation
            for i=1:ni
                display=['Iteration',' ',num2str(i),' ','of',' ',num2str(ni)];
                %disp(display)
                if i==1
                    disp('Simulation running')
                end
                %disp ('vessel position script');
                run ('scripts/script_position.m');
                %disp ('velocity field script');
                run ('scripts/script_field.m');
                %disp ('vessel force script');
                run ('scripts/script_force.m');
                %disp ('vessel resultant motion script');
                run ('scripts/script_motion.m');
                %disp ('vessel resultant torque script');
                run ('scripts/script_torque.m');
                %disp ('vessel constrain script');
                run ('scripts/script_constrain.m');
                %disp ('vessel autopilot script');
                run ('scripts/script_autopilot.m');
            end
            % output data script
            run ('scripts/script_savedata.m');
            % save msg
            filetemp=fix(clock);
            savemsg='Simulation done';
            % temporary here
            if i==ni
                velnorm=zeros(ni,1);
                for j=1:ni
                    velnorm(j)=norm(vv(j,1:2));
                end
            end
        end
    end
end
