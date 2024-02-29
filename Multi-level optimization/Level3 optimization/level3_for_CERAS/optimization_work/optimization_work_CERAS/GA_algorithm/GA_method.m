function [pop, pop_result] = GA_method(...
    fit_func, range_l, range_r,...
    NUMPOP, LENGTH, ITERATION,...
    cross_rate, sub_cross_rate, variation_rate,...
    run_past, pop_initial, new_pop_num)

% Rosen=@(x) 100*(x(1).^2-x(2)).^2+(1-x(1)).^2;
% range_l=[ -2.048 ; -2.048 ];
% range_r=[ 2.048 ; 2.048 ];

% Ras=@(x) 70-(10+x(1)^2+x(2)^2-10*(cos(2*pi*x(1)+cos(2*pi*x(2)))));
% range_l=[ -5 ; -5 ];
% range_r=[ 5 ; 5 ];

% new_func=@(x) x+10*sin(5*x)+7*cos(4*x)+15;
% range_l=0;range_r=9;
% t=0:0.01:9;
% y=new_func(t);
% figure(5);
% plot(t,y);
% 
% NUMPOP=50;
% LENGTH=32;
% ITERATION=200;
% cross_rate=0.6;
% sub_cross_rate=0.8;
% variation_rate=0.01;

FIT_MAX=zeros(ITERATION,1);
FIT_AVE=zeros(ITERATION,1);

if run_past==false
    pop = init_pop(NUMPOP,range_l,range_r);
else
    if new_pop_num==0
        pop = pop_initial;
    else
        pop_old = pop_initial(:,1:NUMPOP-new_pop_num);
        pop_new = init_pop(new_pop_num, range_l, range_r);
        pop = [pop_old, pop_new];
    end
end
for time=1:ITERATION
    time
    %
    [pop,fit_max,fit_ave] = pop_select(fit_func, pop);
    FIT_MAX(time)=fit_max;
    FIT_AVE(time)=fit_ave;
    %
    bin_pop=pop_coding(pop,range_l,range_r,LENGTH);
    %
    bin_pop = crossover2(bin_pop, LENGTH, cross_rate, sub_cross_rate);
    %
    bin_pop=variation(bin_pop, LENGTH, variation_rate);
    %
    pop=pop_decoding( bin_pop,range_l,range_r,LENGTH );
end

for ii=1:size(pop,2)
    pop_result(ii) = fit_func(pop(:,ii));
end

figure(1);
plot(1:ITERATION,FIT_MAX,'-*');hold on;
title('FIT MAX');

figure(2);
plot(1:ITERATION,FIT_AVE,'-o');
title('FIT AVE');


end

