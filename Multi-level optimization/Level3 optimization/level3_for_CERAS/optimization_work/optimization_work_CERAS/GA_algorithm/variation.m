function bin_pop=variation(bin_pop, LENGTH, rate)

m=size(bin_pop,1);
n=size(bin_pop,2);
for jj=2:n
    for ii=1:m
        for kk=1:LENGTH
            if rand<rate
                pos=uint32(2^(kk-1));
                if( bitand( bin_pop(ii,jj) , pos )==0 )
                    bin_pop(ii,jj)=bin_pop(ii,jj)+pos;
                else
                    bin_pop(ii,jj)=bin_pop(ii,jj)-pos;
                end
            end
        end
    end
end

end

