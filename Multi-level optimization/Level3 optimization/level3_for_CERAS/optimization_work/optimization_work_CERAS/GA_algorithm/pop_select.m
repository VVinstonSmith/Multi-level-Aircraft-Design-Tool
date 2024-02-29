function [parent_pop,fit_max,fit_ave]=pop_select(fit_func,pop)

fitness=zeros(1,size(pop,2));
fit_max=0;
fit_ave=0;
max_index=1;
for ii=1:size(pop,2)
    fitness(ii)=fit_func(pop(:,ii));
    if fit_max<fitness(ii)
        fit_max=fitness(ii);
        max_index=ii;
    end
    fit_ave=fit_ave+fitness(ii);
end
fit_ave=fit_ave/size(pop,2);

for ii=1:size(pop,2)
    wheel=cumsum(fitness)./sum(fitness);
end

parent_pop=zeros(size(pop,1),size(pop,2));

parent_pop(:,1)=pop(:,max_index);
for ii=2:size(pop,2)
    select_index=binary_search(wheel,rand);
    parent_pop(:,ii)=pop(:,select_index);
end





end

