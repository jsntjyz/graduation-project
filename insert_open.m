function new_row = insert_open(xval,yval,parent_xval,parent_yval,hn,gn,fn)
% 填充OPEN LIST的功能 1 X坐标 Y坐标 父节点x坐标 父节点y坐标 hn gn fn
new_row=[1,8];
new_row(1,1)=1;
new_row(1,2)=xval;
new_row(1,3)=yval;
new_row(1,4)=parent_xval;
new_row(1,5)=parent_yval;
new_row(1,6)=hn;
new_row(1,7)=gn;
new_row(1,8)=fn;
end