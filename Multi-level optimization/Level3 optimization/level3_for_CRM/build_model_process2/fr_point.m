function [Pfx, Pfy, Prx, Pry] = fr_point(GRID_1, GRID_2, GRID_3, GRID_4, GRID_5, GRID_6, GRID_s)

P1 = GRID_1(1:2);
P2 = GRID_3(1:2);
P3 = GRID_s(1:2);
P4  = [0,0];
P4(2) = -(P4(1)-P3(1))*(GRID_6(1)-GRID_5(1))/(GRID_6(2)-GRID_5(2)) + P3(2);
P = two_line_cross(P1,P2,P3,P4);
Pfx = P(:,1); 
Pfy = P(:,2); 

P1 = GRID_2(1:2);
P2 = GRID_4(1:2);
P3 = GRID_s(1:2);
P4  = [0,0];
P4(2) = -(P4(1)-P3(1))*(GRID_6(1)-GRID_5(1))/(GRID_6(2)-GRID_5(2)) + P3(2);
P= two_line_cross(P1,P2,P3,P4);
Prx = P(:,1); 
Pry = P(:,2); 
end

