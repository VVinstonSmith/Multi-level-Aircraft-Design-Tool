function idx = upper_bound(vector,x)
count = length(vector);
first = 1;
while(count > 0)
    step = floor(count/2);
    it = first+step;
    if ~(vector(it) > x)
        first = it+1;
        count = count-(step+1);
    else
        count = step;
    end
end
idx = first;
end