
%% build AERO_BLOCK
AERO_BLOCK_n = 0;

%% 机翼平面形状计算
% parameters already known:
% half_span_wing, C_root_wing, taper_inner_wing, taper_outer_wing, span_eta, 
% sweep_wing_inner, sweep_wing_outer, X25_root_wing, height_wing, dihedral_wing, 
% body_width_wing 
C_kink_wing = C_root_wing * taper_inner_wing;
C_tip_wing = C_kink_wing * taper_outer_wing;
y_kink_wing = half_span_wing * span_eta;
y_tip_wing = half_span_wing;
X25_kink_wing = X25_root_wing + y_kink_wing * tan(sweep_wing_inner);
X25_tip_wing = X25_kink_wing + (y_tip_wing-y_kink_wing) * tan(sweep_wing_outer);
Xf_root_wing = X25_root_wing - 0.25*C_root_wing;
Xf_kink_wing = X25_kink_wing - 0.25*C_kink_wing;
Xf_tip_wing = X25_tip_wing - 0.25*C_tip_wing;
Xr_root_wing = X25_root_wing + 0.75*C_root_wing;
Xr_kink_wing = X25_kink_wing + 0.75*C_kink_wing;
Xr_tip_wing = X25_tip_wing + 0.75*C_tip_wing;
tan_Dih_wing = tan(dihedral_wing);
% 6grids for plane method
GRID_shape_1 = [Xf_root_wing, 0, height_wing];
GRID_shape_2 = [Xr_root_wing, 0, height_wing];
GRID_shape_3 = [Xf_kink_wing, y_kink_wing, height_wing + y_kink_wing*tan_Dih_wing];
GRID_shape_4 = [Xr_kink_wing, y_kink_wing, height_wing + y_kink_wing*tan_Dih_wing];
GRID_shape_5 = [Xf_tip_wing, y_tip_wing, height_wing + y_tip_wing*tan_Dih_wing];
GRID_shape_6 = [Xr_tip_wing, y_tip_wing, height_wing + y_tip_wing*tan_Dih_wing];
% 4 grids for wing
GRID_wing_1 = GRID_shape_1;
GRID_wing_2 = GRID_shape_2;
GRID_wing_3 = GRID_shape_5;
GRID_wing_4 = GRID_shape_6;
GRID_wing_1(1) = Xf_tip_wing + (Xf_kink_wing-Xf_tip_wing)/(1-span_eta);
GRID_wing_2(1) = Xr_tip_wing + (Xr_kink_wing-Xr_tip_wing)/(1-span_eta);
% Rwing_inner
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Rwing';
aero_block(AERO_BLOCK_n).sub_region = 'inner';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_shape_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_shape_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_shape_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_shape_4;
% Rwing_outer
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Rwing';
aero_block(AERO_BLOCK_n).sub_region = 'outer';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_shape_3;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_shape_4;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_shape_5;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_shape_6;
% Lwing_inner
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Lwing';
aero_block(AERO_BLOCK_n).sub_region = 'inner';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = vers_y(GRID_shape_1);
aero_block(AERO_BLOCK_n).GRID_2 = vers_y(GRID_shape_2);
aero_block(AERO_BLOCK_n).GRID_3 = vers_y(GRID_shape_3);
aero_block(AERO_BLOCK_n).GRID_4 = vers_y(GRID_shape_4);
% Lwing_outer
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Lwing';
aero_block(AERO_BLOCK_n).sub_region = 'outer';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = vers_y(GRID_shape_3);
aero_block(AERO_BLOCK_n).GRID_2 = vers_y(GRID_shape_4);
aero_block(AERO_BLOCK_n).GRID_3 = vers_y(GRID_shape_5);
aero_block(AERO_BLOCK_n).GRID_4 = vers_y(GRID_shape_6);
% C_A_wing
C_A_wing = 0;
S_wing = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'Rwing')==1
        S_wing = S_wing + aero_block(ii).S();
        C_A_wing = C_A_wing + aero_block(ii).C_A() * aero_block(ii).S();
    end
end
C_A_wing = C_A_wing/S_wing;
%X_F
X_F_wing = 0;
S_wing = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'Rwing')==1
        S_wing = S_wing + aero_block(ii).S();
        X_F_wing = X_F_wing + aero_block(ii).X_F(Xf_root_wing) * aero_block(ii).S();
    end
