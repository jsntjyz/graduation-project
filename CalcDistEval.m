function dist=CalcDistEval(x,ob,R)
% �ϰ���������ۺ���
dist=200;
for io=1:length(ob(:,1))
    disttmp=norm(ob(io,:)-x(1:2)')-R;% �ϰ���������� - ��ǰ������ norm��б�߳���
    if dist>disttmp% 100���µľ��� �͸�ֵ  ���ϰ�����С�ľ���
        dist=disttmp;
    end
end
 
% �ϰ�����������޶�һ�����ֵ��������趨��һ��һ���켣û���ϰ����̫ռ����
if dist>=R
    dist=R;
end