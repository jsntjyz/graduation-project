function lineOPEN=Line_OPEN_STtwo(Optimal_path,CLOSED,Num_obs,num_op)
     i_t=1;
      v=2;   %%  Optimal_path ·���ڵ� 
     line_open_t(1,1)=Optimal_path(1,1); %%%%line_open_t �µ�·���ڵ�
     line_open_t(1,2)=Optimal_path(1,2);
   
     while v <  num_op 
       
        p_node=[line_open_t(i_t,1),line_open_t(i_t,2)];  %%% ��ǰ�������
        p_node_1=[Optimal_path(v,1),Optimal_path(v,2)]; %%% ��ǰ���ӽڵ������
        p_node_2=[Optimal_path(v+1,1),Optimal_path(v+1,2)] ; %%% ��ǰ����ӽڵ���ӽڵ�����
       % p_node_3=[Optimal_path(v+3,1),Optimal_path(v+3,2)];  %%% ��ǰ����ӽڵ���ӽڵ���ӽڵ�����
        v=v+1;
       % line_node1=LINE(p_node_2,p_node_3); %%%%%��2,3���ڵ�֮�������ϵĽڵ������
        line_node=LINE(p_node_1,p_node_2); %%%%%��1,2���ڵ�֮�������ϵĽڵ������
        
       % line_node=[line_node1;line_node2]; %%%%%%����Ľڵ����`
%         i_l=0;
        num_ln=size(line_node,1);
        p_x=p_node(1,1);
        p_y=p_node(1,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�жϵ�ǰ����߶��ϵĽڵ�֮���Ƿ����ϰ��� 
      fn=0;f=1;
      for j=num_ln:-1:1
            l_x=line_node(j,1); l_y=line_node(j,2); 
           
            x_min=min(p_x,l_x)-0.8;  x_max=max(p_x,l_x)+0.8;
            y_min=min(p_y,l_y)-0.8;  y_max=max(p_y,l_y)+0.8; 
            k = (l_y-p_y)/(l_x-p_x); b =p_y-k*p_x; %%����֮��ֱ�߷��� y=k*x+b
           
            for a=1:1:Num_obs
                x_obn=CLOSED(a,1); y_obn=CLOSED(a,2); %%�ж��ϰ����Ƿ�����ʻ������
                if (x_obn>=x_min && x_obn<=x_max && y_obn>=y_min && y_obn<=y_max)
                  yline=x_obn*k+b; D=1;
                  
                  d=abs(y_obn-yline)*cos(atan(k));
                  if d<=D
                      f=0; %%%����֮�����ϰ���
                  
                  end
                end
            end   
            
            if f==1
               node_l(2,1)=l_x;
               node_l(2,2)=l_y;  
               fn=1; %%�ж��п����ӵ�
            end
          
      end
%%%%%%%%%%%%%%%%%%%%%%%%%%�������ӵĵ�һ����洢���µ�·���У�������ǰ��        
        i_t=i_t+1;

        if fn==1
           line_open_t(i_t,1)=node_l(2,1);
           line_open_t(i_t,2)=node_l(2,2);
           if  node_l(2,1)==line_node(1,1)&&node_l(2,2)==line_node(1,2)
               v=v+1;
           end
        else
           line_open_t(i_t,1)=p_node_1(1,1);
           line_open_t(i_t,2)=p_node_1(1,2);
        end
        
     end
     lineOPEN=line_open_t;
end
      
        
        
        
        
        
        
        
        
        
        
        
        


