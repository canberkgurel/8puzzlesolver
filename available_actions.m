function [actions] = available_actions(node)
    
    k = find(~node); %k is the position of 0

    if(k==1)
        actions=[2,6];
    elseif(k==2)
        actions=[2,6,8];
    elseif(k==3)
        actions=[6,8];
    elseif(k==4)
        actions=[4,6,2];
    elseif(k==5)
        actions=[8,6,4,2];
    elseif(k==6)
        actions=[8,6,4];
    elseif(k==7)
        actions=[4,2];
    elseif(k==8)
        actions=[8,2,4];
    elseif(k==9)
        actions=[8,4];
    end
end

