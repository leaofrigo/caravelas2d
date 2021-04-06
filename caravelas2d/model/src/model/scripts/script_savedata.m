% save simulation data

if ispc==1
    filetemp=fix(clock);
    save_data_filename=strcat('..\..\..\output\sim_files\section_',num2str(nsection),'_calibration_',num2str(ical),'.mat');
    save('..\output\simulation_output.mat')
    save(save_data_filename);
else
    filetemp=fix(clock);
    save_data_filename=strcat('../../../output/sim_files/section_',num2str(nsection),'_calibration_',num2str(ical),'.mat');
    save('../output/simulation_output.mat')
    save(save_data_filename);
end

%% script check
%disp('script_savedata - OK')
