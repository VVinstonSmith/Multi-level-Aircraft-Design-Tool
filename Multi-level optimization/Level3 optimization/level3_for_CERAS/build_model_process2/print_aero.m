

%% 分段
%机翼面元展向分段：
% part1: 翼根 到 机翼转折处
m1_wing = 5;
n1_wing = 8;
% part2: 机翼转折处 到 平尾翼梢
m2_wing = 5;
n2_wing = 1;
% part3: 平尾翼梢 到 副翼翼根
m3_wing = 5;
n3_wing = 8;
% part4: 副翼翼根 到 副翼翼梢
m41_wing = 4;
n4_wing = 6;
% part42: 副翼
m42_wing = 2;
% part5: 副翼翼梢 到 翼梢
m5_wing = 4;
n5_wing = 2;

%平尾面元展向分段：
% part1: 
m11_htail = 4;
n1_htail = n1_wing;
% part12: 
m12_htail = 2;
% part2: 
m21_htail = 4;
n2_htail = n2_wing;
% part22: 
m22_htail = 2;

%垂尾面元展向分段：
% part1: 
m11_vtail = 4;
n1_vtail = 5;
% part12: 
m12_vtail = 2;

%% wing
% y
y1 = GRID_wing_1(2);
if y_kink_wing<GRID_htail_3(2)
    y2 = y_kink_wing;
    y3 = GRID_htail_3(2);
else
    y2 = GRID_htail_3(2);
    y3 = y_kink_wing;
end
y4 = GRID_ail_1(2);
y5 = GRID_ail_3(2);
y6 = GRID_wing_3(2);
% x_f x_r
x1_f = interp1([GRID_shape_1(2), GRID_shape_3(2)], [GRID_shape_1(1), GRID_shape_3(1)], y1, 'linear');
x1_r = interp1([GRID_shape_2(2), GRID_shape_4(2)], [GRID_shape_2(1), GRID_shape_4(1)], y1, 'linear');
x2_f = interp1([GRID_shape_1(2), GRID_shape_3(2)], [GRID_shape_1(1), GRID_shape_3(1)], y2, 'linear');
x2_r = interp1([GRID_shape_2(2), GRID_shape_4(2)], [GRID_shape_2(1), GRID_shape_4(1)], y2, 'linear');
if y_kink_wing>GRID_htail_3(2)
    x3_f = interp1([GRID_shape_1(2), GRID_shape_3(2)], [GRID_shape_1(1), GRID_shape_3(1)], y3, 'linear');
    x3_r = interp1([GRID_shape_2(2), GRID_shape_4(2)], [GRID_shape_2(1), GRID_shape_4(1)], y3, 'linear');
else
    x3_f = interp1([GRID_shape_3(2), GRID_shape_5(2)], [GRID_shape_3(1), GRID_shape_5(1)], y3, 'linear');
    x3_r = interp1([GRID_shape_4(2), GRID_shape_6(2)], [GRID_shape_4(1), GRID_shape_6(1)], y3, 'linear');
end
x41_f = interp1([GRID_shape_3(2), GRID_shape_5(2)], [GRID_shape_3(1), GRID_shape_5(1)], y4, 'linear');
x41_r = GRID_ail_1(1);
x42_f = GRID_ail_1(1);
x42_r = GRID_ail_2(1);
x51_f = interp1([GRID_shape_3(2), GRID_shape_5(2)], [GRID_shape_3(1), GRID_shape_5(1)], y5, 'linear');
x51_r = GRID_ail_3(1);
x52_f = GRID_ail_3(1);
x52_r = GRID_ail_4(1);
x6_f = interp1([GRID_shape_3(2), GRID_shape_5(2)], [GRID_shape_3(1), GRID_shape_5(1)], y6, 'linear');
x6_r = interp1([GRID_shape_4(2), GRID_shape_6(2)], [GRID_shape_4(1), GRID_shape_6(1)], y6, 'linear');
% z
z1 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y1, 'linear');
z2 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y2, 'linear');
z3 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y3, 'linear');
z4 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y4, 'linear');
z5 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y5, 'linear');
z6 = interp1([GRID_wing_1(2), GRID_wing_3(2)], [GRID_wing_1(3), GRID_wing_3(3)], y6, 'linear');

