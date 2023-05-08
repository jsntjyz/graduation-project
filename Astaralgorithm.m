clear
figure 
%% 初始化地图格式        
MAX0 = [     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0
             0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0
             0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
             0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
             0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
             0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
             0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 
             0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0
             0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 
             0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 
             0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0
             0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 1 0 0 0 0 
             0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 
             0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
             0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ] ;
         
%% 显示初始地图
%通道设置为 0 ；障碍点设置为 1 ；起始点设置为 2 ；目标点设置为 -1 。
MAX=rot90(MAX0,3);      %%%设置0,1摆放的图像与存入的数组不一样，需要先逆时针旋转90*3=270度给数组，最后输出来的图像就是自己编排的图像
MAX_X=size(MAX,2);                                %%%  获取列数，即x轴长度
MAX_Y=size(MAX,1);                                %%%  获取行数，即y轴长度
x_val = 1;
y_val = 1;
axis([1 MAX_X+1, 1 MAX_Y+1])                %%%  设置x，y轴上下限
set(gca,'xtick',1:1:MAX_X+1,'ytick',1:1:MAX_Y+1,'GridLineStyle','-',... 
    'xGrid','on','yGrid','on')
grid on;                                   %%%  在画图的时候添加网格线
hold on;                                   %%%  当前轴及图像保持而不被刷新，准备接受此后将绘制的图形，多图共存

%% 显示障碍物
k=1;          %%%% 将所有障碍物放在关闭列表中；障碍点的值为1;并且显示障碍点
CLOSED=[];
for j=1:MAX_X
    for i=1:MAX_Y
        if (MAX(i,j)==1)
          %plot(i+.5,j+.5,'ks','MarkerFaceColor','b'); %原来是红点圆表示
          fill([i,i+1,i+1,i],[j,j,j+1,j+1],'k');  %%%改成 用黑方块来表示障碍物
          CLOSED(k,1)=i;  %%% 将障碍点保存到CLOSE数组中
          CLOSED(k,2)=j; 
          k=k+1;
        end
    end
end
%设置一些基本参数
Area_MAX(1,1)=MAX_X;
Area_MAX(1,2)=MAX_Y;
Obs_Closed=CLOSED;
num_Closed=size(CLOSED,1);

%% 设置起始点和目标点
%   选择起始位置
h=msgbox('请使用鼠标左键选择小车初始位置');                   
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('请选择小车初始位置 ','Color','black');               
but=0;
while (but ~= 1)  %%%重复，直到没有单击“向左”按钮
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
plot(xval+.5,yval+.5,'b^');
text(xval+1,yval+1,'Start')  
xlabel('起始点位置标记为 △ ，目标点位置标记为 o ','Color','black'); 

%  选择目标位置
pause(0.5);                                  %%%   程序暂停1秒
h=msgbox('请使用鼠标左键选择目标');          %%%   显示提示语 
uiwait(h,5);                               %%%   程序暂停
if ishandle(h) == 1                        %%%   ishandle(H) 将返回一个元素为 1 的数组；否则，将返回 0。
    delete(h);
end
xlabel('请使用鼠标左键选择目标','Color','black');   %%%   显示图x坐标下面的提示语 
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked  %%%  重复，直到没有单击“向左”按钮
    [xval,yval,but]=ginput(1);                                 %%%  ginput提供了一个十字光标使我们能更精确的选择我们所需要的位置，并返回坐标值。
end
xval=floor(xval);                                              %%%  floor（）取不大于传入值的最大整数，向下取整
yval=floor(yval);
xTarget=xval;%X Coordinate of the Target                       %%%   目标的坐标
yTarget=yval;%Y Coordinate of the Target
plot(xval+.5,yval+.5,'go');                                    %%%   目标点颜色b 蓝色 g 绿色 k 黑色 w白色 r 红色 y黄色 m紫红色 c蓝绿色
text(xval+1,yval+1,'Target')                                  %%%   text(x,y,'string')在二维图形中指定的位置(x,y)上显示字符串string

Start=[xStart yStart];
Goal=[xTarget yTarget];
%% A*算法
[Line_path,distance_x,OPEN_num]=Astar_G_du(Obs_Closed,Start,Goal,MAX_X,MAX_Y);

%% 画出A*算法结果
%生成第二张图
figure 
axis([1 MAX_X+1, 1 MAX_Y+1])                %%%  设置x，y轴上下限
set(gca,'xtick',1:1:MAX_X+1,'ytick',1:1:MAX_Y+1,'GridLineStyle','-',...
        'xGrid','on','yGrid','on');   
grid on;       
hold on;
%画出障碍物
num_obc=size(Obs_Closed,1);
for i_obs=1:1:num_obc
         x_obs=Obs_Closed(i_obs,1);
         y_obs=Obs_Closed(i_obs,2);
         fill([x_obs,x_obs+1,x_obs+1,x_obs],[y_obs,y_obs,y_obs+1,y_obs+1],'k');hold on;
end
% 画出a*算法求解结果
 plot( Line_path(:,1)+.5, Line_path(:,2)+.5,'b:','linewidth',2); 
 plot(xStart+.5,yStart+.5,'b^');
 plot(Goal(1,1)+.5,Goal(1,2)+.5,'bo');   
pause(1);


