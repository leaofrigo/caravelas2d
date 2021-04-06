 load ('../simulations_paraguai/200x33/section_10_calibration_1.mat', 'vpc','vth')

simul_xpos=vpc(1,1)
simul_ypos=vpc(1,2)
vessel_angle=vth(1);
clear vpc
clear vth

save input_data_santana_down

clear all

clc