%wing 1
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rwing';
CAERO_id_Rwing = CAERO_id_Rwing + 100;
caero(CAERO_count).id = CAERO_id_Rwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x1_f, y1,z1];
caero(CAERO_count).P2 = [x1_r, y1,z1];
caero(CAERO_count).P3 = [x2_f, y2,z2];
caero(CAERO_count).P4 = [x2_r, y2,z2];
caero(CAERO_count).m = m1_wing;
caero(CAERO_count).n = n1_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lwing';
CAERO_id_Lwing = CAERO_id_Lwing + 100;
caero(CAERO_count).id = CAERO_id_Lwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x1_f, -y1,z1];
caero(CAERO_count).P2 = [x1_r, -y1,z1];
caero(CAERO_count).P3 = [x2_f, -y2,z2];
caero(CAERO_count).P4 = [x2_r, -y2,z2];
caero(CAERO_count).m = m1_wing;
caero(CAERO_count).n = n1_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%wing 2
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rwing';
CAERO_id_Rwing = CAERO_id_Rwing + 100;
caero(CAERO_count).id = CAERO_id_Rwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x2_f, y2,z2];
caero(CAERO_count).P2 = [x2_r, y2,z2];
caero(CAERO_count).P3 = [x3_f, y3,z3];
caero(CAERO_count).P4 = [x3_r, y3,z3];
caero(CAERO_count).m = m2_wing;
caero(CAERO_count).n = n2_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lwing';
CAERO_id_Lwing = CAERO_id_Lwing + 100;
caero(CAERO_count).id = CAERO_id_Lwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x2_f, -y2,z2];
caero(CAERO_count).P2 = [x2_r, -y2,z2];
caero(CAERO_count).P3 = [x3_f, -y3,z3];
caero(CAERO_count).P4 = [x3_r, -y3,z3];
caero(CAERO_count).m = m2_wing;
caero(CAERO_count).n = n2_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end

%wing 3
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rwing';
CAERO_id_Rwing = CAERO_id_Rwing + 100;
caero(CAERO_count).id = CAERO_id_Rwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x3_f, y3, z3];
caero(CAERO_count).P2 = [x3_r, y3, z3];
caero(CAERO_count).P3 = [x41_f, y4, z4];
caero(CAERO_count).P4 = [x42_r, y4, z4];
caero(CAERO_count).m = m3_wing;
caero(CAERO_count).n = n3_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lwing';
CAERO_id_Lwing = CAERO_id_Lwing + 100;
caero(CAERO_count).id = CAERO_id_Lwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x3_f, -y3, z3];
caero(CAERO_count).P2 = [x3_r, -y3, z3];
caero(CAERO_count).P3 = [x41_f, -y4, z4];
caero(CAERO_count).P4 = [x42_r, -y4, z4];
caero(CAERO_count).m = m3_wing;
caero(CAERO_count).n = n3_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end

%wing 41
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rwing';
CAERO_id_Rwing = CAERO_id_Rwing + 100;
caero(CAERO_count).id = CAERO_id_Rwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x41_f, y4, z4];
caero(CAERO_count).P2 = [x41_r, y4, z4];
caero(CAERO_count).P3 = [x51_f, y5, z5];
caero(CAERO_count).P4 = [x51_r, y5, z5];
caero(CAERO_count).m = m41_wing;
caero(CAERO_count).n = n4_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lwing';
CAERO_id_Lwing = CAERO_id_Lwing + 100;
caero(CAERO_count).id = CAERO_id_Lwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x41_f, -y4, z4];
caero(CAERO_count).P2 = [x41_r, -y4, z4];
caero(CAERO_count).P3 = [x51_f, -y5, z5];
caero(CAERO_count).P4 = [x51_r, -y5, z5];
caero(CAERO_count).m = m41_wing;
caero(CAERO_count).n = n4_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%wing 42
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rwing';
caero(CAERO_count).sub_region = 'aileron';
CAERO_id_Rwing = CAERO_id_Rwing + 50;
caero(CAERO_count).id = CAERO_id_Rwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x42_f, y4, z4];
caero(CAERO_count).P2 = [x42_r, y4, z4];
caero(CAERO_count).P3 = [x52_f, y5, z5];
caero(CAERO_count).P4 = [x52_r, y5, z5];
caero(CAERO_count).m = m42_wing;
caero(CAERO_count).n = n4_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lwing';
caero(CAERO_count).sub_region = 'aileron';
CAERO_id_Lwing = CAERO_id_Lwing + 50;
caero(CAERO_count).id = CAERO_id_Lwing;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x42_f, -y4, z4];
caero(CAERO_count).P2 = [x42_r, -y4, z4];
caero(CAERO_count).P3 = [x52_f, -y5, z5];
caero(CAERO_count).P4 = [x52_r, -y5, z5];
caero(CAERO_count).m = m42_wing;
caero(CAERO_count).n = n4_wing;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lwing')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end