end
X_F_wing = X_F_wing/S_wing + Xf_root_wing;
S_wing = S_wing * 2;
%% 平尾平面形状计算
% parameters already known:
% half_span_htail, C_root_htail, taper_htail,
% sweep_htail, X25_root_htail, height_htail, dihedral_htail, 
% body_width_htail 
C_tip_htail = C_root_htail * taper_htail;
y_tip_htail = half_span_htail;
X25_tip_htail = X25_root_htail + y_tip_htail * tan(sweep_htail);
Xf_root_htail = X25_root_htail - 0.25*C_root_htail;
Xf_tip_htail = X25_tip_htail - 0.25*C_tip_htail;
Xr_root_htail = X25_root_htail + 0.75*C_root_htail;
Xr_tip_htail = X25_tip_htail + 0.75*C_tip_htail;
tan_Dih_htail = tan(dihedral_htail);

% 4 grids
GRID_htail_1 = [Xf_root_htail, 0, height_htail];
GRID_htail_2 = [Xr_root_htail, 0, height_htail];
GRID_htail_3 = [Xf_tip_htail, y_tip_htail, height_htail + y_tip_htail*tan_Dih_htail];
GRID_htail_4 = [Xr_tip_htail, y_tip_htail, height_htail + y_tip_htail*tan_Dih_htail];
% Rhtail
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Rhtail';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_htail_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_htail_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_htail_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_htail_4;
% Lhtail
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Lhtail';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = vers_y(GRID_htail_1);
aero_block(AERO_BLOCK_n).GRID_2 = vers_y(GRID_htail_2);
aero_block(AERO_BLOCK_n).GRID_3 = vers_y(GRID_htail_3);
aero_block(AERO_BLOCK_n).GRID_4 = vers_y(GRID_htail_4);
%X_F_htail
X_F_htail = 0;
S_htail = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'Rhtail')==1
        S_htail = S_htail + aero_block(ii).S();
        X_F_htail = X_F_htail + aero_block(ii).X_F(Xf_root_htail) * aero_block(ii).S();
    end
end
X_F_htail = X_F_htail/S_htail;
X_F_htail = X_F_htail/S_htail + Xf_root_htail;
% C_A_htail
C_A_htail = 0;
S_htail = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'Rhtail')==1
        S_htail = S_htail + aero_block(ii).S();
        C_A_htail = C_A_htail + aero_block(ii).C_A() * aero_block(ii).S();
    end
end
C_A_htail = C_A_htail/S_htail;
S_htail = S_htail * 2;
%% 垂尾平面形状计算
C_tip_vtail = C_root_vtail * taper_vtail;
z_tip_vtail = half_span_vtail + height_vtail;
X25_tip_vtail = X25_root_vtail + z_tip_vtail * tan(sweep_vtail);
Xf_root_vtail = X25_root_vtail - 0.25*C_root_vtail;
Xf_tip_vtail = X25_tip_vtail - 0.25*C_tip_vtail;
Xr_root_vtail = X25_root_vtail + 0.75*C_root_vtail;
Xr_tip_vtail = X25_tip_vtail + 0.75*C_tip_vtail;

% 4 grids
GRID_vtail_1 = [Xf_root_vtail, 0, height_vtail];
GRID_vtail_2 = [Xr_root_vtail, 0, height_vtail];
GRID_vtail_3 = [Xf_tip_vtail, 0, height_vtail + z_tip_vtail];
GRID_vtail_4 = [Xr_tip_vtail, 0, height_vtail + z_tip_vtail];
% vtail
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'vtail';
aero_block(AERO_BLOCK_n).aero_vector = 'y';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_vtail_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_vtail_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_vtail_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_vtail_4;
%X_F_vtail
X_F_vtail = 0;
S_vtail = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'vtail')==1
        S_vtail = S_vtail + aero_block(ii).S();
        X_F_vtail = X_F_vtail + aero_block(ii).X_F(Xf_root_vtail) * aero_block(ii).S();
    end
end
X_F_vtail = X_F_vtail/S_vtail + Xf_root_vtail;
% C_A_vtail
C_A_vtail = 0;
S_vtail = 0;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).region,'vtail')==1
        S_vtail = S_vtail + aero_block(ii).S();
        C_A_vtail = C_A_vtail + aero_block(ii).C_A() * aero_block(ii).S();
    end
