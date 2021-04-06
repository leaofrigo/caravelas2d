% river flow data input

% load shp flow data
if check_river_flow_measured==1
    % flow dimension
    ndim=1; % one dimensional flow [1 or 2]
    
    % read matfile
    if ispc==1
        shp2read1='flow\flow_data.mat';
    else
        shp2read1='flow/flow_data.mat';
    end
    load (shp2read1);
    
    % one dimensional flow
    if ndim==1
        % shape size
        size_shape1=max(size(flow_field));
        % vectors
        xq_shp=zeros(size_shape1(1),1);
        yq_shp=zeros(size_shape1(1),1);
        vvabs_shp=zeros(ni,1);
        % load velocity points position
        for i_shp=1:size_shape1(1)
            xq_shp(i_shp) = flow_field(i_shp,1); % velocity point longitude
            yq_shp(i_shp) = flow_field(i_shp,2); % velocity point latitude
        end
        flow_dir_shp=1;
    end
    
    % two dimensional flow
    if ndim==2
        % shape size
        size_shape1=size(S1);
        % vectors
        xq_shp=zeros(size_shape1(1),1);
        yq_shp=zeros(size_shape1(1),1);
        vvabs_shp=zeros(ni,1);
        % load velocity points position
        for i_shp=1:size_shape1(1)
            xq_shp(i_shp) = S1(i_shp).X; % velocity point longitude
            yq_shp(i_shp) = S1(i_shp).Y; % velocity point latitude
        end
        flow_dir_shp=1;
    end
end
% script check
%disp('data_flow - OK')
