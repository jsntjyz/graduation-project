function [Path,distanceX,OPEN_num]= Astar_G_du(Obs_Closed,St,Ta,MAX_X,MAX_Y)

CLOSED = Obs_Closed;
xStart = St(1,1);      yStart = St(1,2); 
xTarget = Ta(1,1);    yTarget = Ta(1,2);

OPEN=[];
% ��յ��б�ṹ
Num_obs=size(Obs_Closed,1);
CLOSED_COUNT=size(CLOSED,1);   % CLOSED�����������ϰ���ĸ��� 
Nobs=CLOSED_COUNT;

xNode=xStart;      % =xStart
yNode=yStart;      % =yStart
OPEN_COUNT=1;    % OPEN_COUNT �����б��������־
path_cost=0;
goal_distance=distance(xNode,yNode,xTarget,yTarget);   %  ***����distance�������������������֮��ĵѿ�������
% Sgoal=goal_distance;
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);  %   ���뵽�����б�
%%%        OPEN����һ�е�Ԫ�أ�=��1��xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance����
OPEN(OPEN_COUNT,1)=0;      %%%   OPEN(1,1)=0
CLOSED_COUNT=CLOSED_COUNT+1;  %%%   CLOSED �洢���ϰ������һ����Ԫ
CLOSED(CLOSED_COUNT,1)=xNode; %%%   ��һ���洢��ʼ�������
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;

%% START ALGORITHM ��ʼ�㷨
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)       %%%  �жϵ�ǰ���Ƿ����Ŀ���
%% ���ӽڵ����չ 
 exp_array=expand_array3(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y,Nobs,xStart,yStart);  %%% ���ڹر��б���ӽڵ㣬��x,y,gn,hn,fn��,�����Ǹ�������ѡ����ӽڵ�����
 exp_count=size(exp_array,1);  %%%  ��ѡ����ӽڵ����
 
 for i=1:exp_count         %%% ��exp_array�ڵ�Ԫ����ӵ� �����б� ����
    flag=0;                %%% ��exp_array�ڵĵ�ı�־λ��Ϊ0
    for j=1:OPEN_COUNT         %%% OPEN_COUNT ��1��ʼ���Լ�
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )    %%%�жϿ�ѡ�ӽڵ��Ƿ���OPEN[]�еĵ���ͬ
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5));                       %%%�����ͬ���Ƚ�����fn��ֵ�Ĵ�С������fnС������㸳ֵ��OPEN(j,8)
            if OPEN(j,8)== exp_array(i,5)                                  %%% ��ʾ����һ���Ƚ��� exp_array(i,5)С�����exp_array(i,�����е�ֵ����OPEN��fn
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);  %hn
                OPEN(j,7)=exp_array(i,4);  %gn
            end;
            flag=1;                    %%%����ϣУţ���ͬ�ģ���磽1
        end;
%         if flag == 1
%             break;
    end;
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1; 
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%����Ԫ�ط���open list��
 end;

 %% �ҳ�fn��С�Ľڵ�
  index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);   %%%ѡ��fn��С��һ�У����������� index_min_node
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn ��xNode��yNode����Ϊ��Сfn�Ľڵ�
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);% Update the cost of reaching the parent node ���µ��︸�ڵ�ĳɱ�  gn
  
%    p_xNode=OPEN(index_min_node,4);
%    p_yNode=OPEN(index_min_node,5);
 %%  ���ڵ��ƶ����б�CLOSED  
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
   CLOSED  %%%****���CLOSE[]������ѧϰ�˽�A*�㷨���������**** 
   OPEN    %%%****���OPEN[]������ѧϰ�˽�A*�㷨���������****
  else
      NoPath=0;
  end;
end;

%% Ѱ������·��
i=size(CLOSED,1);    %%%CLOSE����ĳ���
Optimal_path=[];     %%%·������
xval=CLOSED(i,1);    %%%��CLOSE���һ��������������һ����ΪĿ���
yval=CLOSED(i,2);
i=1;
Optimal_path(i,1)=xval; %%%��Ŀ�������긳�� ·������� ��һ��
Optimal_path(i,2)=yval;
            

if ( (xval == xTarget) && (yval == yTarget))  %%%���CLOSE���һ���Ƿ�ΪĿ���
 
   % ����OPEN��ȷ�����ڵ�
   Target_ind=node_index(OPEN,xval,yval);
   parent_x=OPEN(Target_ind,4); % ���ؽڵ������
   parent_y=OPEN(Target_ind,5); % ����ǰ��ĸ��ڵ������
   Optimal_path(i,3)=parent_x; 
   Optimal_path(i,4)=parent_y;
   
 while( parent_x ~= xStart || parent_y ~= yStart)   % �жϸ��ڵ��Ƿ�Ϊ��ʼ��
           i=i+1; 
           Optimal_path(i,1) = parent_x;             %%% ���� �򽫸��ڵ��͸�·������
           Optimal_path(i,2) = parent_y;
          
           inode=node_index(OPEN,parent_x,parent_y); 
           
           Optimal_path(i,3) = OPEN(inode,4);
           Optimal_path(i,4) = OPEN(inode,5);
           parent_x=Optimal_path(i,3);
           parent_y=Optimal_path(i,4);
        
 end;
  Num_Opt=size(Optimal_path,1);
  
 
 %%  �Ż�����,�ж��Ƿ����ϰ����谭���ж��ӽڵ�͸��ڵ��Ƿ���ͬһ��ֱ����
 Optimal_path
 Optimal_path_one=Line_OPEN_ST(Optimal_path,CLOSED,Num_obs,Num_Opt)