end
C_A_vtail = C_A_vtail/S_vtail;
%% 操纵面形状计算
% aileron_4grids
inner_f_x = interp1([0,1], [GRID_wing_1(1),GRID_wing_3(1)], aileron_y(1),'linear'); 
inner_y = interp1([0,1], [GRID_wing_1(2),GRID_wing_3(2)], aileron_y(1),'linear'); 
inner_z = inner_y*tan_Dih_wing + height_wing;
inner_r_x = interp1([0,1], [GRID_wing_2(1),GRID_wing_4(1)], aileron_y(1),'linear'); 
GRID_ail_1 = [inner_f_x + aileron_x(1)*(inner_r_x-inner_f_x), inner_y, inner_z];
GRID_ail_2 = [inner_r_x, inner_y, inner_z];
outer_f_x = interp1([0,1], [GRID_wing_1(1),GRID_wing_3(1)], aileron_y(2),'linear'); 
outer_y = interp1([0,1], [GRID_wing_1(2),GRID_wing_3(2)], aileron_y(2),'linear'); 
outer_z = outer_y*tan_Dih_wing + height_wing;
outer_r_x = interp1([0,1], [GRID_wing_2(1),GRID_wing_4(1)], aileron_y(2),'linear'); 
GRID_ail_3 = [outer_f_x + aileron_x(2)*(outer_r_x-outer_f_x), outer_y, outer_z];
GRID_ail_4 = [outer_r_x, outer_y, outer_z];
% aileron shaft
[Pfx, Pfy, Prx, Pry] = fr_point(GRID_wing_1, GRID_wing_2, GRID_wing_3, GRID_wing_4, GRID_ail_1, GRID_ail_3, GRID_ail_1);
Prz = Pry*tan_Dih_wing + height_wing;
aileron_vec_x = ([Prx,Pry,Prz]-GRID_ail_1) / norm([Prx,Pry,Prz]-GRID_ail_1);
aileron_vec_y = (GRID_ail_1 - GRID_ail_3) / norm(GRID_ail_1 - GRID_ail_3);
aileron_vec_z = cross(aileron_vec_x, aileron_vec_y);

% elevator_4grids
GRID_ele_1 = [GRID_htail_1(1) + elevator_x(1)*(GRID_htail_2(1)-GRID_htail_1(1)), 0, height_htail];
GRID_ele_2 = GRID_htail_2;
GRID_ele_3 = [GRID_htail_3(1) + elevator_x(1)*(GRID_htail_4(1)-GRID_htail_3(1)), GRID_htail_3(2), height_htail+y_tip_htail*tan_Dih_htail];
GRID_ele_4 = GRID_htail_4;
% elevator shaft
[Pfx, Pfy, Prx, Pry] = fr_point(GRID_htail_1, GRID_htail_2, GRID_htail_3, GRID_htail_4, GRID_ele_1, GRID_ele_3, GRID_ele_1);
Prz = Pry*tan_Dih_htail + height_htail;
elevator_vec_x = ([Prx,Pry,Prz]-GRID_ele_1) / norm([Prx,Pry,Prz]-GRID_ele_1);
elevator_vec_y = (GRID_ele_1 - GRID_ele_3) / norm(GRID_ele_1 - GRID_ele_3);
elevator_vec_z = cross(elevator_vec_x, elevator_vec_y);

% rudder_4grids
GRID_rud_1 = [GRID_vtail_1(1) + rudder_x(1)*(GRID_vtail_2(1)-GRID_vtail_1(1)), 0, GRID_vtail_1(3)];
GRID_rud_2 = GRID_vtail_2;
GRID_rud_3 = [GRID_vtail_3(1) + rudder_x(1)*(GRID_vtail_4(1)-GRID_vtail_3(1)), 0, GRID_vtail_3(3)];
GRID_rud_4 = GRID_vtail_4;
% rudder shaft
rudder_vec_z = [0,-1,0];
rudder_vec_y = (GRID_rud_1 - GRID_rud_3) / norm(GRID_rud_1 - GRID_rud_3);
rudder_vec_x = cross(rudder_vec_y, rudder_vec_z);

% Raileron
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Rwing';
aero_block(AERO_BLOCK_n).sub_region = 'aileron';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_ail_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_ail_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_ail_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_ail_4;
aero_block(AERO_BLOCK_n).axis_x = aileron_vec_x;
aero_block(AERO_BLOCK_n).axis_y = aileron_vec_y;
aero_block(AERO_BLOCK_n).axis_z = aileron_vec_z;
COORD_count = COORD_count+1;
coord(COORD_count) = COORD(COORD_count, 0, GRID_ail_3,...
    GRID_ail_3+aero_block(AERO_BLOCK_n).axis_z,...
    GRID_ail_3+aero_block(AERO_BLOCK_n).axis_x);