if y6>y5
    %wing 5
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Rwing';
    CAERO_id_Rwing = CAERO_id_Rwing + 50;
    caero(CAERO_count).id = CAERO_id_Rwing;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x51_f, y5, z5];
    caero(CAERO_count).P2 = [x52_r, y5, z5];
    caero(CAERO_count).P3 = [x6_f, y6, z6];
    caero(CAERO_count).P4 = [x6_r, y6, z6];
    caero(CAERO_count).m = m5_wing;
    caero(CAERO_count).n = n5_wing;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Rwing')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end
    %
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Lwing';
    CAERO_id_Lwing = CAERO_id_Lwing + 50;
    caero(CAERO_count).id = CAERO_id_Lwing;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x51_f, -y5, z5];
    caero(CAERO_count).P2 = [x52_r, -y5, z5];
    caero(CAERO_count).P3 = [x6_f, -y6, z6];
    caero(CAERO_count).P4 = [x6_r, -y6, z6];
    caero(CAERO_count).m = m5_wing;
    caero(CAERO_count).n = n5_wing;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Lwing')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end
end

%% htail
x11_f_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(1), GRID_htail_3(1)], y1, 'linear');
x11_r_htail = interp1([GRID_ele_1(2), GRID_ele_3(2)], [GRID_ele_1(1), GRID_ele_3(1)], y1, 'linear');
x12_f_htail = x11_r_htail;
x12_r_htail = interp1([GRID_htail_2(2), GRID_htail_4(2)], [GRID_htail_2(1), GRID_htail_4(1)], y1, 'linear');
x21_f_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(1), GRID_htail_3(1)], y2, 'linear');
x21_r_htail = interp1([GRID_ele_1(2), GRID_ele_3(2)], [GRID_ele_1(1), GRID_ele_3(1)], y2, 'linear');
x22_f_htail = x21_r_htail;
x22_r_htail = interp1([GRID_htail_2(2), GRID_htail_4(2)], [GRID_htail_2(1), GRID_htail_4(1)], y2, 'linear');
if y_kink_wing<GRID_htail_3(2)
    x31_f_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(1), GRID_htail_3(1)], y3, 'linear');
    x31_r_htail = interp1([GRID_ele_1(2), GRID_ele_3(2)], [GRID_ele_1(1), GRID_ele_3(1)], y3, 'linear');
    x32_f_htail = x31_r_htail;
    x32_r_htail = interp1([GRID_htail_2(2), GRID_htail_4(2)], [GRID_htail_2(1), GRID_htail_4(1)], y3, 'linear');
end
%
z1_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(3), GRID_htail_3(3)], y1, 'linear');
z2_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(3), GRID_htail_3(3)], y2, 'linear');
if y_kink_wing<GRID_htail_3(2)
    z3_htail = interp1([GRID_htail_1(2), GRID_htail_3(2)], [GRID_htail_1(3), GRID_htail_3(3)], y3, 'linear');
end

