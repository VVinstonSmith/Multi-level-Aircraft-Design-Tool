function wing_box = sort_wing_box(wing_box,m)

n = length(wing_box);

for ii = 1:n-1
    k_max = 1;
    for jj = 1:n-ii+1
        P = wing_box(jj).center_point();
        P_max = wing_box(k_max).center_point();
        if P(m)>P_max(m)
            k_max = jj;
        end 
    end
    wing_box_3 = wing_box(n-ii+1);
    wing_box(n-ii+1) = wing_box(k_max);
    wing_box(k_max) = wing_box_3;
end

end

