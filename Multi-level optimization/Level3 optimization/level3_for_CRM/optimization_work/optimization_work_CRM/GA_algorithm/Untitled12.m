LENGTH = 32;

range_l = [0,1];
range_r  = [1,2];


pop = [0.51;
        1.93];

binpop=pop_coding(pop,range_l,range_r,LENGTH)

pop = pop_decoding( binpop,range_l,range_r,LENGTH )
