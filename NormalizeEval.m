
function EvalDB=NormalizeEval(EvalDB)
% ���ۺ�������
% EvalDB=[ Ԥ����ٶ� ת�� �н� �ϰ������ �ٶ�ֵ  ]
if sum(EvalDB(:,3))~=0
    EvalDB(:,3)=EvalDB(:,3)/sum(EvalDB(:,3));
end
if sum(EvalDB(:,4))~=0
    EvalDB(:,4)=EvalDB(:,4)/sum(EvalDB(:,4));
end
if sum(EvalDB(:,5))~=0
    EvalDB(:,5)=EvalDB(:,5)/sum(EvalDB(:,5));
end
if sum(EvalDB(:,6))~=0
    EvalDB(:,6)=EvalDB(:,6)/sum(EvalDB(:,6));
end