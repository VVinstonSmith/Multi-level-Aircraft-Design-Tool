clear; 
close all;

airfoil(1) = AIRFOIL('airfoil_root', 1, 0:0.1:1, 0.18*ones(11,1));
airfoil(2) = AIRFOIL('airfoil_tip', 2, 0:0.1:1, 0.09*ones(11,1));

POINT1 = [0,0];
POINT2 = [1,0];
POINT3 = [0.3,1];
POINT4 = [0.7,1];
POINT5 = POINT1 + 0.25*(POINT2-POINT1);
POINT6 = POINT3 + 0.25*(POINT4-POINT3);
POINT5 = POINT5 + 0.25*(POINT5-POINT6);
POINT6 = POINT6 + 0.25*(POINT6-POINT5);
%
Cf_root = 0.3;
Cr_root = 0.7;
Cs_root = 0.4 : 0.1 : 0.6;
Cf_tip = 0.3;
Cr_tip = 0.5;
Cs_tip = 0.3 : 0.1 : 0.5;


wing_part = WING_PART(POINT1,POINT2,POINT3,POINT4,POINT5,POINT6, 1, 4);
wing_part = wing_part.get_airfoil(1, 2);
%
wing_part = wing_part.STR_pos(Cf_root,Cr_root,Cs_root,Cf_tip,Cr_tip,Cs_tip);
%
wing_part = wing_part.cut_block_ave(8);
%
wing_part = wing_part.cal_thick(airfoil);

figure(5);axis equal; hold on;
wing_part.plot_shape();

% figure(6);axis equal; hold on;
wing_part.plot_STRpoint();
wing_part.plot_block_point();
wing_part.plot_STRpoint_xyz();