%htail 11
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rhtail';
CAERO_id_Rhtail = CAERO_id_Rhtail + 100;
caero(CAERO_count).id = CAERO_id_Rhtail;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x11_f_htail, y1, z1_htail];
caero(CAERO_count).P2 = [x11_r_htail, y1, z1_htail];
caero(CAERO_count).P3 = [x21_f_htail, y2, z2_htail];
caero(CAERO_count).P4 = [x21_r_htail, y2, z2_htail];
caero(CAERO_count).m = m11_htail;
caero(CAERO_count).n = n1_htail;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rhtail')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lhtail';
CAERO_id_Lhtail = CAERO_id_Lhtail + 100;
caero(CAERO_count).id = CAERO_id_Lhtail;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x11_f_htail, -y1, z1_htail];
caero(CAERO_count).P2 = [x11_r_htail, -y1, z1_htail];
caero(CAERO_count).P3 = [x21_f_htail, -y2, z2_htail];
caero(CAERO_count).P4 = [x21_r_htail, -y2, z2_htail];
caero(CAERO_count).m = m11_htail;
caero(CAERO_count).n = n1_htail;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lhtail')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end

%htail 12
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Rhtail';
caero(CAERO_count).sub_region = 'elevator';
CAERO_id_Rhtail = CAERO_id_Rhtail + 50;
caero(CAERO_count).id = CAERO_id_Rhtail;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x12_f_htail, y1, z1_htail];
caero(CAERO_count).P2 = [x12_r_htail, y1, z1_htail];
caero(CAERO_count).P3 = [x22_f_htail, y2, z2_htail];
caero(CAERO_count).P4 = [x22_r_htail, y2, z2_htail];
caero(CAERO_count).m = m12_htail;
caero(CAERO_count).n = n1_htail;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Rhtail')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end
%
CAERO_count = CAERO_count + 1;
caero(CAERO_count) = CAERO();
caero(CAERO_count).region = 'Lhtail';
caero(CAERO_count).sub_region = 'elevator';
CAERO_id_Lhtail = CAERO_id_Lhtail + 50;
caero(CAERO_count).id = CAERO_id_Lhtail;
caero(CAERO_count).pid = PAERO_id;
caero(CAERO_count).P1 = [x12_f_htail, -y1, z1_htail];
caero(CAERO_count).P2 = [x12_r_htail, -y1, z1_htail];
caero(CAERO_count).P3 = [x22_f_htail, -y2, z2_htail];
caero(CAERO_count).P4 = [x22_r_htail, -y2, z2_htail];
caero(CAERO_count).m = m12_htail;
caero(CAERO_count).n = n1_htail;
for ii = 1:length(grids_set)
    if strcmp(grids_set(ii).sub_region,'Lhtail')
        caero(CAERO_count).SET_num = ii;
        caero(CAERO_count).SET_id = grids_set(ii).id;
    end
end

if y_kink_wing<GRID_htail_3(2)
    %htail 21
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Rhtail';
    CAERO_id_Rhtail = CAERO_id_Rhtail + 50;
    caero(CAERO_count).id = CAERO_id_Rhtail;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x21_f_htail, y2, z2_htail];
    caero(CAERO_count).P2 = [x21_r_htail, y2, z2_htail];
    caero(CAERO_count).P3 = [x31_f_htail, y3, z3_htail];
    caero(CAERO_count).P4 = [x31_r_htail, y3, z3_htail];
    caero(CAERO_count).m = m21_htail;
    caero(CAERO_count).n = n2_htail;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Rhtail')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end
    %
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Lhtail';
    CAERO_id_Lhtail = CAERO_id_Lhtail + 50;
    caero(CAERO_count).id = CAERO_id_Lhtail;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x21_f_htail, -y2, z2_htail];
    caero(CAERO_count).P2 = [x21_r_htail, -y2, z2_htail];
    caero(CAERO_count).P3 = [x31_f_htail, -y3, z3_htail];
    caero(CAERO_count).P4 = [x31_r_htail, -y3, z3_htail];
    caero(CAERO_count).m = m21_htail;
    caero(CAERO_count).n = n2_htail;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Lhtail')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end

    %htail 22
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Rhtail';
    caero(CAERO_count).sub_region = 'elevator';
    CAERO_id_Rhtail = CAERO_id_Rhtail + 50;
    caero(CAERO_count).id = CAERO_id_Rhtail;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x22_f_htail, y2, z2_htail];
    caero(CAERO_count).P2 = [x22_r_htail, y2, z2_htail];
    caero(CAERO_count).P3 = [x32_f_htail, y3, z3_htail];
    caero(CAERO_count).P4 = [x32_r_htail, y3, z3_htail];
    caero(CAERO_count).m = m22_htail;
    caero(CAERO_count).n = n2_htail;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Rhtail')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end
    %
    CAERO_count = CAERO_count + 1;
    caero(CAERO_count) = CAERO();
    caero(CAERO_count).region = 'Lhtail';
    caero(CAERO_count).sub_region = 'elevator';
    CAERO_id_Lhtail = CAERO_id_Lhtail + 50;
    caero(CAERO_count).id = CAERO_id_Lhtail;
    caero(CAERO_count).pid = PAERO_id;
    caero(CAERO_count).P1 = [x22_f_htail, -y2, z2_htail];
    caero(CAERO_count).P2 = [x22_r_htail, -y2, z2_htail];
    caero(CAERO_count).P3 = [x32_f_htail, -y3, z3_htail];
    caero(CAERO_count).P4 = [x32_r_htail, -y3, z3_htail];
    caero(CAERO_count).m = m22_htail;
    caero(CAERO_count).n = n2_htail;
    for ii = 1:length(grids_set)
        if strcmp(grids_set(ii).sub_region,'Lhtail')
            caero(CAERO_count).SET_num = ii;
            caero(CAERO_count).SET_id = grids_set(ii).id;
        end
    end
