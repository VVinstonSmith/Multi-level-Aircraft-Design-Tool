function y = plot3_square(P1,P2,P3,P4, m,n, color, linewidth)
y=m*n;

for ii=1:n+1
    G1 = P1 + (ii-1)*(P3-P1)/n;
    G2 = P2 + (ii-1)*(P4-P2)/n;
    plot3([G1(1),G2(1)], [G1(2),G2(2)], [G1(3),G2(3)], color, 'linewidth', linewidth);
    hold on;
end
for ii = 1:m+1
    G1 = P1 + (ii-1)*(P2-P1)/m;
    G3 = P3 + (ii-1)*(P4-P3)/m;
    plot3([G1(1),G3(1)], [G1(2),G3(2)], [G1(3),G3(3)], color, 'linewidth', linewidth);
end

end