%% ��ȡ��򻯵�·����������Ҫ����Ľڵ����

 Optimal_path_try=[1 1 1 1];
 Optimal_path=[1 1 ];%node_l=[1 1];
 i=1;q=1;
 x_g=Optimal_path_one(Num_Opt,3);y_g=Optimal_path_one(Num_Opt,4);
 
 Optimal_path_try(i,1)= Optimal_path_one(q,1);
 Optimal_path_try(i,2)= Optimal_path_one(q,2);
 Optimal_path_try(i,3)= Optimal_path_one(q,3);
 Optimal_path_try(i,4)= Optimal_path_one(q,4);
 
   while (Optimal_path_try(i,3)~=x_g || Optimal_path_try(i,4)~=y_g)
      i=i+1;
      q=Optimal_index(Optimal_path_one,Optimal_path_one(q,3),Optimal_path_one(q,4));
      
      Optimal_path_try(i,1)= Optimal_path_one(q,1);
      Optimal_path_try(i,2)= Optimal_path_one(q,2);
      Optimal_path_try(i,3)= Optimal_path_one(q,3);
      Optimal_path_try(i,4)= Optimal_path_one(q,4);
   end
   Optimal_path_try
%% ����������·�߽ڵ�
 n=size(Optimal_path_try,1);
   for i=1:1:n
       Optimal_path(i,1)=Optimal_path_try(n,3);
       Optimal_path(i,2)=Optimal_path_try(n,4);
%        Optimal_path(i,3)=Optimal_path_try(n,1);
%        Optimal_path(i,4)=Optimal_path_try(n,2);
       n=n-1;
   end
   num_op=size(Optimal_path,1)+1;
   Optimal_path(num_op,1)=Optimal_path_try(1,1);
   Optimal_path(num_op,2)=Optimal_path_try(1,2);
% plot(Optimal_path(:,1)+.5,Optimal_path(:,2)+.5,'linewidth',1); %5%����
% ���������Ż�
 Optimal_path
 Optimal_path_two=Line_OPEN_STtwo(Optimal_path,CLOSED,Num_obs,num_op);
 num_optwo=size(Optimal_path_two,1)+1;
 Optimal_path_two(num_optwo,1)=xStart;
 Optimal_path_two(num_optwo,2)=yStart;
  Optimal_path_two
 % plot(Optimal_path_two(:,1)+.5,Optimal_path_two(:,2)+.5,'linewidth',1); %5%����
 % ��������
  j=num_optwo;
 Optimal_path_two2=[xStart yStart];
 for i=1:1:num_optwo
     Optimal_path_two2(i,1)=Optimal_path_two(j,1);
     Optimal_path_two2(i,2)=Optimal_path_two(j,2);
     j=j-1;
 end
  Optimal_path_three=Line_OPEN_STtwo(Optimal_path_two2,CLOSED,Num_obs,num_optwo);
  num_opthree=size(Optimal_path_three,1)+1;
  Optimal_path_three(num_opthree,1)=xTarget;
  Optimal_path_three(num_opthree,2)=yTarget;
 % plot(Optimal_path_three(:,1)+.5,Optimal_path_three(:,2)+.5,'b','linewidth',2);
  L_obst=2;% ÿ��2��ȡ��
  Obst_d_d_line=Line_obst(Optimal_path_three,L_obst);
  
  num_opthree=size(Obst_d_d_line,1)+1;
  Obst_d_d_line(num_opthree,1)=xTarget;
  Obst_d_d_line(num_opthree,2)=yTarget;
  
  NewOptimal_path=Obst_d_d_line;
%  plot(NewOptimal_path(:,1)+.5,NewOptimal_path(:,2)+.5,'r','linewidth',2);
  
 
%  plot(NewOptimal_path(:,1)+.5,NewOptimal_path(:,2)+.5,'b','linewidth',2); %5%���� 'b',,'b'
 
 
% Num_OPEN=size(OPEN,1) %%%% �����ڵ���
%  %Num_OPtimal=size(Optimal_path,1);  %%%% ʵ��·���ڵ���
%  Num_NewOptimal_path=size(NewOptimal_path,1);  %%%% �µ�ʵ�ʽڵ���
%  zhuan_num=Num_NewOptimal_path-2
  S=0;
 j = size(NewOptimal_path,1) ;
 for i=1:1:(j-1)  %%%% ��·�����õ�ʵ�ʳ���
     Dist=sqrt( ( NewOptimal_path(i,1) - NewOptimal_path(i+1,1) )^2 + ( NewOptimal_path(i,2) - NewOptimal_path(i+1,2))^2);
     S=S+Dist;
 end
distanceX=S;
ia_size=size(NewOptimal_path,1);
Path=[ ];
for i=1:1:ia_size
   Path(i,1) = NewOptimal_path(i,1);
   Path(i,2) = NewOptimal_path(i,2);
end
OPEN_num=size(OPEN,1); 
%%%% ��·�����õĽǶ�
%  angle_du=0;
%  for i=1:1:(j-2)  %%%% ��·�����õĽǶ�
%      du=angle6(  NewOptimal_path(i,1),NewOptimal_path(i,2),NewOptimal_path(i+1,1) ,NewOptimal_path(i+1,2),NewOptimal_path(i+2,1) ,NewOptimal_path(i+2,2));
%      angle_du=angle_du+du;
%      
%  end
%  angle_du
%  S
%  T= angle_du/45 + S + zhuan_num

%   p=plot(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,'bo'); %%
%  j=j-1;
%  for i=j:-1:1
%   pause(.25);
%   set(p,'XData',Optimal_path(i,1)+.5,'YData',Optimal_path(i,2)+.5);
%  drawnow ;
%  end;
 
% plot(Newopt(:,1)+.5,Newopt(:,2)+.5,'linewidth',2); %5%����
 
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end
