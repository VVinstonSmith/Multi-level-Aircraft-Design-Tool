
% GRID_shape_1 = [Xf_root, 0, height_wing];
% GRID_shape_2 = [Xr_root, 0, height_wing];
% GRID_shape_3 = [Xf_kink, b_inner, height_wing+b_inner*tan(up_angle)];
% GRID_shape_4 = [Xr_kink, b_inner, height_wing+b_inner*tan(up_angle)];
% GRID_shape_5 = [Xf_tip, 0.5*Bref, height_wing+0.5*Bref*tan(up_angle)];
% GRID_shape_6 = [Xr_tip, 0.5*Bref, height_wing+0.5*Bref*tan(up_angle)];

for ii = 1:length(airfoil)
    if strcmp(airfoil(ii).name, airfoil_wing) == 1
        airfoil_wing = airfoil(ii);
    end
    if strcmp(airfoil(ii).name, airfoil_htail) == 1
        airfoil_htail = airfoil(ii);
    end
end

%% outer part
P1 = GRID_shape_3([1,2]);
P2 = GRID_shape_4([1,2]);
P3 = GRID_shape_5([1,2]);
P4 = GRID_shape_6([1,2]);
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART(P1, P2, P3, P4,...
                            Cf_kink, Cr_kink, Cf_tip, Cr_tip,...
                            2.5, 0, 'wing', 'z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_wing, dihedral_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cut_block_ave(nb_outer);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cal_thick(airfoil_wing, half_span_wing);
% cut_into_box
nbb=nbb_outer;
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'wing', 'z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count,nbb,nc, [0,0,1]);

%% inner part
P1 = GRID_shape_1([1,2]);
P2 = GRID_shape_2([1,2]);
P3 = GRID_shape_3([1,2]);
P4 = GRID_shape_4([1,2]);
P1(1) = interp1([P1(2),P3(2)], [P1(1),P3(1)], 0.5*body_width_wing, 'linear');
P1(2) = 0.5*body_width_wing;
P2(1) = interp1([P2(2),P4(2)], [P2(1),P4(1)], 0.5*body_width_wing, 'linear');
P2(2) = 0.5*body_width_wing;
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART(P1, P2, P3, P4,...
                            Cf_root, Cr_root, Cf_kink, Cr_kink,...
                            0, 3, 'wing','z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_wing, dihedral_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cut_block_ave(nb_inner);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cal_thick(airfoil_wing, half_span_wing);
% cut_into_box
nbb=nbb_inner;
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'wing','z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);

%% center part
P3 = P1;
P4 = P2;
P1(2) = 0;
P2(2) = 0;
WING_PART_count = WING_PART_count+1;
wing_center_part_right_num = WING_PART_count;% 右中央翼序号(用于翼身连接)
wing_part(WING_PART_count) = WING_PART(P1, P2, P3, P4,...
                            Cf_root, Cr_root,  Cf_root, Cr_root,...
                            0, 0, 'wing','z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_wing, dihedral_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cut_block_ave(nb_center);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cal_thick(airfoil_wing, half_span_wing);
% cut_into_box
nbb=nbb_center;
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
wing_center_part_left_num = WING_PART_count;% 左中央翼序号(用于翼身连接)
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'wing','z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);

%% kink part
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'wing','z', n_str_wing);
inner_part_num = 3;
outer_part_num = 1;
wing_part(WING_PART_count) =...
    wing_part(WING_PART_count).connect_part_th(wing_part(inner_part_num), wing_part(outer_part_num), nb_connect);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_wing, dihedral_wing);
nbb=nbb_connect;
% cut_into_box
[wing_box, WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'wing','z', n_str_wing);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);

%% htail outer part
P1 = GRID_htail_1([1,2]);
P2 = GRID_htail_2([1,2]);
P3 = GRID_htail_3([1,2]);
P4 = GRID_htail_4([1,2]);
P1(1) = interp1([P1(2),P3(2)], [P1(1),P3(1)], 0.5*body_width_htail, 'linear');
P1(2) = 0.5*body_width_htail;
P2(1) = interp1([P2(2),P4(2)], [P2(1),P4(1)], 0.5*body_width_htail, 'linear');
P2(2) = 0.5*body_width_htail;
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART(P1, P2, P3, P4,...
                            Cf_htail_root, Cr_htail_root, Cf_htail_tip, Cr_htail_tip,...
                            0, 0, 'htail','z', n_str_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_htail, dihedral_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cut_block_vertical(nb_outer_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cal_thick(airfoil_htail, half_span_htail);
% cut_into_box
nbb = nbb_outer_htail;
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'htail','z', n_str_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count,nbb,nc, [0,0,1]);

%% htail center part
P3 = P1;
P4 = P2;
P1(2) = 0;
P2(2) = 0;
WING_PART_count = WING_PART_count+1;
htail_center_part_left_num = WING_PART_count;% 平尾左中央翼序号(用于翼身连接)
wing_part(WING_PART_count) = WING_PART(P1, P2, P3, P4,...
                            Cf_htail_root, Cr_htail_root, Cf_htail_root, Cr_htail_root,...
                            0, 0, 'htail', 'z', n_str_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).get_z(height_htail, dihedral_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cut_block_ave(nb_center_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count).cal_thick(airfoil_htail, half_span_htail);
% cut_into_box
nbb = nbb_center_htail;
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);
% symmetry
WING_PART_count = WING_PART_count+1;
htail_center_part_right_num = WING_PART_count;% 平尾右中央翼序号(用于翼身连接)
wing_part(WING_PART_count) = WING_PART([0,0],[0,0],[0,0],[0,0],...
                            0, 0, 0, 0, 0, 0, 'htail','z', n_str_htail);
wing_part(WING_PART_count) = wing_part(WING_PART_count-1).vers_y();
% cut_into_box
[wing_box,WING_BOX_count]=...
    wing_part(WING_PART_count).cut_into_box(wing_box,WING_BOX_count, nbb,nc, [0,0,1]);




