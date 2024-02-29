function binpop=pop_coding(pop,range_l,range_r,LENGTH)
m=size(pop,1);
n=size(pop,2);
binpop=uint32(zeros(m,n));
for jj=1:n
    for ii=1:m
        right=range_r(ii);
        left=range_l(ii);
        K= (pop(ii,jj)-left)/(right-left);
        binpop(ii,jj)=uint32(2^LENGTH*K);
    end
end
end

