% output results scripts

% load data
if ispc==1
    load('src\gui\temp\temp_fig_check.mat')
else
    load('src/gui/temp/temp_fig_check.mat')
end

% figure parameters
boxlinewidth=2.0;

if fig_vessel_position==1
    % figure 1 - ship position
    figure (1)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(1),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    % ship simulation position
    hold('on')
    dtplot=30/dt;
    for i=1:ni
        if i==1 || mod(i,dtplot)==0
            h=plot(X(i,:),Y(i,:),'LineWidth',1.5,'Color',[0 0 0]);
            axis([vpc(i,1,2)-400 vpc(i,1,2)+400 vpc(i,2,2)-400 vpc(i,2,2)+400])
            greenbean = [vpr3(i,1) vpr3(i,2) 4 4];
            rectangle('Position',greenbean,'Curvature',[1 1],...
                'Curvature',[1,1],...
                'FaceColor','g');
            redbean = [vpl3(i,1) vpl3(i,2) 4 4];
            rectangle('Position',redbean,'Curvature',[1 1],...
                'Curvature',[1,1],...
                'FaceColor','r');
            ylabel('Latitude (m)','FontSize',40,'FontName','Times');
            xlabel('Longitude (m)','FontSize',40,'FontName','Times');
            set(legend,'Interpreter','tex');
            set(legend,'Interpreter','tex');
        end
    end
    plot (fairway_path(:,1),fairway_path(:,2),'-b')
    plot (right_margin(:,1),right_margin(:,2))
    plot (left_margin(:,1),left_margin(:,2))
end
if fig_vessel_velocity==1
    figure(2)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(2),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    dtshift=0.0:dt:simul_time-dt;
    dtmarker=ni/60; %sempre =60 60 pontos no plot
    h=plot (dtshift(1:dtmarker:end),abs(vv(1:dtmarker:end,1)),'-');
    plot (dtshift(1:dtmarker:end),abs(vv(1:dtmarker:end,2)),'-')
    vvabs=sqrt((vv(:,1)+vv(:,2)).^2);
    plot (dtshift(1:dtmarker:end),abs(vvabs(1:dtmarker:end)),'-')
    ylabel('Velocity (m/s)','Interpreter','tex','FontSize',40,'FontName','Times');
    xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_resforce==1
    figure(3)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(3),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    dtshift=0.0:dt:simul_time-dt;
    dtmarker=ni/60;
    plot (dtshift(1:dtmarker:end),vrsf_res(1:dtmarker:end,1),'-')
    plot (dtshift(1:dtmarker:end),vrsf_res(1:dtmarker:end,2),'-')
    ylabel('Force (N)','Interpreter','tex','FontSize',40,'FontName','Times');
    xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_yaw==1
    figure(4)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(4),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    dtshift=0.0:dt:simul_time-dt;
    dtmarker=ni/60; 
    vthwrap=wrapTo360(vth);
    plot (dtshift(1:dtmarker:end),(vthwrap(2:dtmarker:end)));
    ylabel('Vessel angle','FontSize',40,'FontName','Times');
    xlabel('Simulation time (s)','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_froude==1
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(5),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    dtshift=0.0:dt:simul_time-dt;
    plot (dtshift(1:1:end),vfroude(:,1))
    ylabel('Froude number (-)','Interpreter','tex','FontSize',40,'FontName','Times');
    xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_dragforce==1
    figure(6)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(6),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    dtshift=0.5:dt:simul_time;
    plot(dtshift(1:25:end),vrsf(1:25:end,1,3));
    plot(dtshift(1:25:end),vrsf(1:25:end,2,3));
    plot(dtshift(1:25:end),vrsf(1:25:end,1,5));
    plot(dtshift(1:25:end),vrsf(1:25:end,2,5));
    ylabel('Drag force (N)','Interpreter','tex','FontSize',40,'FontName','Times');
    xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_dragvel==1
    figure(7)
    boxlinewidth=2.0;
    axes1 = axes('Parent',figure(7),'LineWidth',boxlinewidth,...
        'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    vfdreslt=vfd(:,:,1)+ vfd(:,:,2) +  vfd(:,:,3) + vfd(:,:,4) + vfd(:,:,5) + vfd(:,:,6) +  vfd(:,:,7) + vfd(:,:,8) + vfd(:,:,9);
    for j=1:2
        plot (abs((vv(:,j))), abs(vfdreslt(:,j)))
    end
    secdegreg=(5327447 * vv(:,2).^2) -(1522305*vv(:,2)) + 71841.0;
    plot (vv(:,2),secdegreg)
    ylabel('Drag force (N)','Interpreter','tex','FontSize',40,'FontName','Times');
    xlabel('Velocity (m/s)','Interpreter','tex','FontSize',40,'FontName','Times');
    set(gca,'LooseInset',get(gca,'TightInset'))
end

if fig_vessel_movie==1
    if ispc==1
        folder_destiny=strcat('script_movie.m');
        run (folder_destiny);
    else
        folder_destiny=strcat('script_movie.m');
        run (folder_destiny);
    end
end