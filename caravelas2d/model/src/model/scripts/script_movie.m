figure(10)
boxlinewidth=2.0;
axes1 = axes('Parent',figure(10),'LineWidth',boxlinewidth,...
    'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');

% limits
p0i_outpt=1;
p0f_outpt=ni;

% movie aux
nn=1;
for i=p0i_outpt:p0f_outpt
    if i==1 || mod(i,10)==0
    h=plot(X(i,:),Y(i,:),'LineWidth',1.5,'Color',[0 0 0]);
        axis([vpc(i,1,2)-300 vpc(i,1,2)+300 vpc(i,2,2)-300 vpc(i,2,2)+300])
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
    hold('on')
    xlabel ('Lon (m)');
    ylabel ('Lat (m)');
    set(legend,'Interpreter','latex');
             %text(vpc(i,1,2)-275, vpc(i,2,2) - 100*1,strcat('TMS Niklas - Rhine'),'HorizontalAlignment','left')
             text(vpc(i,1,2)-275, vpc(i,2,2) - 150*1,strcat('T(s)= ',num2str(i)),'HorizontalAlignment','left')
             text(vpc(i,1,2)-275, vpc(i,2,2) - 200*1,strcat('V(m/s)= ',num2str(norm(vv(i,1:2)))),'HorizontalAlignment','left')
             text(vpc(i,1,2)-275, vpc(i,2,2) - 250*1,strcat('Ang(o)=',num2str(vth(i))),'HorizontalAlignment','left')
plot (fairway_path(:,1),fairway_path(:,2),'--b')
plot (right_margin(:,1),right_margin(:,2),'LineWidth',2)
plot (left_margin(:,1),left_margin(:,2),'LineWidth',2)
    M(nn)=getframe(gca);
    nn=nn+1;
    hold('off')
    end
end

%if ispc==1
% movie2avi(M,'output\media\vessel_motion.avi')
%else
% movie2avi(M,'output/media/vessel_motion.avi')
end
