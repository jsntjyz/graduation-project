function Obst_d_d_line=Line_obst(Obst_d_path_X,L_obst)
num=size(Obst_d_path_X,1);

Obst_d_d_line=[];
for v=1:1:(num-1)
       
       % p_node=[line_open_t(i_t,1),line_open_t(i_t,2)];  %%% ��ǰ�������
        p_node_1=[Obst_d_path_X(v,1),Obst_d_path_X(v,2)]; %%% ��ǰ���ӽڵ������
        p_node_2=[Obst_d_path_X(v+1,1),Obst_d_path_X(v+1,2)] ; %%% ��ǰ����ӽڵ���ӽڵ�����
       
        line_node=LINE_o2(p_node_1,p_node_2,L_obst); %%%%%��1,2���ڵ�֮�������ϵĽڵ������
        Obst_d_d_line=[Obst_d_d_line;line_node];
      
end
end