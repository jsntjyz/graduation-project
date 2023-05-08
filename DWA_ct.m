function a = DWA_ct(Obs_Closed,Obs_dong,Area_MAX,Goal,Line_path,path_node,Start0)
figure
num_obc=size(Obs_Closed,1); %  �����ϰ��������
num_path=size(path_node,1);
xTarget=path_node(num_path,1);
yTarget=path_node(num_path,2);
%  path=[];
%  for i=1:1:(num_path-1)
%         pa=Line_pa(path_node(i,1),path_node(i,2),path_node(i+1,1),path_node(i+1,2));
%         path=[path;pa];
%  end
 


xm=path_node(1,1);
ym=path_node(1,2);
 % ��ʼλ������ 
 %angle_S=pi;
 %angle_node=sn_angle(path_node(1,1),path_node(1,2),path_node(2,1),path_node(2,2));
 
 %zhuangjiao_node=angle_S-angle_node;
x=[xm ym pi/2 0 0]';% �����˵ĳ���״̬ x=[x(m),y(m),yaw(Rad),v(m/s),w(rad/s)]
x_du=x;

%G_goal=path_node(num_path,:);% Ŀ���λ�� [x(m),y(m)]

 obstacle=[Obs_Closed;Obs_dong];
      
obstacleR=1.5;% ��ͻ�ж��õ��ϰ���뾶
global dt;  %   ȫ�ֱ���
dt=0.1;%   ʱ��[s]

% �������˶�ѧģ��
% [   ����ٶ�[m/s], �����ת�ٶ�[rad/s], ���ٶ�[m/ss], ��ת���ٶ�[rad/ss], �ٶȷֱ���[m/s], ת�ٷֱ���[rad/s]  ]
% Kinematic=[2.0, toRadian(40.0), 0.4, toRadian(100.0), 0.01, toRadian(1)]; Kinematic=[1, toRadian(20.0), 0.28, toRadian(55), 0.01, toRadian(1)];
%Kinematic=[1, toRadian(20.0), 0.2, toRadian(50), 0.01, toRadian(1)];
Kinematic=[1, toRadian(40.0), 0.4, toRadian(100.0), 0.01, toRadian(1)]; 
% [1.0, toRadian(20.0), 0.2, toRadian(50.0), 0.01, toRadian(1)];
% ���ۺ������� [heading,dist,velocity,predictDT][��λ��ƫ��ϵ���� �ϰ�����룬 ��ǰ�ٶȴ�С, Ԥ����ʱ�� ]
evalParam=[0.05,  0.2,  0.1,  3.0];%0.3 0.1 0.1   [0.05,  0.2,  0.1,  3.0]
MAX_X=Area_MAX(1,1);
MAX_Y=Area_MAX(1,2);
% ģ������Χ [xmin xmax ymin ymax]
% ģ��ʵ��Ľ��
result.x=[];
goal=path_node(2,:);

tic;
% movcount=0;
% Main loop
for i=1:5000
    % DWA��������
    %goal=path_node(num_path,:);
    
%    num_result=size(result.x,2);
    dang_node=[x(1,1) x(2,1)];
    dis_ng=distance(dang_node(1,1),dang_node(1,2),xTarget,yTarget);
    dis_x_du=distance(x_du(1,1),x_du(2,1),goal(1,1),goal(1,2));
%     if num_path==2||dis_ng<2
        Ggoal=[xTarget yTarget];
%     else
%         Ggoal=Target_node(dang_node,path_node,Obs_dong,xTarget,yTarget,goal,dis_x_du);
%     end
    goal=Ggoal;
    % obstacle=OBSTACLE(Obs_Closed,Obs_dong,path_node);
    
    [u,traj]=DynamicWindowApproach_ct(x,Kinematic,goal,evalParam,obstacle,obstacleR);
    % u = [ �ٶ� ת�� ] traj=[ 3s�ڵ�����״̬�켣 ]
    x=f(x,u);% �������ƶ�����һ��ʱ��
    x_du=f_du(x,u);% �������ƶ�����һ��ʱ��
    result.x=[result.x; x'];
    % ģ�����ı���
    
    
    % �Ƿ񵽴�Ŀ�ĵ�
  
    %if norm(x(1:2)-G_goal')<0.2
    if dis_ng<0.2
        disp('Arrive Goal!!');break;
    end
    
    %====Animation====
    hold off;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %  ��ͼ
   for i_obs=1:1:num_obc
         x_obs=Obs_Closed(i_obs,1);
         y_obs=Obs_Closed(i_obs,2);
         fill([x_obs,x_obs+1,x_obs+1,x_obs],[y_obs,y_obs,y_obs+1,y_obs+1],'k');hold on;
    end
     plot( Line_path(:,1)+.5, Line_path(:,2)+.5,'b:','linewidth',1); 
     plot(Start0(1,1)+.5,Start0(1,2)+.5,'b^');
    % text(Start0(1,1)+1,Start0(1,2)+1.5,'S','fontsize',18')
     plot(Goal(1,1)+.5,Goal(1,2)+.5,'bo');
%     for i_g=1:1:Goal_COUNT
%       x_go=Goal(i_g,1);
%       y_go=Goal(i_g,2);
%       plot(x_go+.5,y_go+.5,'bo');
%      % text(x_go+1,y_go+1.5,num2str(i_g,'T(%d)'),'fontsize',18');
%     end
%     dong_num=size(Obs_dong,1);
%     for i_d=1:1:dong_num
%       x_do=Obs_dong(i_d,1);
%       y_do=Obs_dong(i_d,2);
%       fill([x_do,x_do+1,x_do+1,x_do],[y_do,y_do,y_do+1,y_do+1],[0.8 0.8 0.8]);
%     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    ArrowLength=0.5;% 
    % ������
    quiver(x(1)+0.5,   x(2)+0.5,  ArrowLength*cos(x(3)),  ArrowLength*sin(x(3)),'ok');hold on;
    %  x=[x(m),y(m),yaw(Rad),v(m/s),w(rad/s)]
    plot(result.x(:,1)+0.5, result.x(:,2)+0.5,'-b');hold on;
    
    plot(goal(1)+0.5,goal(2)+0.5,'*r');hold on;
  
     
   % ̽���켣
  %  % traj = [ ����һ��5�� v w ��3s�ڵ�����״̬�켣 31���� 1-5��31�У�
  %             ���ڶ���5�� v w ��3s�ڵ�����״̬�켣 31���� 6-10��31�У�
  %           ������������]
    if ~isempty(traj)
        for it=1:length(traj(:,1))/5 % 
            ind=1+(it-1)*5;
            plot(traj(ind,:)+0.5,traj(ind+1,:)+0.5,'-g','linewidth',1.5);hold on;%%ģ��켣
        end
    end
%     axis(area);
%     grid on;


    axis([-1 MAX_X+2, -1 MAX_Y+2])                %%%  ����x��y��������
    set(gca,'xtick',0:1:MAX_X+1,'ytick',0:1:MAX_Y+1,'GridLineStyle','-',...
        'xGrid','on','yGrid','on');   
    grid on; 
    
    drawnow;
    %movcount=movcount+1;
    %mov(movcount) = getframe(gcf);% 
    
end

a=result.x;
toc
end
%movie2avi(mov,'movie.avi');