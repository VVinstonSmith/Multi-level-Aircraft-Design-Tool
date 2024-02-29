
function [wing_box1, wing_box2, cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_hh(wing_box1, wing_box2, cbar_area, cquad_area, cbar, cquad, grids)

%% 前梁上缘条区域序号(CBAR_area)
area1_num = wing_box1.CBAR_uf_num;
area2_num = wing_box2.CBAR_uf_num;
[cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
    connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
%% 前梁下缘条区域序号(CBAR_area)
area1_num = wing_box1.CBAR_df_num;
area2_num = wing_box2.CBAR_df_num;
[cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
    connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
%% 后梁上缘条区域序号(CBAR_area)
area1_num = wing_box1.CBAR_ur_num;
area2_num = wing_box2.CBAR_ur_num;
[cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
    connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
%% 后梁下缘条区域序号(CBAR_area)
area1_num = wing_box1.CBAR_dr_num;
area2_num = wing_box2.CBAR_dr_num;
[cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
    connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
%% 上长桁区域序号(CBAR_area)
for ii = 1:wing_box1.ns
    area1_num = wing_box1.CBAR_us_num(ii);
    area2_num = wing_box2.CBAR_us_num(ii);
    [cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
        connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
end
%% 下长桁区域序号(CBAR_area)
for ii = 1:wing_box1.ns
    area1_num = wing_box1.CBAR_ds_num(ii);
    area2_num = wing_box2.CBAR_ds_num(ii);
    [cbar_area,cbar, wing_box1.GRIDs_num, grids] =...
        connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids);
end

%% 前腹板区域序号(CQUAD_area)
area1_num = wing_box1.CQUAD_f_num;
area2_num = wing_box2.CQUAD_f_num;
[cquad_area,cquad, wing_box1.GRIDs_num, grids] =...
    connect_cquad_area_hh(area1_num, area2_num, cquad_area, cquad, wing_box1, grids);
%% 后腹板区域序号(CQUAD_area)
area1_num = wing_box1.CQUAD_r_num;
area2_num = wing_box2.CQUAD_r_num;
[cquad_area,cquad, wing_box1.GRIDs_num, grids] =...
    connect_cquad_area_hh(area1_num, area2_num, cquad_area, cquad, wing_box1, grids);
%% 上蒙皮区域序号(CQUAD_area)
for ii = 1:wing_box1.ns+1
    area1_num = wing_box1.CQUAD_u_num(ii);
    area2_num = wing_box2.CQUAD_u_num(ii);
    [cquad_area,cquad, wing_box1.GRIDs_num, grids] =...
        connect_cquad_area_hh(area1_num, area2_num, cquad_area, cquad, wing_box1, grids);
end
%% 下蒙皮区域序号(CQUAD_area)
for ii = 1:wing_box1.ns+1
    area1_num = wing_box1.CQUAD_d_num(ii);
    area2_num = wing_box2.CQUAD_d_num(ii);
    [cquad_area,cquad, wing_box1.GRIDs_num, grids] =...
        connect_cquad_area_hh(area1_num, area2_num, cquad_area, cquad, wing_box1, grids);
end
end

