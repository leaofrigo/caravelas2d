% create new input data
%clear all
clc

keepvars={'cal_auto',
'cal_comb',
'cal_comb_aux',
'cal_engine',
'cal_fric',
'cal_mass',
'cal_npar',
'cal_parameters',
'cal_press',
'cal_result',
'cal_rudder',
'cal_tstep',
'calibrate_autopilot',
'calibrate_drag_fric',
'calibrate_drag_press',
'calibrate_engine',
'calibrate_mass',
'calibrate_rudderforce',
'calibrate_tstep',
'calibration_result',
'iq',
'ncal',
'sort_repeat',
'nsection',
'totalsections',
'ical',
'autopilot',
'check_addedmass',
'check_drag',
'check_engine',
'check_lift',
'check_river_flow_measured',
'check_river_flow_synthetic',
'check_river_parameters_measured',
'check_river_parameters_synthetic',
'check_rotational',
'check_rudder',
'eventdata',
'opsys',
'simul_flowangle',
'simul_flowvel',
'simul_time',
'simul_tstep',
'simul_xpos',
'simul_ypos',
'var_aux',
'vesse_angle',
'vessel_angle',
'vessel_beam',
'vessel_bowforce',
'vessel_draft',
'vessel_engine',
'vessel_length',
'vessel_mass',
'vessel_velocity'};

clearvars('-except', keepvars{:});

if nsection==1
    load('input_data.mat')
    save (strcat('input_data_section_',num2str(nsection),'.mat'))
else
    load (strcat('output/sim_files/','section_',num2str(nsection-1),'_calibration_',num2str(ical),'.mat'),'vpc','vth')
    simul_xpos=vpc(end,1,2);
    simul_ypos=vpc(end,2,2);
    vessel_angle=vth(end);
    clear vpc
    clear vth
    save input_data
end
