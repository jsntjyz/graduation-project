function i_min = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget)
% 接受open列表作为输入，并返回具有最小成本的节点索引
 temp_array=[];
 k=1;
 flag=0;
 goal_index=0;
 for j=1:OPEN_COUNT
     if (OPEN(j,1)==1)
         temp_array(k,:)=[OPEN(j,:) j];           
         if (OPEN(j,2)==xTarget && OPEN(j,3)==yTarget)
             flag=1;
             goal_index=j;                         % 存储目标节点的索引
         end;
         k=k+1;
     end;
 end;                        % 获取列表中的所有节点
 if flag == 1               % 其中一个后继者是目标节点，因此发送此节点
     i_min=goal_index;
 end
 %发送最小节点的索引
 if size(temp_array ~= 0)
      %temp_array  %%%输出temp_array 
     [min_fn,temp_min]=min(temp_array(:,8));%临时数组中最小节点的索引
                                         %最小值赋给min_fn，最小值所在的行数赋给temp_min；    比如  A=[1 2 3;4 5 6;7 8 9;0 0 0] [a,b]=min(A(:,3)) a=0 b=4;
  i_min=temp_array(temp_min,9);          % OPEN数组中最小节点的索引
 else
     i_min=-1;%  temp_array是空的，即没有更多的路径可用
 end;