end
%% vtail
% % vtail 11
% CAERO_count = CAERO_count + 1;
% caero(CAERO_count) = CAERO();
% caero(CAERO_count).region = 'vtail';
% CAERO_id_vtail = CAERO_id_vtail + 100;
% caero(CAERO_count).id = CAERO_id_vtail;
% caero(CAERO_count).pid = PAERO_id;
% caero(CAERO_count).P1 = GRID_vtail_1;
% caero(CAERO_count).P2 = GRID_rud_1;
% caero(CAERO_count).P3 = GRID_vtail_3;
% caero(CAERO_count).P4 = GRID_rud_3;
% caero(CAERO_count).m = m11_vtail;
% caero(CAERO_count).n = n1_vtail;
% for ii = 1:length(grids_set)
%     if strcmp(grids_set(ii).region,'vtail')
%         caero(CAERO_count).SET_num = ii;
%         caero(CAERO_count).SET_id = grids_set(ii).id;
%     end
% end
% 
% % vtail 12
% CAERO_count = CAERO_count + 1;
% caero(CAERO_count) = CAERO();
% caero(CAERO_count).region = 'vtail';
% caero(CAERO_count).sub_region = 'rudder';
% CAERO_id_vtail = CAERO_id_vtail + 50;
% caero(CAERO_count).id = CAERO_id_vtail;
% caero(CAERO_count).pid = PAERO_id;
% caero(CAERO_count).P1 = GRID_rud_1;
% caero(CAERO_count).P2 = GRID_vtail_2;
% caero(CAERO_count).P3 = GRID_rud_3;
% caero(CAERO_count).P4 = GRID_vtail_4;
% caero(CAERO_count).m = m12_vtail;
% caero(CAERO_count).n = n1_vtail;
% for ii = 1:length(grids_set)
%     if strcmp(grids_set(ii).region,'vtail')
%         caero(CAERO_count).SET_num = ii;
%         caero(CAERO_count).SET_id = grids_set(ii).id;
%     end
% end


%% print_CAERO1
fprintf(fid,'$\n');
print_PAERO1(fid, PAERO_id);

fprintf(fid,'$\n');
fprintf(fid,'$ right wing\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rwing') == 1 && strcmp(caero(ii).sub_region,'aileron') == 0
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end
fprintf(fid,'$ right aileron\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rwing') == 1 && strcmp(caero(ii).sub_region,'aileron') == 1
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ left wing\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lwing') == 1 && strcmp(caero(ii).sub_region,'aileron') == 0
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end
fprintf(fid,'$ left aileron\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lwing') == 1 && strcmp(caero(ii).sub_region,'aileron') == 1
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ right htail\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rhtail') == 1 && strcmp(caero(ii).sub_region,'elevator') == 0
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end
fprintf(fid,'$ right elevator\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rhtail') == 1 && strcmp(caero(ii).sub_region,'elevator') == 1
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ left htail\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lhtail') == 1 && strcmp(caero(ii).sub_region,'elevator') == 0
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end
fprintf(fid,'$ left elevator\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lhtail') == 1 && strcmp(caero(ii).sub_region,'elevator') == 1
        print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
            caero(ii).n, caero(ii).m,...
            caero(ii).P1, caero(ii).L1(),...
            caero(ii).P3, caero(ii).L3());
    end
