function [x,traj]=GenerateTrajectory(x,vt,ot,evaldt,model)
% �켣���ɺ���
% evaldt��ǰ��ģ��ʱ��; vt��ot��ǰ�ٶȺͽ��ٶ�; ���ۺ������� [heading,dist,velocity,predictDT]
global dt;
time=0;
u=[vt;ot];% ����ֵ
traj=x;% �����˹켣
while time<=evaldt % evaldt=evalParam(4) = 3   0:0.1:3  30��ѭ��
    time=time+dt;% ʱ�����0.1 30 
    x=f(x,u);% �˶�����  0.1s���״̬
    
    traj=[traj x];% traj=3s�ڵ�����״̬�켣�� x=3s���״̬�켣
end