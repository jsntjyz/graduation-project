function ang=sn_angle(x_1,y_1,x_2,y_2)
%计算两个坐标之间的夹角
x=x_2-x_1 ;
y=y_2-y_1;
n=[1 0];
m=[x y];
c=dot(n,m)/norm(n,2)/norm(m,2) ;
if  y<0
    i=-1 ;
else
    i=1 ;
end
du=i*rad2deg(acos(c)) ;%rad2deg将弧度数转换为相应的角度数
 
ang=du/180*pi ;