end

% fprintf(fid,'$\n');
% fprintf(fid,'$ vtail\n');
% for ii = 1:length(caero)
%     if strcmp(caero(ii).region,'vtail') == 1 && strcmp(caero(ii).sub_region,'rudder') == 0
%         print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
%             caero(ii).n, caero(ii).m,...
%             caero(ii).P1, caero(ii).L1(),...
%             caero(ii).P3, caero(ii).L3());
%     end
% end
% fprintf(fid,'$ rudder\n');
% for ii = 1:length(caero)
%     if strcmp(caero(ii).region,'vtail') == 1 && strcmp(caero(ii).sub_region,'rudder') == 1
%         print_CAERO1(fid, caero(ii).id, caero(ii).pid,...
%             caero(ii).n, caero(ii).m,...
%             caero(ii).P1, caero(ii).L1(),...
%             caero(ii).P3, caero(ii).L3());
%     end
% end


%% print_SPLINE(fid, EID, CAERO, CAERO_num, AELIST, SET_id, SET, method, FPS_num)
AELIST_count = 0;

fprintf(fid,'$\n');
fprintf(fid,'$ right wing\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rwing') == 1 && strcmp(caero(ii).sub_region,'aileron')==0
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end
fprintf(fid,'$\n');
fprintf(fid,'$ right aileron\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rwing')==1 && strcmp(caero(ii).sub_region,'aileron')==1   
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ left wing\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lwing') == 1 && strcmp(caero(ii).sub_region,'aileron')==0
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end
fprintf(fid,'$\n');
fprintf(fid,'$ left aileron\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lwing')==1 && strcmp(caero(ii).sub_region,'aileron')==1   
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ right htail\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rhtail') == 1 && strcmp(caero(ii).sub_region,'elevator')==0
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end
fprintf(fid,'$\n');
fprintf(fid,'$ right elevator\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rhtail') == 1 && strcmp(caero(ii).sub_region,'elevator')==1
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end

fprintf(fid,'$\n');
fprintf(fid,'$ left htail\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lhtail') == 1 && strcmp(caero(ii).sub_region,'elevator')==0
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end
fprintf(fid,'$\n');
fprintf(fid,'$ leftt elevator\n');
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Lhtail') == 1 && strcmp(caero(ii).sub_region,'elevator')==1
        EID = caero(ii).id;
        CAERO_id = caero(ii).id;
        CAERO_num = caero(ii).m * caero(ii).n;
        AELIST_count = AELIST_count + 1;
        SET_id = caero(ii). SET_id;
        SET_num =  caero(ii). SET_num;
        print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
    end
end
% 
% fprintf(fid,'$\n');
% fprintf(fid,'$ vtail\n');
% for ii = 1:length(caero)
%     if strcmp(caero(ii).region,'vtail') == 1 && strcmp(caero(ii).sub_region,'rudder')==0
%         EID = caero(ii).id;
%         CAERO_id = caero(ii).id;
%         CAERO_num = caero(ii).m * caero(ii).n;
%         AELIST_count = AELIST_count + 1;
%         SET_id = caero(ii). SET_id;
%         SET_num =  caero(ii). SET_num;
%         print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
%     end
% end
% fprintf(fid,'$\n');
% fprintf(fid,'$ rudder\n');
% for ii = 1:length(caero)
%     if strcmp(caero(ii).region,'vtail') == 1 && strcmp(caero(ii).sub_region,'rudder')==1
%         EID = caero(ii).id;
%         CAERO_id = caero(ii).id;
%         CAERO_num = caero(ii).m * caero(ii).n;
%         AELIST_count = AELIST_count + 1;
%         SET_id = caero(ii). SET_id;
%         SET_num =  caero(ii). SET_num;
%         print_SPLINE(fid, EID, CAERO_id, CAERO_num, AELIST_count, SET_id, 0, 'FPS', [10,10]);
%     end
% end

