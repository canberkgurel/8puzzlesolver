function new_node= Act(node, action)
    [row,col]=find(node==0);
    old_row=row;
    old_col=col;
  
    if(action==8)
        row=row-1;
    elseif(action==2)
        row=row+1;
    elseif(action==4)
        col=col-1;
    elseif(action==6)
        col=col+1;
    end
    temp=node(row,col);
    node(row,col)=0;
    node(old_row,old_col)=temp;
    
    new_node=node;
end
