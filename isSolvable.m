function [solvable] = isSolvable(node)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    inv_count=0;
    arr = reshape(node.',1,[]);
    for A=1:8
        for B=(1+A):9
            if((arr(B)>0) && (arr(A)>0) && (arr(A) > arr(B)))
                inv_count=inv_count+1;
            end
        end
    end

    if(rem(inv_count,2) == 0)
        % puzzle Solvable
        solvable = 1;
    else
        % puzzle Not Solvable
        solvable = 0;
    end

end

