function [evalDB,trajDB]=Evaluation_du(x,Vr,goal,ob,R,model,evalParam)
% 
%  Vr=[ 0.1s������ٶ�0 0.1s������ٶ�0 0.1s����ͼ��ٶ� 0.1s����߼��ٶ� ]
% model= [   ����ٶ�[m/s]0, �����ת�ٶ�[rad/s], ���ٶ�[m/ss]0, ��ת���ٶ�[rad/ss], �ٶȷֱ���[m/s], ת�ٷֱ���[rad/s]  ]
evalDB=[];
trajDB=[];
%for vt=Vr(1):model(5):Vr(2) % ����ٶȣ��ٶȷֱ��ʣ�����ٶ�
    vt=0;
    for ot=Vr(3):model(6):Vr(4) % ��ͼ��ٶȣ�ת�ٷֱ��ʣ���߼��ٶ�
        % �켣�Ʋ�; �õ� xt: ��������ǰ�˶����Ԥ��λ��; traj: ��ǰʱ�� �� Ԥ��ʱ��֮��Ĺ켣
        [xt,traj]=GenerateTrajectory(x,vt,ot,evalParam(4),model);  % evalParam(4) = 3
        % ÿ��[vt ot]��3���ڵ��˶��켣��ȡ31����    
        % traj=3s�ڵ�����״̬�켣�� xt=3s���״̬�켣
        %evalParam(4),ǰ��ģ��ʱ��; % ���ۺ������� [heading,dist,velocity,predictDT]
        % [xt,traj] = [Ԥ��ĵ�ǰ״̬������״̬����  ]  % �����ۺ����ļ���
        heading=CalcHeadingEval(xt,goal); % ����3s���ƫ����Ŀ���ļн�a pi-a
        dist=0;%CalcDistEval(xt,ob,R); % ����3s���λ�� ���ϰ�����С���� �������ֵ���ƣ�
        vel=abs(vt); % abs ȥ����ֵ
        % �ƶ�����ļ��� vel= �Ʋ��ٶȵĴ�С
       % stopDist=CalcBreakingDist(vel,model);% �ƶ����� ����С�����ϰ���ľ���
        
        %%%%%%%     ����Ԥ��� �� ��̬�ϰ��� �ľ���       ****
        %dist_dong=Dist_Obs_dong(Obs_dong,xt,R_dong_obs);
        
        %if dist>stopDist % 
            evalDB=[evalDB;[vt ot heading dist vel 0 ]]; 
            % evalDB=[ ����һ�� v w ��Ԥ����ٶ� ת�� 3s��ļн� 3s����ϰ������ 3s����ٶ�ֵ 3s��Ķ�̬�ϰ������ ;
            %          ���ڶ��� v w ��Ԥ����ٶ� ת�� 3s��ļн� 3s����ϰ������ 3s����ٶ�ֵ 3s��Ķ�̬�ϰ������ ; ������]
            trajDB=[trajDB;traj]; % trajDB = [ ����һ�� v w ��3s�ڵ�����״̬�켣 31���� 1-5��31�У����ڶ��� v w ��3s�ڵ�����״̬�켣 31���� 6-10��31��]
       % end
    end
end
%end