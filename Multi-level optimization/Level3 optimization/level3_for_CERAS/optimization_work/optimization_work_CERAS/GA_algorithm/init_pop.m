function pop=init_pop(NUMPOP,range_l,range_r)

kDim=length(range_l);

for n=1:NUMPOP
    for k=1:kDim
        pop(k,n)=range_l(k)+rand*(range_r(k)-range_l(k));
    end
end



end

