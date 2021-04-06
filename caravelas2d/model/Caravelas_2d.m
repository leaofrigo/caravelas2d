% Caravelas 2D main program - ssh% date march/2017
% date march / 2017

folderName = fullfile(pwd);
p = genpath(folderName);
addpath(p);

% operational system selection
if ispc==1
    s1=1;
else
    s1=2;
end

% delete old files
if s1==1
    opsys=1;
    % delete old temporary file
    try
        delete output\mat_files\*.mat
    catch
        % no file
    end
else
    opsys=2;
    % delete old temporary file
    try        delete output/mat_files/*.mat
    catch
        % no file
    end
end

folder_current=pwd;
if opsys==1
    folder_destiny=strcat(folder_current,'\src\model\vessel_motion.m');
    run (folder_destiny);
else
    folder_destiny=strcat(folder_current,'/src/model/vessel_motion.m');
    run (folder_destiny);
end
