function P = vertical_cross_point( P1,P2,P0,P3,P4 )
%��P0 ��ֱ��P1P2����P3P4��P

P0_bar = (P1-P2)*[0,-1;1,0] + P0;
P = two_line_cross(P3,P4,P0,P0_bar);


end

