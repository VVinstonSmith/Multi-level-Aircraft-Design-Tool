function pop = pop_decoding( binary_pop,range_l,range_r,LENGTH )
m=size(binary_pop,1);
n=size(binary_pop,2);
pop=zeros(m,n);
for jj=1:n
    for ii=1:m
        right=range_r(ii);
        left=range_l(ii);
        K= double(binary_pop(ii,jj)) / (2^LENGTH) ;
        pop(ii,jj)=left+(right-left)*K;
    end
end

end