% Laileron
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Lwing';
aero_block(AERO_BLOCK_n).sub_region = 'aileron';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = vers_y(GRID_ail_1);
aero_block(AERO_BLOCK_n).GRID_2 = vers_y(GRID_ail_2);
aero_block(AERO_BLOCK_n).GRID_3 = vers_y(GRID_ail_3);
aero_block(AERO_BLOCK_n).GRID_4 = vers_y(GRID_ail_4);
aero_block(AERO_BLOCK_n).axis_x = vers_y(aileron_vec_x);
aero_block(AERO_BLOCK_n).axis_y = aileron_vec_y.*[-1,1,-1];
aero_block(AERO_BLOCK_n).axis_z = aileron_vec_z.*[1,1,-1];
COORD_count = COORD_count+1;
coord(COORD_count) = COORD(COORD_count, 0, vers_y(GRID_ail_3),...
    vers_y(GRID_ail_3)+aero_block(AERO_BLOCK_n).axis_z,...
    vers_y(GRID_ail_3)+aero_block(AERO_BLOCK_n).axis_x);

% Relevator
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Rhtail';
aero_block(AERO_BLOCK_n).sub_region = 'elevator';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_ele_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_ele_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_ele_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_ele_4;
aero_block(AERO_BLOCK_n).axis_x = elevator_vec_x;
aero_block(AERO_BLOCK_n).axis_y = elevator_vec_y;
aero_block(AERO_BLOCK_n).axis_z = elevator_vec_z;
COORD_count = COORD_count+1;
coord(COORD_count) = COORD(COORD_count, 0, GRID_ele_3,...
    GRID_ele_3+aero_block(AERO_BLOCK_n).axis_z,...
    GRID_ele_3+aero_block(AERO_BLOCK_n).axis_x);

% Lelevator
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'Lhtail';
aero_block(AERO_BLOCK_n).sub_region = 'elevator';
aero_block(AERO_BLOCK_n).aero_vector = 'z';
aero_block(AERO_BLOCK_n).GRID_1 = vers_y(GRID_ele_1);
aero_block(AERO_BLOCK_n).GRID_2 = vers_y(GRID_ele_2);
aero_block(AERO_BLOCK_n).GRID_3 = vers_y(GRID_ele_3);
aero_block(AERO_BLOCK_n).GRID_4 = vers_y(GRID_ele_4);
aero_block(AERO_BLOCK_n).axis_x = vers_y(elevator_vec_x);
aero_block(AERO_BLOCK_n).axis_y = elevator_vec_y.*[-1,1,-1];
aero_block(AERO_BLOCK_n).axis_z = elevator_vec_z.*[1,-1,1];
COORD_count = COORD_count+1;
coord(COORD_count) = COORD(COORD_count, 0, vers_y(GRID_ele_3),...
    vers_y(GRID_ele_3)+aero_block(AERO_BLOCK_n).axis_z,...
    vers_y(GRID_ele_3)+aero_block(AERO_BLOCK_n).axis_x);

% rudder
AERO_BLOCK_n = AERO_BLOCK_n+1;
aero_block(AERO_BLOCK_n) = WING_AERO_BLOCK();
aero_block(AERO_BLOCK_n).region = 'vtail';
aero_block(AERO_BLOCK_n).sub_region = 'rudder';
aero_block(AERO_BLOCK_n).aero_vector = 'y';
aero_block(AERO_BLOCK_n).GRID_1 = GRID_rud_1;
aero_block(AERO_BLOCK_n).GRID_2 = GRID_rud_2;
aero_block(AERO_BLOCK_n).GRID_3 = GRID_rud_3;
aero_block(AERO_BLOCK_n).GRID_4 = GRID_rud_4;
aero_block(AERO_BLOCK_n).axis_x = rudder_vec_x;
aero_block(AERO_BLOCK_n).axis_y = rudder_vec_y;
aero_block(AERO_BLOCK_n).axis_z = rudder_vec_z;
COORD_count = COORD_count+1;
coord(COORD_count) = COORD(COORD_count, 0, GRID_rud_3, GRID_rud_3+rudder_vec_z, GRID_rud_3+rudder_vec_x);


