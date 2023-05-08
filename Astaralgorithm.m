clear
figure 
%% ��ʼ����ͼ��ʽ        
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
         
%% ��ʾ��ʼ��ͼ
%ͨ������Ϊ 0 ���ϰ�������Ϊ 1 ����ʼ������Ϊ 2 ��Ŀ�������Ϊ -1 ��
MAX=rot90(MAX0,3);      %%%����0,1�ڷŵ�ͼ�����������鲻һ������Ҫ����ʱ����ת90*3=270�ȸ����飬����������ͼ������Լ����ŵ�ͼ��
MAX_X=size(MAX,2);                                %%%  ��ȡ��������x�᳤��
MAX_Y=size(MAX,1);                                %%%  ��ȡ��������y�᳤��
x_val = 1;
y_val = 1;
axis([1 MAX_X+1, 1 MAX_Y+1])                %%%  ����x��y��������
set(gca,'xtick',1:1:MAX_X+1,'ytick',1:1:MAX_Y+1,'GridLineStyle','-',... 
    'xGrid','on','yGrid','on')
grid on;                                   %%%  �ڻ�ͼ��ʱ�����������
hold on;                                   %%%  ��ǰ�ἰͼ�񱣳ֶ�����ˢ�£�׼�����ܴ˺󽫻��Ƶ�ͼ�Σ���ͼ����

%% ��ʾ�ϰ���
k=1;          %%%% �������ϰ�����ڹر��б��У��ϰ����ֵΪ1;������ʾ�ϰ���
CLOSED=[];
for j=1:MAX_X
    for i=1:MAX_Y
        if (MAX(i,j)==1)
          %plot(i+.5,j+.5,'ks','MarkerFaceColor','b'); %ԭ���Ǻ��Բ��ʾ
          fill([i,i+1,i+1,i],[j,j,j+1,j+1],'k');  %%%�ĳ� �úڷ�������ʾ�ϰ���
          CLOSED(k,1)=i;  %%% ���ϰ��㱣�浽CLOSE������
          CLOSED(k,2)=j; 
          k=k+1;
        end
    end
end
%����һЩ��������
Area_MAX(1,1)=MAX_X;
Area_MAX(1,2)=MAX_Y;
Obs_Closed=CLOSED;
num_Closed=size(CLOSED,1);

%% ������ʼ���Ŀ���
%   ѡ����ʼλ��
h=msgbox('��ʹ��������ѡ��С����ʼλ��');                   
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('��ѡ��С����ʼλ�� ','Color','black');               
but=0;
while (but ~= 1)  %%%�ظ���ֱ��û�е��������󡱰�ť
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
plot(xval+.5,yval+.5,'b^');
text(xval+1,yval+1,'Start')  
xlabel('��ʼ��λ�ñ��Ϊ �� ��Ŀ���λ�ñ��Ϊ o ','Color','black'); 

%  ѡ��Ŀ��λ��
pause(0.5);                                  %%%   ������ͣ1��
h=msgbox('��ʹ��������ѡ��Ŀ��');          %%%   ��ʾ��ʾ�� 
uiwait(h,5);                               %%%   ������ͣ
if ishandle(h) == 1                        %%%   ishandle(H) ������һ��Ԫ��Ϊ 1 �����飻���򣬽����� 0��
    delete(h);
end
xlabel('��ʹ��������ѡ��Ŀ��','Color','black');   %%%   ��ʾͼx�����������ʾ�� 
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked  %%%  �ظ���ֱ��û�е��������󡱰�ť
    [xval,yval,but]=ginput(1);                                 %%%  ginput�ṩ��һ��ʮ�ֹ��ʹ�����ܸ���ȷ��ѡ����������Ҫ��λ�ã�����������ֵ��
end
xval=floor(xval);                                              %%%  floor����ȡ�����ڴ���ֵ���������������ȡ��
yval=floor(yval);
xTarget=xval;%X Coordinate of the Target                       %%%   Ŀ�������
yTarget=yval;%Y Coordinate of the Target
plot(xval+.5,yval+.5,'go');                                    %%%   Ŀ�����ɫb ��ɫ g ��ɫ k ��ɫ w��ɫ r ��ɫ y��ɫ m�Ϻ�ɫ c����ɫ
text(xval+1,yval+1,'Target')                                  %%%   text(x,y,'string')�ڶ�άͼ����ָ����λ��(x,y)����ʾ�ַ���string

Start=[xStart yStart];
Goal=[xTarget yTarget];
%% A*�㷨
[Line_path,distance_x,OPEN_num]=Astar_G_du(Obs_Closed,Start,Goal,MAX_X,MAX_Y);

%% ����A*�㷨���
%���ɵڶ���ͼ
figure 
axis([1 MAX_X+1, 1 MAX_Y+1])                %%%  ����x��y��������
set(gca,'xtick',1:1:MAX_X+1,'ytick',1:1:MAX_Y+1,'GridLineStyle','-',...
        'xGrid','on','yGrid','on');   
grid on;       
hold on;
%�����ϰ���
num_obc=size(Obs_Closed,1);
for i_obs=1:1:num_obc
         x_obs=Obs_Closed(i_obs,1);
         y_obs=Obs_Closed(i_obs,2);
         fill([x_obs,x_obs+1,x_obs+1,x_obs],[y_obs,y_obs,y_obs+1,y_obs+1],'k');hold on;
end
% ����a*�㷨�����
 plot( Line_path(:,1)+.5, Line_path(:,2)+.5,'b:','linewidth',2); 
 plot(xStart+.5,yStart+.5,'b^');
 plot(Goal(1,1)+.5,Goal(1,2)+.5,'bo');   
pause(1);


