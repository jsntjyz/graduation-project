function i_min = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget)
% ����open�б���Ϊ���룬�����ؾ�����С�ɱ��Ľڵ�����
 temp_array=[];
 k=1;
 flag=0;
 goal_index=0;
 for j=1:OPEN_COUNT
     if (OPEN(j,1)==1)
         temp_array(k,:)=[OPEN(j,:) j];           
         if (OPEN(j,2)==xTarget && OPEN(j,3)==yTarget)
             flag=1;
             goal_index=j;                         % �洢Ŀ��ڵ������
         end;
         k=k+1;
     end;
 end;                        % ��ȡ�б��е����нڵ�
 if flag == 1               % ����һ���������Ŀ��ڵ㣬��˷��ʹ˽ڵ�
     i_min=goal_index;
 end
 %������С�ڵ������
 if size(temp_array ~= 0)
      %temp_array  %%%���temp_array 
     [min_fn,temp_min]=min(temp_array(:,8));%��ʱ��������С�ڵ������
                                         %��Сֵ����min_fn����Сֵ���ڵ���������temp_min��    ����  A=[1 2 3;4 5 6;7 8 9;0 0 0] [a,b]=min(A(:,3)) a=0 b=4;
  i_min=temp_array(temp_min,9);          % OPEN��������С�ڵ������
 else
     i_min=-1;%  temp_array�ǿյģ���û�и����·������
 end;