%% print SET
fprintf(fid,'$\n');
for ii= 1:4%length(grids_set)
    grids_set(ii).GRIDs_id = zeros(size(grids_set(ii).GRIDs_num));
    for jj = 1:length(grids_set(ii).GRIDs_num)
        grids_set(ii).GRIDs_id(jj) = grids(grids_set(ii).GRIDs_num(jj)).id;
    end
    print_SET(fid,grids_set(ii).id, grids_set(ii).region, grids_set(ii).GRIDs_id);
end
fprintf(fid,'$\n');


rotate_range = [-1.047,1.047];
%% 操纵面 print_AESURF
SURF_id = 0;

% aileron
fprintf(fid,'$\n');
fprintf(fid,'$aileron\n');
SURF_id = SURF_id+1;
AESURF_aileron_id = SURF_id;
SURF_name = 'AIL';
CREF = C_A_wing;
SREF = S_wing;
Coord_1 = 1;
Coord_2 = 2;
AELIST_count = AELIST_count + 2;
CAERO_1=[];
CAERO_2=[];
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rwing')==1 && strcmp(caero(ii).sub_region,'aileron')==1
        m = caero(ii).m;
        n = caero(ii).n;
        CAERO_1 = [CAERO_1, caero(ii).id : caero(ii).id + m*n - 1];
    end
    if strcmp(caero(ii).region,'Lwing')==1 && strcmp(caero(ii).sub_region,'aileron')==1
        m = caero(ii).m;
        n = caero(ii).n;
        CAERO_2 = [CAERO_2, caero(ii).id : caero(ii).id + m*n - 1];
    end
end
print_AESURF(fid, SURF_id, SURF_name, CREF, SREF, rotate_range,...
    Coord_1, AELIST_count-1, CAERO_1,...
    Coord_2, AELIST_count, CAERO_2);

% elevator
fprintf(fid,'$\n');
fprintf(fid,'$elevator\n');
SURF_id = SURF_id+1;
SURF_name = 'ELE';
CREF = C_A_htail;
SREF = S_htail;
Coord_1 = 3;
Coord_2 = 4;
AELIST_count = AELIST_count + 2;
CAERO_1=[];
CAERO_2=[];
for ii = 1:length(caero)
    if strcmp(caero(ii).region,'Rhtail')==1 && strcmp(caero(ii).sub_region,'elevator')==1
        m = caero(ii).m;
        n = caero(ii).n;
        CAERO_1 = [CAERO_1, caero(ii).id : caero(ii).id + m*n - 1];
    end
    if strcmp(caero(ii).region,'Lhtail')==1 && strcmp(caero(ii).sub_region,'elevator')==1
        m = caero(ii).m;
        n = caero(ii).n;
        CAERO_2 = [CAERO_2, caero(ii).id : caero(ii).id + m*n - 1];
    end
end
print_AESURF(fid, SURF_id, SURF_name, CREF, SREF, rotate_range,...
    Coord_1, AELIST_count-1, CAERO_1,...
    Coord_2, AELIST_count, CAERO_2);

% rudder
% fprintf(fid,'$\n');
% fprintf(fid,'$rudder\n');
% SURF_id = SURF_id+1;
% SURF_name = 'RUD';
% CREF = C_A_vtail;
% SREF = S_vtail;
% Coord_1 = 5;
% AELIST_count = AELIST_count + 1;
% CAERO_1=[];
% for ii = 1:length(caero)
%     if strcmp(caero(ii).region,'vtail')==1 && strcmp(caero(ii).sub_region,'rudder')==1
%         m = caero(ii).m;
%         n = caero(ii).n;
%         CAERO_1 = [CAERO_1, caero(ii).id : caero(ii).id + m*n - 1];
%     end
% end
% print_AESURF(fid, SURF_id, SURF_name, CREF, SREF, rotate_range,...
%     Coord_1, AELIST_count, CAERO_1,...
%     0, 0, 0);
% fprintf(fid,'$\n');

