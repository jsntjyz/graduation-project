function n_index = node_index(OPEN,xval,yval)
    %返回list中节点位置的索引,确定父节点
    i=1;
    while(OPEN(i,2) ~= xval || OPEN(i,3) ~= yval )  %%%从OPEN第一组数据开始遍历，确定当前点在哪一行
        i=i+1;
    end;
    n_index=i;     %%%将当前点的OPEN数组的行数 赋值出去
end
