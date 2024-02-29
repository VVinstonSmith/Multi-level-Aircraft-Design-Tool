function bin_pop = crossover2(bin_pop, LENGTH, cross_rate, sub_cross_rate)

m=size(bin_pop,1);
n=size(bin_pop,2);

wait=2:n;
wait_length=length(wait);


cross_num=int16(n*cross_rate/2);

for k=1:cross_num
    n1=int16(ceil(wait_length*rand));
    n_father=wait(n1);
    wait(n1)=0;
    temp=wait(n1); wait(n1)=wait(wait_length); wait(wait_length)=temp;
    wait_length=wait_length-1;
    
    n1=int16(ceil(wait_length*rand));
    n_mother=wait(n1);
    wait(n1)=0;
    temp=wait(n1); wait(n1)=wait(wait_length); wait(wait_length)=temp;
    wait_length=wait_length-1;
        
    for ii=1:m
        if rand<sub_cross_rate
            pos=uint32(LENGTH*rand);
            tail=uint32(2^pos-1);
            head=uint32(2^LENGTH-1)-tail;
            
            kid_1= bitand( bin_pop(ii,n_father) , tail , 'uint32' )+...
                bitand( bin_pop(ii,n_mother) , head , 'uint32' );
            kid_2= bitand( bin_pop(ii,n_father) , head , 'uint32' )+...
                bitand( bin_pop(ii,n_mother) , tail , 'uint32' );
            
            bin_pop(ii,n_father)=kid_1;
            bin_pop(ii,n_mother)=kid_2;
        end
    end
end

end

