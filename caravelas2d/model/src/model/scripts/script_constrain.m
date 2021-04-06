% vessel constrain analysis script

% river constrain points - margins
if i==ni
    constrain_points_right=right_margin;
    xq_right=(constrain_points_right(:,1));	% points of constrain
    yq_right=(constrain_points_right(:,2)); % points of constrain
    constrain_points_left=left_margin;
    xq_left=(constrain_points_left(:,1));	% points of constrain
    yq_left=(constrain_points_left(:,2)); 	% points of constrain
    
    % polygon position for each interaction
    xv = X;                       % polygon X
    yv = Y;                       % polygon Y
    
    % left margin
    [in_left,on_left] = inpolygon(xq_left,yq_left,xv(:),yv(:));
    cin_left=numel(xq_left(in_left));
    con_left=numel(xq_left(on_left));
    cout_left=numel(xq_left(~in_left));
    cin_left_index=find(in_left);
    con_left_index=find(on_left);
    
    % right margin
    [in_right,on_right] = inpolygon(xq_right,yq_right,xv(:),yv(:));
    cin_right=numel(xq_right(in_right));
    con_right=numel(xq_right(on_right));
    cout_right=numel(xq_right(~in_right));
    cin_right_index=find(in_right);
    con_right_index=find(on_right);    
end

%% script check
%disp('script_constrain - OK')
