function [u,trajDB]=DynamicWindowApproach_du(x,model,goal,evalParam,ob,R)
% Dynamic Window [vmin,vmax,wmin,wmax]
% model= [   ����ٶ�[m/s], �����ת�ٶ�[rad/s], ���ٶ�[m/ss], ��ת���ٶ�[rad/ss], �ٶȷֱ���[m/s], ת�ٷֱ���[rad/s]  ]
% x=[x(m),y(m),yaw(Rad),v(m/s),w(rad/s)]
model(3)=0;
model(5)=0;
% ���ٶȺ��ٶȷֱ�����Ϊ0 ������
Vr=CalcDynamicWindow_du(x,model);
%  Vr=[ 0.1s������ٶ�0 0.1s������ٶ�0 0.1s����ͼ��ٶ� 0.1s����߼��ٶ� ]
% ���ۺ����ļ���
 [evalDB,trajDB]=Evaluation_du(x,Vr,goal,ob,R,model,evalParam);
%[evalDB,trajDB]=Evaluation_ct(x,Vr,goal,ob,R,model,evalParam);
 %  % evalDB=[ ����һ�� v w ��Ԥ����ٶ� ת�� 3s��ļн� 3s����ϰ������ 3s����ٶ�ֵ 3s��Ķ�̬�ϰ������;
 %             ���ڶ��� v w ��Ԥ����ٶ� ת�� 3s��ļн� 3s����ϰ������ 3s����ٶ�ֵ 3s��Ķ�̬�ϰ������; 
 %              ������ ]
 % % trajDB = [ ����һ�� v w ��3s�ڵ�����״̬�켣 31���� 1-5��31�У�
 %              ���ڶ��� v w ��3s�ڵ�����״̬�켣 31���� 6-10��31��;
 %              ������ ]
if isempty(evalDB)   %  isempty �ж��Ƿ�Ϊ��
    disp('no path to goal!!');
    u=[0;0];return;
end
% �����ۺ�������
evalDB=NormalizeEval(evalDB);
% evalDB=[ Ԥ����ٶ� ת�� �н�ƽ��ֵ �ϰ������ƽ��ֵ �ٶ�ֵƽ��ֵ  ]
%    evalDB=[ ����һ�� v w ��Ԥ����ٶ� ת�� 3s��ļн�/��������ܼнǣ����أ� 3s����ϰ������/��������ܾ��루���أ� 3s����ٶ�ֵ/����������ٶȣ����أ� 3s��Ķ�̬�ϰ������/��������ܾ��루���أ�;
%             ���ڶ��� v w ��Ԥ����ٶ� ת�� 3s��ļн�/��������ܼнǣ����أ� 3s����ϰ������/��������ܾ��루���أ� 3s����ٶ�ֵ/����������ٶȣ����أ� 3s��Ķ�̬�ϰ������/��������ܾ��루���أ�; 
%              ������ ]
feval=[]; % �������ۺ����ļ���
for id=1:length(evalDB(:,1))
    feval=[feval;evalParam(1:4)*evalDB(id,3:6)'];
    % evalParam=[0.05,  0.2,  0.1,  3.0]; 0.3 0.1 0.1
    % evalDB=[ Ԥ����ٶ� ת�� �нǱ��� �ϰ��������� �ٶ�ֵ���� ��̬�ϰ���������  ] 
    % feval=[��ÿ�飩 �нǱ���*ϵ�� �ϰ���������*ϵ�� �ٶ�ֵ����*ϵ�� ��̬�ϰ���������*ϵ�� ]
end
evalDB=[evalDB feval];
 
[maxv,ind]=max(feval);% �������ۺ���
u=evalDB(ind,1:2)';% 
end