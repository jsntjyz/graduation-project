function n_index = node_index(OPEN,xval,yval)
    %����list�нڵ�λ�õ�����,ȷ�����ڵ�
    i=1;
    while(OPEN(i,2) ~= xval || OPEN(i,3) ~= yval )  %%%��OPEN��һ�����ݿ�ʼ������ȷ����ǰ������һ��
        i=i+1;
    end;
    n_index=i;     %%%����ǰ���OPEN��������� ��ֵ��ȥ
end
