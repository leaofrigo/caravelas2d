%  output data script
clf('reset')

%%  figure 1
fig2plot=1;
if fig2plot==1
    figure(1);
    axes('Parent',figure(1),...
        'LineWidth',1,...
        'fontsize',15,...
        'FontName','Times');
    p0i_outpt=3000;
    p0f_outpt=3100;
    for i=p0i_outpt:p0f_outpt
        %pause(0.01);
        if i==1 || mod(i,i)==0
            h=plot(X(i,:),Y(i,:),'LineWidth',1.5,'Color',[0 0 0]);
            axis([vpc(i,1,2)-300 vpc(i,1,2)+300 vpc(i,2,2)-300 vpc(i,2,2)+300])
            greenbean = [vpr3(i,1) vpr3(i,2) 1 1];
            rectangle('Position',greenbean,'Curvature',[1 1],...
                'Curvature',[1,1],...
                'FaceColor','g');
            redbean = [vpl3(i,1) vpl3(i,2) 1 1];
            rectangle('Position',redbean,'Curvature',[1 1],...
                'Curvature',[1,1],...
                'FaceColor','r');
            hold('on')
            xlabel ('X (m)');
            ylabel ('Y (m)');
            set(legend,'Interpreter','latex'); 
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*1,strcat('riv km= ',num2str(fairway_path(n(close_ok_point),4)/1000)),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*2,strcat('v= ',num2str(norm(vv(i,1:2)))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*3,strcat('rud= ',num2str(ruddir_vec(i))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*4,strcat('verf= ',num2str(verf(i))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*5,strcat('cang= ',num2str(p3ang(i))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*6,strcat('vth= ',num2str(vth(i))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*7,strcat('dp= ',num2str(norm(vpc(i,1:2,3) -  p2points(i,1:2)))),'HorizontalAlignment','left')
            text(vpc(i,1,2)-275, vpc(i,2,2) + 30*8,strcat('t= ',num2str(i)),'HorizontalAlignment','left')
            
            
            
            
            
            plot (fairway_path(:,1),fairway_path(:,2))
            M=getframe(figure(1));
            M_aux(i,:)=M;
            hold('off')
        end
    end
    
end
