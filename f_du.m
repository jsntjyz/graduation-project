function x = f_du(x, u)
% Motion Model
% u = [vt; wt];��ǰʱ�̵��ٶȡ����ٶ�
%�����˵ĳ���״̬ x=[x(m),y(m),yaw(Rad),v(m/s),w(rad/s)]
 dt_du=3;
 
F = [1 0 0 0 0
     0 1 0 0 0
     0 0 1 0 0
     0 0 0 0 0
     0 0 0 0 0];
 
B = [dt_du*cos(x(3)) 0
    dt_du*sin(x(3)) 0
    0 dt_du
    1 0
    0 1];
 
x= F*x+B*u;