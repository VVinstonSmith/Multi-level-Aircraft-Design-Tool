function y = plot3_line(P1,P2, color, linewidth)
y=0;
plot3([P1(1),P2(1)], [P1(2),P2(2)], [P1(3),P2(3)], color, 'linewidth', linewidth);
hold on;
end

