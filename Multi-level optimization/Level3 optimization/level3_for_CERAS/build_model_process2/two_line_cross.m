function p = two_line_cross(P1,P2,P3,P4)


a = (P2(1)-P1(1))*(P3(2)-P4(2));
b = (P3(1)-P4(1))*(P2(2)-P1(2));
c = (P3(2)-P2(2))*(P1(1)-P2(1))*(P4(1)-P3(1));
x = (b*P2(1)-a*P3(1)+c) / (b-a);

if abs(P1(1)-P2(1))>1e-4
    y = (x-P2(1))*(P1(2)-P2(2))/(P1(1)-P2(1))+P2(2);
else
    y = (x-P3(1))*(P4(2)-P3(2))/(P4(1)-P3(1))+P3(2);
end
p = [x, y];
% figure(3);
% axis equal; hold on;
% plot([P1(1),P2(1)], [P1(2),P2(2)] ,'-*'); hold on;
% plot([P3(1),P4(1)], [P3(2),P4(2)] ,'-*'); hold on;
% plot(x,y,'o'); hold on;
end

