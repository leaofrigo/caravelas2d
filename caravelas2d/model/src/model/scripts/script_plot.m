% plot results scripts

% figure parameters
boxlinewidth=2.0;

%% figure 1 - ship position
figure (1)
boxlinewidth=2.0;
axes1 = axes('Parent',figure(1),'LineWidth',boxlinewidth,...
    'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');
% ship simulation position
for i=1:8000
    if i==1 || mod(i,500)==0
    %if i==1 || i==2000 
    %if i==ni || i==ni ||i==ni % plot every 100 time-step period wheres mod stuff
    h=plot(X(i,:),Y(i,:),'LineWidth',1.5,'Color',[0 0 0]);
        axis([vpc(i,1,2)-600 vpc(i,1,2)+600 vpc(i,2,2)-600 vpc(i,2,2)+600])
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
        %title('Ship position','Interpreter','tex','FontSize',40,'FontName','Times');
        set(legend,'Interpreter','tex');
    end
end
plot (fairway_path(:,1),fairway_path(:,2),'-b')
plot (right_margin(:,1),right_margin(:,2))
plot (left_margin(:,1),left_margin(:,2))
% ship data position
% if check_river_flow_measured==1
%     % dbf/shp data ship result
%     % read shp/dbf
%     s3=shaperead('../data/baw_shapefiles/MR_ship_passages_HSQ_MI/B1_TMS_Niklas_11012012_MR.dbf');
%     % shape size
%     size_shape=size(S3);
%     % ship points
%     X_shp=zeros(size_shape(1,1),5);
%     Y_shp=zeros(size_shape(1,1),5);
%     % ship center of mass
%     for n=1:size_shape(1,1)
%         P1=[s3(n).X(1) s3(n).Y(1)];
%         P2=[s3(n).X(2) s3(n).Y(2)];
%         P3=[s3(n).X(3) s3(n).Y(3)];
%         P4=[s3(n).X(4) s3(n).Y(4)];
%         % X,Y for fill
%         X_shp(n,:)=[P1(1,1) P2(1,1) P3(1,1) P4(1,1) P1(1,1)];
%         Y_shp(n,:)=[P1(1,2) P2(1,2) P3(1,2) P4(1,2) P1(1,2)];
%     end
%     % fill polygon
%     for n=1:size_shape(1,1)
%         plot(X_shp(n,:),Y_shp(n,:),'b')%, [0.0, 0.0, 0.0], 'edgecolor','black','facealpha', 0.3, 'linewidth',1);
%     end
% else
% end
set(gca,'LooseInset',get(gca,'TightInset'))
% save function

%% figure 2 - velocity and simulation time
figure(2)
boxlinewidth=2.0;
axes1 = axes('Parent',figure(2),'LineWidth',boxlinewidth,...
    'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');
dtshift=0.0:dt:simul_time-dt;
dtmarker=ni/60; %sempre =60 60 pontos no plot
h=plot (dtshift(1:dtmarker:end),abs(vv(1:dtmarker:end,1)),'-')
plot (dtshift(1:dtmarker:end),abs(vv(1:dtmarker:end,2)),'-')
vvabs=sqrt((vv(:,1)+vv(:,2)).^2);
plot (dtshift(1:dtmarker:end),abs(vvabs(1:dtmarker:end)),'-')
ylabel('Velocity (m/s)','Interpreter','tex','FontSize',40,'FontName','Times');
xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
set(gca,'LooseInset',get(gca,'TightInset'))
% save function

%% figure 3 - force and simulation time
figure(3)
boxlinewidth=2.0;
axes1 = axes('Parent',figure(3),'LineWidth',boxlinewidth,...
    'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');
dtshift=0.0:dt:simul_time-dt;
dtmarker=ni/60; %sempre =60 60 pontos no plot
plot (dtshift(1:dtmarker:end),vrsf_res(1:dtmarker:end,1),'-')
plot (dtshift(1:dtmarker:end),vrsf_res(1:dtmarker:end,2),'-')
ylabel('Force (N)','Interpreter','tex','FontSize',40,'FontName','Times');
xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
set(gca,'LooseInset',get(gca,'TightInset'))
% save function

%% figure 4 - vessel angle and simulation time
figure(4)
boxlinewidth=2.0;
axes1 = axes('Parent',figure(4),'LineWidth',boxlinewidth,...
    'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');
dtshift=0.0:dt:simul_time-dt;
dtmarker=ni/60; %sempre =60 60 pontos no plot
vthwrap=wrapTo360(vth);
plot (dtshift(1:dtmarker:end),(vthwrap(2:dtmarker:end)));
ylabel('Vessel angle','FontSize',40,'FontName','Times');
xlabel('Simulation time (s)','FontSize',40,'FontName','Times');
set(gca,'LooseInset',get(gca,'TightInset'))
% save function

%% figure 5 - froude number
% boxlinewidth=2.0;
% axes1 = axes('Parent',figure(5),'LineWidth',boxlinewidth,...
%     'FontName','Times New Roman');
% box(axes1,'on');
% hold(axes1,'all');
% dtshift=0.0:dt:simul_time-dt;
% plot (dtshift(1:1:end),vfroude(:,1))
% ylabel('Froude number (-)','Interpreter','tex','FontSize',40,'FontName','Times');
% xlabel('Simulation time (s)','Interpreter','tex','FontSize',40,'FontName','Times');
% set(gca,'LooseInset',get(gca,'TightInset'))
% % save function

%% figure 6 - forces bow/port
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
% save function


%% figure 7 - forces bow/port
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
% save function

%% Drag force x velocity
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
