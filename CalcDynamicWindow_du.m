function Vr=CalcDynamicWindow_du(x,model)
%
global dt;
% �����ٶȵ������С��Χ 
% model= [   ����ٶ�[m/s], �����ת�ٶ�[rad/s], ���ٶ�[m/ss], ��ת���ٶ�[rad/ss], �ٶȷֱ���[m/s], ת�ٷֱ���[rad/s]  ]
Vs=[0 0 -model(2) model(2)];
% Vs=[ 0, ����ٶ�[m/s],  -�����ת�ٶ�[rad/s], �����ת�ٶ�[rad/s]   ]
% ���ݵ�ǰ�ٶ��Լ����ٶ����Ƽ���Ķ�̬����
% x=[x(m),y(m),yaw(Rad),v(m/s),w(rad/s)]

Vd=[0 0 x(5)-model(4)*dt x(5)+model(4)*dt];
% Vd=[  v-at(0.1s������ٶȣ���v+at(0.1s������ٶȣ���w-bt(0.1s����ͼ��ٶ� ��w+bt(0.1s����߼��ٶȣ�]
% ���յ�Dynamic Window
Vtmp=[Vs;Vd];
% Vtmp=[      0,                 ����ٶ�[m/s],       -�����ת�ٶ�[rad/s],   �����ת�ٶ�[rad/s]  ;
%      v-at(0.1s������ٶȣ���v+at(0.1s������ٶȣ���w-bt(0.1s����ͼ��ٶ� ��  w+bt(0.1s����߼��ٶȣ�];
Vr=[0 0 max(Vtmp(:,3)) min(Vtmp(:,4))];
% ѡ�������������µ��ٶȷ�Χ
%  Vr=[ 0.1s������ٶ� 0.1s������ٶ� 0.1s����ͼ��ٶ� 0.1s����߼��ٶ� ]
end