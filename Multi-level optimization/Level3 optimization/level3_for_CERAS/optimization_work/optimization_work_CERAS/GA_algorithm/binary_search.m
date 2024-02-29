function index =binary_search( NUMS,num )

if num<NUMS(1)
    index=1;
else
    left=1;
    right=length(NUMS);
    flag=0;
    if(num==NUMS(left))
        index=1;
        flag=1;
    end
    if(num==NUMS(right))
        index=right;
        flag=1;
    end
    while  right>left+1  
        middle=fix((right+left)/2);
        if num > NUMS(middle)
            left=middle;
        elseif num<NUMS(middle)
            right=middle;
        else
            index=middle;
            flag=1;
            break;
        end
    end
    if flag==0
        index=right;
    end
end

end

