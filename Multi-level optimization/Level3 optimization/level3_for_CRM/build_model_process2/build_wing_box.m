
%% wingbox 排序(从左到右，从下到上)
for ii = 1:length(wing_box)
    if strcmp(wing_box(ii).region,'wing')==1
        WING_BOX_w_count = WING_BOX_w_count+1;
        wing_box_w(WING_BOX_w_count) = wing_box(ii);
    elseif strcmp(wing_box(ii).region,'htail')==1
        WING_BOX_h_count = WING_BOX_h_count+1;
        wing_box_h(WING_BOX_h_count) = wing_box(ii);
    elseif strcmp(wing_box(ii).region,'vtail')==1
        WING_BOX_v_count = WING_BOX_v_count+1;
        wing_box_v(WING_BOX_v_count) = wing_box(ii);
    end
end
wing_box_w = sort_wing_box(wing_box_w,2);
wing_box_h = sort_wing_box(wing_box_h,2);
%wing_box_v = sort_wing_box(wing_box_v,3);
%% 找到对称的对象
% wing
for ii = 1:length(wing_box_w)
    CP = wing_box_w(ii).center_point();
    if CP(2)<-1e-7
        wing_box_w(ii).side = 'left';
        wing_box_w(ii).mirror_num = length(wing_box_w)-ii+1;
    elseif CP(2)>1e-7
        wing_box_w(ii).side = 'right';
        wing_box_w(ii).mirror_num = length(wing_box_w)-ii+1;
    else
        wing_box_w(ii).side = 'middle';
    end
end
% htail
for ii = 1:length(wing_box_h)
    CP = wing_box_h(ii).center_point();
    if CP(2)<-1e-7
        wing_box_h(ii).side = 'left';
        wing_box_h(ii).mirror_num = length(wing_box_h)-ii+1;
    elseif CP(2)>1e-7
        wing_box_h(ii).side = 'right';
        wing_box_h(ii).mirror_num = length(wing_box_h)-ii+1;
    else
        wing_box_h(ii).side = 'middle';
    end
end      
%% create wing_box pbar pshell
% rib
PBAR_count = PBAR_count + 1;
PBAR_rib_num = PBAR_count;
A = 0.5;
h = 0.25*A;
b = h;
Izz = 0.5*h^3;
Iyy = 0.5*h^3;
J = h^3;
pbar(PBAR_count) = PBAR(PBAR_rib_id, MAT_rib_num, A, Izz, Iyy, J, h,b, 'rib');
% PBAR_rib_num = PBAR_f_num;
% PBAR_rib_id = PBAR_f_id;

% wing
for ii = length(wing_box_w):-1:1
    if strcmp(wing_box_w(ii).side, 'left')==0
        % center points
        CP = wing_box_w(ii).center_point();
        CP_fspar = wing_box_w(ii).center_point_fspar();
        CP_rspar = wing_box_w(ii).center_point_rspar();
        % create fweb
        thick = get_web_size('wing','front', CP_fspar(2)/half_span_wing);
        [wing_box_w(ii), pshell,PSHELL_count,PSHELL_w_id] =...
            wing_box_w(ii).create_PSHELL_f(PSHELL_count,PSHELL_w_id,pshell, MAT_board_wing_num, thick);
        % create rweb
        thick = get_web_size('wing','rear', CP_rspar(2)/half_span_wing);
        [wing_box_w(ii), pshell,PSHELL_count,PSHELL_w_id] =...
            wing_box_w(ii).create_PSHELL_r(PSHELL_count,PSHELL_w_id,pshell, MAT_board_wing_num, thick);
        % create skin
        thick = get_skin_size('wing', CP(2)/half_span_wing);
        thick_skin = thick;
        [wing_box_w(ii), pshell,PSHELL_count,PSHELL_w_id] =...
            wing_box_w(ii).create_PSHELL_b(PSHELL_count,PSHELL_w_id,pshell, MAT_board_wing_num, thick);
        % create str
        if var_mode==5 || var_mode==3
            skin_width = wing_box_w(ii).skin_width;
            nstr = wing_box_w(ii).ns;
            A_str = A_over_bt * skin_width/(1+nstr) * thick_skin;
            b_over_h = 1;
            [h_str, b_str, Izz_str, Iyy_str, J_str] = get_I(A_str, b_over_h);
        elseif var_mode==6
            [h_str, b_str, Izz_str, Iyy_str, J_str] = get_stringer_size('wing', CP(2)/half_span_wing, wing_box_w(ii).ns);
        else
            disp('error');
        end
        [wing_box_w(ii), pbar,PBAR_count,PBAR_w_id] =...
            wing_box_w(ii).create_PBAR_s(PBAR_count,PBAR_w_id, pbar, MAT_str_wing_num, h_str, b_str, Izz_str, Iyy_str, J_str);
        % create fspar, rspar
        if var_mode==3
            h_fspar=h_str; b_fspar=b_str; Izz_fspar=Izz_str; Iyy_fspar=Iyy_str; J_fspar=J_str;
            h_rspar=h_str; b_rspar=b_str; Izz_rspar=Izz_str; Iyy_rspar=Iyy_str; J_rspar=J_str;
        else
            [h_fspar, b_fspar, Izz_fspar, Iyy_fspar, J_fspar] = ...
                get_spar_size('wing','front', CP_fspar(2)/half_span_wing);
            [h_rspar, b_rspar, Izz_rspar, Iyy_rspar, J_rspar] = ...
                get_spar_size('wing','rear', CP_rspar(2)/half_span_wing);
        end
        [wing_box_w(ii), pbar,PBAR_count,PBAR_w_id] =...
            wing_box_w(ii).create_PBAR_f(PBAR_count,PBAR_w_id, pbar, MAT_bar_wing_num, h_fspar, b_fspar, Izz_fspar, Iyy_fspar, J_fspar); 
        [wing_box_w(ii), pbar,PBAR_count,PBAR_w_id] =...
            wing_box_w(ii).create_PBAR_r(PBAR_count,PBAR_w_id, pbar, MAT_bar_wing_num, h_rspar, b_rspar, Izz_rspar, Iyy_rspar, J_rspar);
    end
    % create pbar pshell mirror
    if strcmp(wing_box_w(ii).side, 'right')==1
        ii_m = wing_box_w(ii).mirror_num;
        wing_box_w(ii_m).PBAR_f_num = wing_box_w(ii).PBAR_f_num;
        wing_box_w(ii_m).PBAR_r_num = wing_box_w(ii).PBAR_r_num;
        wing_box_w(ii_m).PBAR_s_num = wing_box_w(ii).PBAR_s_num;
        wing_box_w(ii_m).PSHELL_f_num = wing_box_w(ii).PSHELL_f_num;
        wing_box_w(ii_m).PSHELL_r_num = wing_box_w(ii).PSHELL_r_num;
        wing_box_w(ii_m).PSHELL_b_num = wing_box_w(ii).PSHELL_b_num;
    end
    % cbar_area
    [wing_box_w(ii), cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_w_id, grids,GRID_count,GRID_w_id] =...
        wing_box_w(ii).create_CBAR(cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_w_id, grids,GRID_count,GRID_w_id);
    % cquad_area
    [wing_box_w(ii), cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_w_id, grids,GRID_count,GRID_w_id] =...
        wing_box_w(ii).create_CQUAD(cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_w_id, grids,GRID_count,GRID_w_id);
end

% htail
for ii = length(wing_box_h):-1:1
    if strcmp(wing_box_h(ii).side, 'left')==0
        CP = wing_box_h(ii).center_point();
        CP_fspar = wing_box_h(ii).center_point_fspar();
        CP_rspar = wing_box_h(ii).center_point_rspar();
        % create pbar
        [h, b, Izz, Iyy, J] = get_spar_size('htail','front', CP_fspar(2)/half_span_htail);
        [wing_box_h(ii) ,pbar,PBAR_count,PBAR_h_id] =...
            wing_box_h(ii).create_PBAR_f(PBAR_count,PBAR_h_id, pbar, MAT_bar_htail_num, h, b, Izz, Iyy, J);
        [h, b, Izz, Iyy, J] = get_spar_size('htail','rear', CP_rspar(2)/half_span_htail);
        [wing_box_h(ii) ,pbar,PBAR_count,PBAR_h_id] =...
            wing_box_h(ii).create_PBAR_r(PBAR_count,PBAR_h_id, pbar, MAT_bar_htail_num, h, b, Izz, Iyy, J);
        [h, b, Izz, Iyy, J] = get_stringer_size('htail', CP(2)/half_span_htail, wing_box_h(ii).ns);
        [wing_box_h(ii) ,pbar,PBAR_count,PBAR_h_id] =...
            wing_box_h(ii).create_PBAR_s(PBAR_count,PBAR_h_id, pbar, MAT_str_htail_num, h, b, Izz, Iyy, J);
        % create shell
        thick = get_web_size('htail','front', CP_fspar(2)/half_span_htail);
        [wing_box_h(ii), pshell,PSHELL_count,PSHELL_h_id] =...
            wing_box_h(ii).create_PSHELL_f(PSHELL_count,PSHELL_h_id,pshell, MAT_board_htail_num, thick);
        thick = get_web_size('htail','rear', CP_rspar(2)/half_span_htail);
        [wing_box_h(ii), pshell,PSHELL_count,PSHELL_h_id] =...
            wing_box_h(ii).create_PSHELL_r(PSHELL_count,PSHELL_h_id,pshell, MAT_board_htail_num, thick);
        thick = get_skin_size('htail', CP(2)/half_span_htail);
        [wing_box_h(ii), pshell,PSHELL_count,PSHELL_h_id] =...
            wing_box_h(ii).create_PSHELL_b(PSHELL_count,PSHELL_h_id,pshell, MAT_board_htail_num, thick);
    end
    % create pbar pshell mirror
    if strcmp(wing_box_h(ii).side, 'right')==1
        ii_m = wing_box_h(ii).mirror_num;
        wing_box_h(ii_m).PBAR_f_num = wing_box_h(ii).PBAR_f_num;
        wing_box_h(ii_m).PBAR_r_num = wing_box_h(ii).PBAR_r_num;
        wing_box_h(ii_m).PBAR_s_num = wing_box_h(ii).PBAR_s_num;
        wing_box_h(ii_m).PSHELL_f_num = wing_box_h(ii).PSHELL_f_num;
        wing_box_h(ii_m).PSHELL_r_num = wing_box_h(ii).PSHELL_r_num;
        wing_box_h(ii_m).PSHELL_b_num = wing_box_h(ii).PSHELL_b_num;
    end
    % cbar_area
    [wing_box_h(ii), cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_h_id, grids,GRID_count,GRID_h_id] =...
        wing_box_h(ii).create_CBAR(cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_h_id, grids,GRID_count,GRID_h_id);
    % cquad_area
    [wing_box_h(ii), cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_h_id, grids,GRID_count,GRID_h_id] =...
        wing_box_h(ii).create_CQUAD(cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_h_id, grids,GRID_count,GRID_h_id);
end
%% vtail
% for ii = 1:length(wing_box_v)
%     CP = wing_box_v(ii).center_point();
%     %
%     [h, b, Izz, Iyy, J] = PBAR_size (CP, 'vtail');
%     % create_PBAR_f(obj, PBAR_count, PBAR_id, pbar, M_num, h, b, Izz, Iyy, J)
%     [wing_box_v(ii) ,pbar,PBAR_count,PBAR_v_id] =...
%         wing_box_v(ii).create_PBAR_f(PBAR_count,PBAR_v_id, pbar, MAT_bar_num, h(1), b(1), Izz(1), Iyy(1), J(1));
%     [wing_box_v(ii) ,pbar,PBAR_count,PBAR_v_id] =...
%         wing_box_v(ii).create_PBAR_r(PBAR_count,PBAR_v_id, pbar, MAT_bar_num, h(2), b(2), Izz(2), Iyy(2), J(2));
%     [wing_box_v(ii) ,pbar,PBAR_count,PBAR_v_id] =...
%         wing_box_v(ii).create_PBAR_s(PBAR_count,PBAR_v_id, pbar, MAT_bar_num, h(3), b(3), Izz(3), Iyy(3), J(3));
%     %
%     thick = PSHELL_size (CP, 'vtail');
%     % create_PSHELL_f(obj, PSHELL_count, PSHELL_id, pshell, M_num, thick)
%     [wing_box_v(ii), pshell,PSHELL_count,PSHELL_v_id] =...
%         wing_box_v(ii).create_PSHELL_f(PSHELL_count,PSHELL_v_id,pshell, MAT_board_num, thick(1));
%     [wing_box_v(ii), pshell,PSHELL_count,PSHELL_v_id] =...
%         wing_box_v(ii).create_PSHELL_r(PSHELL_count,PSHELL_v_id,pshell, MAT_board_num, thick(2));
%     [wing_box_v(ii), pshell,PSHELL_count,PSHELL_v_id] =...
%         wing_box_v(ii).create_PSHELL_b(PSHELL_count,PSHELL_v_id,pshell, MAT_board_num, thick(3));
%     %
%     % cbar_area
%     [wing_box_v(ii), cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_v_id, grids,GRID_count,GRID_v_id] =...
%         wing_box_v(ii).create_CBAR(cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_v_id, grids,GRID_count,GRID_v_id);
%     % cquad_area
%     [wing_box_v(ii), cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_v_id, grids,GRID_count,GRID_v_id] =...
%         wing_box_v(ii).create_CQUAD(cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_v_id, grids,GRID_count,GRID_v_id);
% end

%% connect wing_box
% wing
for ii = 1:length(wing_box_w)-1
    if wing_box_w(ii).POINT3_f(2)<wing_box_w(ii).POINT1_f(2)
        if wing_box_w(ii+1).POINT3_f(2)<wing_box_w(ii+1).POINT1_f(2)
            % 3     1,3     1
            %
            % 4     2,4     2
            [wing_box_w(ii+1), wing_box_w(ii), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_th(wing_box_w(ii+1), wing_box_w(ii), cbar_area, cquad_area, cbar, cquad, grids);
        else
            % 3     1,1     3
            %
            % 4     2,2     4
            [wing_box_w(ii), wing_box_w(ii+1), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_hh(wing_box_w(ii), wing_box_w(ii+1), cbar_area, cquad_area, cbar, cquad, grids);
        end
    else
        if wing_box_w(ii+1).POINT3_f(2)>wing_box_w(ii+1).POINT1_f(2)
            % 1     3,1     3
            %
            % 2     4,2     4
            [wing_box_w(ii), wing_box_w(ii+1), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_th(wing_box_w(ii), wing_box_w(ii+1), cbar_area, cquad_area, cbar, cquad, grids);
        end
    end
end
%
% htail
for ii = 1:length(wing_box_h)-1
    if wing_box_h(ii).POINT3_f(2)<wing_box_h(ii).POINT1_f(2)
        if wing_box_h(ii+1).POINT3_f(2)<wing_box_h(ii+1).POINT1_f(2)
            [wing_box_h(ii+1), wing_box_h(ii), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_th(wing_box_h(ii+1), wing_box_h(ii), cbar_area, cquad_area, cbar, cquad, grids);
        else
            [wing_box_h(ii), wing_box_h(ii+1), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_hh(wing_box_h(ii), wing_box_h(ii+1), cbar_area, cquad_area, cbar, cquad, grids);
        end
    else
        if wing_box_h(ii+1).POINT3_f(2)>wing_box_h(ii+1).POINT1_f(2)
            [wing_box_h(ii), wing_box_h(ii+1), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_th(wing_box_h(ii), wing_box_h(ii+1), cbar_area, cquad_area, cbar, cquad, grids);
        end
    end
end
%
%% vtail
% for ii = 1:length(wing_box_v)-1
% 	[wing_box_v(ii), wing_box_v(ii+1), cbar_area, cquad_area, cbar, cquad, grids] = connect_wing_box_th(wing_box_v(ii), wing_box_v(ii+1), cbar_area, cquad_area, cbar, cquad, grids);
% end
    
%% create ribs
% wing
[rib,RIB_count, cbar,CBAR_count,CBAR_rib_id, grids,GRID_count,GRID_w_id] =...
    wing_box_w(1).create_rib(rib,RIB_count, cbar_area, cbar,CBAR_count,CBAR_rib_id, 'left', grids,GRID_count,GRID_w_id, PBAR_rib_num);
for ii = 1:length(wing_box_w)
    [rib,RIB_count, cbar,CBAR_count,CBAR_rib_id, grids,GRID_count,GRID_w_id] =...
        wing_box_w(ii).create_rib(rib,RIB_count, cbar_area, cbar,CBAR_count,CBAR_rib_id, 'right', grids,GRID_count,GRID_w_id, PBAR_rib_num);
    wing_box_w(ii).rib_left_num = RIB_count-1;
    wing_box_w(ii).rib_right_num = RIB_count;
end
% htail
[rib,RIB_count, cbar,CBAR_count,CBAR_rib_id, grids,GRID_count,GRID_h_id] =...
    wing_box_h(1).create_rib(rib,RIB_count, cbar_area, cbar,CBAR_count,CBAR_rib_id, 'left', grids,GRID_count,GRID_h_id, PBAR_rib_num);
for ii = 1:length(wing_box_h)
    [rib,RIB_count, cbar,CBAR_count,CBAR_rib_id, grids,GRID_count,GRID_h_id] =...
        wing_box_h(ii).create_rib(rib,RIB_count, cbar_area, cbar,CBAR_count,CBAR_rib_id, 'right', grids,GRID_count,GRID_h_id, PBAR_rib_num);
    wing_box_h(ii).rib_left_num = RIB_count-1;
    wing_box_h(ii).rib_right_num = RIB_count;
end

vol_wing = zeros(size(wing_box_w));
for ii = 1:length(wing_box_w)
    vol_wing(ii) = wing_box_w(ii).volume();
end
total_vol_wing = sum(vol_wing);

%% create fuel mass
if with_fuel
for ii = 1:length(wing_box_w)
    mass_block = fuel_mass * vol_wing(ii)/total_vol_wing;
    [wing_box_w(ii), mass,MASS_count,MASS_w_id] =...
            wing_box_w(ii).create_mass_vol(mass_block, grids,cbar_area, mass,MASS_count,MASS_w_id, 'wing');
end
end
%% create NSTR_mass
if with_nstr_mass
% wing
MASS_nstr_flag = zeros(size(MASS_wing_nstr_mass));
for h = 1:length(wing_box_w)
    P1 = wing_box_w(h).POINT1_f(1:2);
    P2 = wing_box_w(h).POINT1_r(1:2);
    P3 = wing_box_w(h).POINT3_f(1:2);
    P4 = wing_box_w(h).POINT3_r(1:2);
    if P1(2)<P3(2)
        rib1_num  = wing_box_w(h).rib_left_num;
        rib2_num  = wing_box_w(h).rib_right_num;
    else
        rib2_num  = wing_box_w(h).rib_left_num;
        rib1_num  = wing_box_w(h).rib_right_num;
    end
    for ii = 1:length(MASS_wing_nstr_mass)
        if MASS_nstr_flag(ii) == 1
            continue;
        end
        Mass_mass = MASS_wing_nstr_mass(ii);
        P_3d = MASS_wing_nstr_loc(ii,:);
        P = P_3d(1:2);
        s1 = line_side(P1,P2,P);
        s2 = line_side(P3,P4,P);
        if s1*s2<0
            MASS_nstr_flag(ii) = 1;
            % project 4 points to a pair of ribs
            P1m = drop_point(P1,P2, P);
            P2m = two_line_cross(P,P1m, P3,P4);
            P3m = drop_point(P3,P4, P);
            P4m = two_line_cross(P,P3m, P1,P2);
            d1 = norm(P-P1m);
            d2 = norm(P-P2m);
            d3 = norm(P-P3m);
            d4 = norm(P-P4m);
            w1 = 0.5 * d2 / (d1+d2);
            w2 = 0.5 * d1 / (d1+d2);
            w3 = 0.5 * d4 / (d3+d4);
            w4 = 0.5 * d3 / (d3+d4);
            P1m = [(P1m*w1 + P4m*w4) / (w1 + w4), P_3d(3)];
            P2m = [(P2m*w2 + P3m*w3) / (w2 + w3), P_3d(3)];
            w1 = w1 + w4;
            w2 = w2 + w3;
            % create point mass
            grid1_close_num = rib(rib1_num).seek_nearest_grid(P1m, grids);
            grid2_close_num = rib(rib2_num).seek_nearest_grid(P2m, grids);
            [grids,GRID_count,GRID_w_id, mass,MASS_count,MASS_w_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_w_id,mass,MASS_count,MASS_w_id,rbe2,RBE2_count,...
                'wing', 'secondary', Mass_mass*w1,P1m,grid1_close_num);
            [grids,GRID_count,GRID_w_id, mass,MASS_count,MASS_w_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_w_id,mass,MASS_count,MASS_w_id,rbe2,RBE2_count,...
                'wing', 'secondary', Mass_mass*w2,P2m,grid2_close_num);
        elseif s1*s2==0
            MASS_nstr_flag(ii) = 1;
            if s1==0
                grid_close_num = rib(rib1_num).seek_nearest_grid(P_3d, grids);
            else
                grid_close_num = rib(rib2_num).seek_nearest_grid(P_3d, grids);
            end
            [grids,GRID_count,GRID_w_id, mass,MASS_count,MASS_w_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_w_id,mass,MASS_count,MASS_w_id,rbe2,RBE2_count,...
                'wing', 'secondary', Mass_mass,P_3d,grid_close_num);
        elseif h==1
            if s1<0 && s2<0
                MASS_nstr_flag(ii) = 1;
                if P1(2)<P3(2)
                    Pm = [drop_point(P1,P2, P),P_3d(3)];
                    grid_close_num = rib(rib1_num).seek_nearest_grid(Pm, grids);
                else
                    Pm = [drop_point(P3,P4, P),P_3d(3)];
                    grid_close_num = rib(rib2_num).seek_nearest_grid(Pm, grids);
                end
                [grids,GRID_count,GRID_w_id, mass,MASS_count,MASS_w_id, rbe2,RBE2_count] =...
                        create_CONmass(grids,GRID_count,GRID_w_id,mass,MASS_count,MASS_w_id,rbe2,RBE2_count,...
                        'wing', 'secondary', Mass_mass,Pm,grid_close_num);
            end
        elseif h==length(wing_box_w)
            if s1>0 && s2>0
                MASS_nstr_flag(ii) = 1;
                if P3(2)<P1(2)
                    Pm = [drop_point(P1,P2, P),P_3d(3)];
                    grid_close_num = rib(rib1_num).seek_nearest_grid(Pm, grids);
                else
                    Pm = [drop_point(P3,P4, P),P_3d(3)];
                    grid_close_num = rib(rib2_num).seek_nearest_grid(Pm, grids);
                end
                [grids,GRID_count,GRID_w_id, mass,MASS_count,MASS_w_id, rbe2,RBE2_count] =...
                        create_CONmass(grids,GRID_count,GRID_w_id,mass,MASS_count,MASS_w_id,rbe2,RBE2_count,...
                        'wing', 'secondary', Mass_mass,Pm,grid_close_num);
            end
        end
    end
end

% htail
MASS_nstr_flag = zeros(size(MASS_htail_nstr_mass));
for h = 1:length(wing_box_h)
    P1 = wing_box_h(h).POINT1_f(1:2);
    P2 = wing_box_h(h).POINT1_r(1:2);
    P3 = wing_box_h(h).POINT3_f(1:2);
    P4 = wing_box_h(h).POINT3_r(1:2);
    if P1(2)<P3(2)
        rib1_num  = wing_box_h(h).rib_left_num;
        rib2_num  = wing_box_h(h).rib_right_num;
    else
        rib2_num  = wing_box_h(h).rib_left_num;
        rib1_num  = wing_box_h(h).rib_right_num;
    end
    for ii = 1:length(MASS_htail_nstr_mass)
        if MASS_nstr_flag(ii) == 1
            continue;
        end
        Mass_mass = MASS_htail_nstr_mass(ii);
        P_3d = MASS_htail_nstr_loc(ii,:);
        P = P_3d(1:2);
        s1 = line_side(P1,P2,P);
        s2 = line_side(P3,P4,P);
        if s1*s2<0
            MASS_nstr_flag(ii) = 1;
            % project 4 points to a pair of ribs
            P1m = drop_point(P1,P2, P);
            P2m = two_line_cross(P,P1m, P3,P4);
            P3m = drop_point(P3,P4, P);
            P4m = two_line_cross(P,P3m, P1,P2);
            d1 = norm(P-P1m);
            d2 = norm(P-P2m);
            d3 = norm(P-P3m);
            d4 = norm(P-P4m);
            w1 = 0.5 * d2 / (d1+d2);
            w2 = 0.5 * d1 / (d1+d2);
            w3 = 0.5 * d4 / (d3+d4);
            w4 = 0.5 * d3 / (d3+d4);
            P1m = [(P1m*w1 + P4m*w4) / (w1 + w4), P_3d(3)];
            P2m = [(P2m*w2 + P3m*w3) / (w2 + w3), P_3d(3)];
            w1 = w1 + w4;
            w2 = w2 + w3;
            % create point mass
            grid1_close_num = rib(rib1_num).seek_nearest_grid(P1m, grids);
            grid2_close_num = rib(rib2_num).seek_nearest_grid(P2m, grids);
            [grids,GRID_count,GRID_h_id, mass,MASS_count,MASS_h_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_h_id,mass,MASS_count,MASS_h_id,rbe2,RBE2_count,...
                'htail', 'secondary', Mass_mass*w1,P1m,grid1_close_num);
            [grids,GRID_count,GRID_h_id, mass,MASS_count,MASS_h_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_h_id,mass,MASS_count,MASS_h_id,rbe2,RBE2_count,...
                'htail', 'secondary', Mass_mass*w2,P2m,grid2_close_num);
        elseif s1*s2==0
            MASS_nstr_flag(ii) = 1;
            if s1==0
                grid_close_num = rib(rib1_num).seek_nearest_grid(P_3d, grids);
            else
                grid_close_num = rib(rib2_num).seek_nearest_grid(P_3d, grids);
            end
            [grids,GRID_count,GRID_h_id, mass,MASS_count,MASS_h_id, rbe2,RBE2_count] =...
                create_CONmass(grids,GRID_count,GRID_h_id,mass,MASS_count,MASS_h_id,rbe2,RBE2_count,...
                'htail', 'secondary', Mass_mass,P_3d,grid_close_num);
        elseif h==1
            if s1<0 && s2<0
                MASS_nstr_flag(ii) = 1;
                if P1(2)<P3(2)
                    Pm = [drop_point(P1,P2, P),P_3d(3)];
                    grid_close_num = rib(rib1_num).seek_nearest_grid(Pm, grids);
                else
                    Pm = [drop_point(P3,P4, P),P_3d(3)];
                    grid_close_num = rib(rib2_num).seek_nearest_grid(Pm, grids);
                end
                [grids,GRID_count,GRID_h_id, mass,MASS_count,MASS_h_id, rbe2,RBE2_count] =...
                        create_CONmass(grids,GRID_count,GRID_h_id,mass,MASS_count,MASS_h_id,rbe2,RBE2_count,...
                        'htail', 'secondary', Mass_mass,Pm,grid_close_num);
            end
        elseif h==length(wing_box_h)
            if s1>0 && s2>0
                MASS_nstr_flag(ii) = 1;
                if P3(2)<P1(2)
                    Pm = [drop_point(P1,P2, P),P_3d(3)];
                    grid_close_num = rib(rib1_num).seek_nearest_grid(Pm, grids);
                else
                    Pm = [drop_point(P3,P4, P),P_3d(3)];
                    grid_close_num = rib(rib2_num).seek_nearest_grid(Pm, grids);
                end
                [grids,GRID_count,GRID_h_id, mass,MASS_count,MASS_h_id, rbe2,RBE2_count] =...
                        create_CONmass(grids,GRID_count,GRID_h_id,mass,MASS_count,MASS_h_id,rbe2,RBE2_count,...
                        'htail', 'secondary', Mass_mass,Pm,grid_close_num);
            end
        end
    end
end
end

%% 翼身连接
% wing
Xw_front = wing_part(wing_center_part_right_num).P_fspar_root(1);
Xw_rear = wing_part(wing_center_part_right_num).P_rspar_root(1);
% htail
Xh_front = wing_part(htail_center_part_right_num).P_fspar_root(1);
Xh_rear = wing_part(htail_center_part_right_num).P_rspar_root(1);

% find fuse_grid_num
GRID_wf_connect_fuse_num = fuselage.find_grid(Xw_front);
GRID_wr_connect_fuse_num = fuselage.find_grid(Xw_rear);
GRID_hf_connect_fuse_num = fuselage.find_grid(Xh_front);
GRID_hr_connect_fuse_num = fuselage.find_grid(Xh_rear);

GRID_wf_connect_w_num = [];
GRID_wr_connect_w_num = [];
GRID_hf_connect_h_num = [];
GRID_hr_connect_h_num = [];
GRID_vf_connect_v_num = [];
GRID_vr_connect_v_num = [];
% find wing_grid_num
for ii = 1:length(wing_box_w)
    rib_num = wing_box_w(ii).rib_left_num;
    grid_lead_num = rib(rib_num).GRID_lead_num;
    if abs(grids(grid_lead_num).loc(2) - 0.5*body_width_wing)<1e-5 || abs(grids(grid_lead_num).loc(2) + 0.5*body_width_wing)<1e-5
        if grids(grid_lead_num).loc(2)>0
            GRID_num_right_root_lead = rib(rib_num).GRID_lead_num;
            GRID_num_right_root_tail = rib(rib_num).GRID_tail_num;
        else
            GRID_num_left_root_lead = rib(rib_num).GRID_lead_num;
            GRID_num_left_root_tail = rib(rib_num).GRID_tail_num;
        end
        % front_bar
        GRID_wf_connect_w_num = [GRID_wf_connect_w_num,...
            rib(rib_num).GRIDs_up_num(1), rib(rib_num).GRIDs_down_num(1)];
        % rear_bar
        GRID_wr_connect_w_num = [GRID_wr_connect_w_num,...
            rib(rib_num).GRIDs_up_num(end), rib(rib_num).GRIDs_down_num(end)];
    end
end
% find htail_grid_num
for ii = 1:length(wing_box_h)
    rib_num = wing_box_h(ii).rib_left_num;
    grid_lead_num = rib(rib_num).GRID_lead_num;
    if abs(grids(grid_lead_num).loc(2) - 0.5*body_width_htail)<1e-5 || abs(grids(grid_lead_num).loc(2) + 0.5*body_width_htail)<1e-5
        % front_bar
        GRID_hf_connect_h_num = [GRID_hf_connect_h_num,...
            rib(rib_num).GRIDs_up_num(1), rib(rib_num).GRIDs_down_num(1)];
        % rear_bar
        GRID_hr_connect_h_num = [GRID_hr_connect_h_num,...
            rib(rib_num).GRIDs_up_num(end), rib(rib_num).GRIDs_down_num(end)];
    end
end

% create RBE2
% wing_front
freedom_constr = 123;
for ii = 1:length(GRID_wf_connect_w_num)
    RBE2_count = RBE2_count+1;
    rbe2(RBE2_count) = RBE2(RBE2_count,...
        grids(GRID_wf_connect_fuse_num).id, GRID_wf_connect_fuse_num,...
        grids(GRID_wf_connect_w_num(ii)).id, GRID_wf_connect_w_num(ii), freedom_constr);
end
% wing_rear
for ii = 1:length(GRID_wr_connect_w_num)
    RBE2_count = RBE2_count+1;
    rbe2(RBE2_count) = RBE2(RBE2_count,...
        grids(GRID_wr_connect_fuse_num).id, GRID_wr_connect_fuse_num,...
        grids(GRID_wr_connect_w_num(ii)).id, GRID_wr_connect_w_num(ii), freedom_constr);
end
% htail_front
for ii = 1:length(GRID_hf_connect_h_num)
    RBE2_count = RBE2_count+1;
    rbe2(RBE2_count) = RBE2(RBE2_count,...
        grids(GRID_hf_connect_fuse_num).id, GRID_hf_connect_fuse_num,...
        grids(GRID_hf_connect_h_num(ii)).id, GRID_hf_connect_h_num(ii), freedom_constr);
end
% htail_rear
for ii = 1:length(GRID_hr_connect_h_num)
    RBE2_count = RBE2_count+1;
    rbe2(RBE2_count) = RBE2(RBE2_count,...
        grids(GRID_hr_connect_fuse_num).id, GRID_hr_connect_fuse_num,...
        grids(GRID_hr_connect_h_num(ii)).id, GRID_hr_connect_h_num(ii), freedom_constr);
end

%% 参数化WING_BOX: DESVAR
VAR_wing_flag = 1;
VAR_htail_flag = 0;
VAR_vtail_flag = 0;
%
wing_spar_XLB = 5.0e-5;
wing_spar_XUB = 1e-1;
% wing_spar_XUB = 1;
wing_str_XLB = 2.5e-5;
wing_str_XUB = 1e-1;
% wing_str_XUB = 1;
% wing_spar_XLB = 1.0e-7;
% wing_spar_XUB = 1.0e-6;
% wing_str_XLB = 1.0e-7;
% wing_str_XUB = 1.0e-6;
wing_skin_XLB = 0.001;
wing_skin_XUB = 0.1;
% wing_skin_XUB = 1;
wing_web_XLB = 0.001;
wing_web_XUB = 0.1;
% wing_web_XUB = 1;
%
htail_bar_XLB = 2.5e-5;
htail_bar_XUB = 1e-2;
htail_shell_XLB = 0.001;
htail_shell_XUB = 0.1;
%
if use_span_function
    if VAR_wing_flag==1
        % a*exp(b*(1-y/(0.5*span))) + c
        DVID_fspar = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('fspar', DESVAR_count, DESVAR_id, desvar,...
                            wing_spar_XLB*2, 'wing', 'fspar');
        DVID_rspar = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('rspar', DESVAR_count, DESVAR_id, desvar,...
                            wing_spar_XLB*2, 'wing', 'rspar');
        DVID_str = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('str', DESVAR_count, DESVAR_id, desvar,...
                            wing_str_XLB*2, 'wing', 'str');
        DVID_fweb = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('fweb', DESVAR_count, DESVAR_id, desvar,...
                            wing_web_XLB*2, 'wing', 'fweb');
        DVID_rweb = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('rweb', DESVAR_count, DESVAR_id, desvar,...
                            wing_web_XLB*2, 'wing', 'rweb');
        DVID_skin = [DESVAR_id+1: DESVAR_id+3];
        [DESVAR_count, DESVAR_id, desvar] = ...
            create_exp_var('skin', DESVAR_count, DESVAR_id, desvar,...
                            wing_skin_XLB*2, 'wing', 'skin');
        DVID_wing = [DVID_fspar, DVID_rspar, DVID_str, DVID_fweb, DVID_rweb, DVID_skin];
    end
    %% if use span function, pbar and pshell will be writen through desvar
    if use_opt_vars % use var_values (a,b,c) for a*exp(b*y)+c
        for ii=1:length(desvar)
            desvar(ii).XINT = var_values(ii);
        end
    elseif use_udf_vars % use self_defined (a,b,c) for a*exp(b*y)+c
        for ii=1:length(desvar)
            desvar(ii).XINT = var_values_udf(ii);
        end
    % else use_auto_vars
    end
    %% wing DVPREL
    block_id=1;
    if VAR_wing_flag==1
        for ii = 1:length(wing_box_w)
            if strcmp(wing_box_w(ii).side,'right')==1
                continue;
            end
            [wing_box_w(ii), DEQATN_count, DEQATN_id, deqatn,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                pbar, pshell] = ...
                wing_box_w(ii).create_DVPREL2(DEQATN_count, DEQATN_id, deqatn,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                pbar, pshell, desvar,...
                wing_spar_XLB, wing_spar_XUB, wing_str_XLB, wing_str_XUB,...
                wing_skin_XLB, wing_skin_XUB, wing_web_XLB, wing_web_XUB,...
                half_span_wing, block_id, DVID_wing);
           block_id = block_id + 1;
        end
    end
else % not use span function
    %% DESVAR
    if VAR_wing_flag==1
        % wing DESVAR
        for ii = 1:length(wing_box_w)
            if strcmp(wing_box_w(ii).side,'right') == 1
                ii_m = wing_box_w(ii).mirror_num;
                wing_box_w(ii).VAR_fweb_num = wing_box_w(ii_m).VAR_fweb_num;
                wing_box_w(ii).VAR_rweb_num = wing_box_w(ii_m).VAR_rweb_num;
                wing_box_w(ii).VAR_board_num = wing_box_w(ii_m).VAR_board_num;
                if var_mode==5 || var_mode==6
                    wing_box_w(ii).VAR_fbar_num = wing_box_w(ii_m).VAR_fbar_num;
                    wing_box_w(ii).VAR_rbar_num = wing_box_w(ii_m).VAR_rbar_num;
                end
                if var_mode==6
                    wing_box_w(ii).VAR_string_num = wing_box_w(ii_m).VAR_string_num;
                end
                continue;
            end
            [wing_box_w(ii), DESVAR_count,DESVAR_id, desvar, pbar,pshell] = ...
                wing_box_w(ii).create_DESVAR(DESVAR_count,DESVAR_id,...
                desvar, pbar, pshell,...
                wing_spar_XLB, wing_spar_XUB, wing_str_XLB, wing_str_XUB,...
                wing_skin_XLB, wing_skin_XUB, wing_web_XLB, wing_web_XUB,...
                ii, var_mode);
        end
    end
    % htail DESVAR
    if VAR_htail_flag==1
        for ii = 1:length(wing_box_h)
            if strcmp(wing_box_h(ii).side,'right') == 1
                ii_m = wing_box_h(ii).mirror_num;
                wing_box_h(ii).VAR_fbar_num = wing_box_h(ii_m).VAR_fbar_num;
                wing_box_h(ii).VAR_rbar_num = wing_box_h(ii_m).VAR_rbar_num;
                wing_box_h(ii).VAR_string_num = wing_box_h(ii_m).VAR_string_num;
                wing_box_h(ii).VAR_fweb_num = wing_box_h(ii_m).VAR_fweb_num;
                wing_box_h(ii).VAR_rweb_num = wing_box_h(ii_m).VAR_rweb_num;
                wing_box_h(ii).VAR_board_num = wing_box_h(ii_m).VAR_board_num;
                continue;
            end
            [wing_box_h(ii), DESVAR_count,DESVAR_id, desvar, pbar,pshell] = ...
                wing_box_h(ii).create_DESVAR(DESVAR_count,DESVAR_id,...
                desvar, pbar, pshell,...
                htail_bar_XLB, htail_bar_XUB, htail_bar_XLB, htail_bar_XUB,...
                htail_shell_XLB, htail_shell_XUB, htail_shell_XLB, htail_shell_XUB,...
                ii);
        end
    end
    % vtail DESVAR
    if VAR_vtail_flag==1
        for ii = 1:length(wing_box_v)
            [wing_box_v(ii), DESVAR_count,DESVAR_id, desvar] = ...
                wing_box_v(ii).create_DESVAR(DESVAR_count,DESVAR_id,...
                desvar, pbar, pshell,...
                vtail_bar_XLB, vtail_bar_XUB, vtail_bar_XLB, vtail_bar_XUB,...
                vtail_shell_XLB, vtail_shell_XUB, vtail_shell_XLB, vtail_shell_XUB,...
                ii);
        end
    end
    %% write pbar,pshell through 
    if use_opt_vars % use var_values A,thick
        for ii=1:length(desvar)
            if strcmp(desvar(ii).region, 'wing')
                w_num = desvar(ii).region_number;
                desvar(ii).XINT = var_values(ii);
                if strcmp(desvar(ii).component,'fspar') || strcmp(desvar(ii).component,'rspar')
                    if strcmp(desvar(ii).component,'fspar')
                        pbar_num = wing_box_w(w_num).PBAR_f_num;
                    elseif strcmp(desvar(ii).component,'rspar')
                        pbar_num = wing_box_w(w_num).PBAR_r_num;
                    end
                    A = var_values(ii);
                    pbar(pbar_num).A = A;
                    pbar(pbar_num).Izz = A^2 / 48;
                    pbar(pbar_num).Iyy = A^2 / 3;
                    pbar(pbar_num).J = A^2 / 3;
                    pbar(pbar_num).h = 0.5*sqrt(A); pbar(pbar_num).b = 2*sqrt(A);
                elseif strcmp(desvar(ii).component,'str')
                    pbar_num = wing_box_w(w_num).PBAR_s_num(1);
                    A = var_values(ii);
                    pbar(pbar_num).A = A;
                    pbar(pbar_num).Izz = A^2 / 12;
                    pbar(pbar_num).Iyy = A^2 / 12;
                    pbar(pbar_num).J = A^2 / 12;
                    pbar(pbar_num).h = sqrt(A); pbar(pbar_num).b = sqrt(A);
                elseif strcmp(desvar(ii).component,'fweb') || strcmp(desvar(ii).component,'rweb') || strcmp(desvar(ii).component,'skin')
                    if strcmp(desvar(ii).component,'fweb')
                        shell_num = wing_box_w(w_num).PSHELL_f_num;
                        pshell(shell_num).thick = var_values(ii);
                    elseif strcmp(desvar(ii).component,'rweb')
                        shell_num = wing_box_w(w_num).PSHELL_r_num;
                        pshell(shell_num).thick = var_values(ii);
                    elseif strcmp(desvar(ii).component,'skin')
                        shell_num = wing_box_w(w_num).PSHELL_b_num(1);
                        pshell(shell_num).thick = var_values(ii);
                        if var_mode==5 || var_mode==3
                            skin_width = wing_box_w(w_num).skin_width;
                            nstr = wing_box_w(w_num).ns;
                            A_str = A_over_bt * skin_width/(1+nstr) * pshell(shell_num).thick;
                            b_over_h = 1;
                            [h_str, b_str, Izz_str, Iyy_str, J_str] = get_I(A_str, b_over_h);
                            % str from skin
                            pbar_num = wing_box_w(w_num).PBAR_s_num(1);
                            pbar(pbar_num).A = A_str;
                            pbar(pbar_num).Izz = Izz_str;
                            pbar(pbar_num).Iyy = Iyy_str;
                            pbar(pbar_num).J = J_str;
                            pbar(pbar_num).h = h_str; pbar(pbar_num).b = b_str;
                        end
                        if var_mode==3
                            % fspar from str
                            pbar_num = wing_box_w(w_num).PBAR_f_num;
                            pbar(pbar_num).A = A_str;
                            pbar(pbar_num).Izz = Izz_str;
                            pbar(pbar_num).Iyy = Iyy_str;
                            pbar(pbar_num).J = J_str;
                            pbar(pbar_num).h = h_str; pbar(pbar_num).b = b_str;
                            % rspar from str
                            pbar_num = wing_box_w(w_num).PBAR_r_num;
                            pbar(pbar_num).A = A_str;
                            pbar(pbar_num).Izz = Izz_str;
                            pbar(pbar_num).Iyy = Iyy_str;
                            pbar(pbar_num).J = J_str;
                            pbar(pbar_num).h = h_str; pbar(pbar_num).b = b_str;
                        end   
                    end 
                else
                    disp('error');
                end
            end
        end           
    else % use inputed A,thick
        disp('input A,thick from structural size');
    end
    %% DEQATN
    % fspar, rspar: b_over_h = 4
    % b=4*h, 4*h*h=A, h=sqrt(A/4), I1=(h^3*b)/12=A^2/48,
    % I2=(b^3*h)/12=(1/3)*A^2, J=I2=(1/3)*A^2
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_I1_bar_id = DEQATN_id;
    EQATN = 'I1bar(A)=A**2/48.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_I2_bar_id = DEQATN_id;
    EQATN = 'I2bar(A)=A**2/3.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_J_bar_id = DEQATN_id;
    EQATN = 'Jbar(A)=A**2/3.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %
    % stringer: b_over_h = 1
    % b=h, h*h=A, h=sqrt(A), I1=(h^3*b)/12=A^2/12,
    % I2=(b^3*h)/12=A^2/12, J=I2=A^2/12
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_I1_str_id = DEQATN_id;
    EQATN = 'I1str(A)=A**2/12.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_I2_str_id = DEQATN_id;
    EQATN = 'I2str(A)=A**2/12.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_J_str_id = DEQATN_id;
    EQATN = 'Jstr(A)=A**2/12.';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %% wing DVPREL
    if VAR_wing_flag==1
        block_id=1;
        for ii = 1:length(wing_box_w)
            if strcmp(wing_box_w(ii).side,'right')==1
                continue;
            end
            if var_mode==6
                [wing_box_w(ii), DVPREL1_count,DVPREL1_id,dvprel1,...
                    DVPREL2_count,DVPREL2_id,dvprel2, pbar,pshell] = ...
                    wing_box_w(ii).create_DVPREL(DVPREL1_count,DVPREL1_id,dvprel1,...
                    DVPREL2_count,DVPREL2_id, dvprel2,...
                    desvar, pbar, pshell,...
                    wing_spar_XLB, wing_spar_XUB, wing_str_XLB, wing_str_XUB,...
                    wing_skin_XLB, wing_skin_XUB, wing_web_XLB, wing_web_XUB,...
                    DEQATN_I1_bar_id, DEQATN_I2_bar_id, DEQATN_J_bar_id,...
                    DEQATN_I1_str_id, DEQATN_I2_str_id, DEQATN_J_str_id);
            elseif var_mode==5 || var_mode==3
                [wing_box_w(ii), DEQATN_count, DEQATN_id, deqatn,...
                    DVPREL1_count, DVPREL1_id, dvprel1,...
                    DVPREL2_count, DVPREL2_id, dvprel2,...
                    pbar, pshell] = ...
                    wing_box_w(ii).create_DVPREL3(DEQATN_count, DEQATN_id, deqatn,...
                    DVPREL1_count, DVPREL1_id, dvprel1,...
                    DVPREL2_count, DVPREL2_id, dvprel2,...
                    pbar, pshell, desvar,...
                    wing_spar_XLB, wing_spar_XUB, wing_str_XLB, wing_str_XUB,...
                    wing_skin_XLB, wing_skin_XUB, wing_web_XLB, wing_web_XUB,...
                    DEQATN_I1_bar_id, DEQATN_I2_bar_id, DEQATN_J_bar_id,...
                    A_over_bt, block_id, var_mode);% str decided by skin
                block_id = block_id + 1;
            else
                disp('error');
            end    
        end
    end
    % htail DVPREL
    if VAR_htail_flag==1
        for ii = 1:length(wing_box_h)
            if strcmp(wing_box_h(ii).side,'right')==1
                continue;
            end
            [wing_box_h(ii), DVPREL1_count,DVPREL1_id,dvprel1,...
                DVPREL2_count,DVPREL2_id,dvprel2, pbar,pshell] = ...
                wing_box_h(ii).create_DVPREL(DVPREL1_count,DVPREL1_id,dvprel1,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                desvar, pbar, pshell,...
                htail_spar_XLB, htail_spar_XUB, htail_str_XLB, htail_str_XUB,...
                htail_skin_XLB, htail_skin_XUB, htail_web_XLB, htail_web_XUB,...
                DEQATN_I1_id, DEQATN_I2_id, DEQATN_J_id, 6);
        end
    end
    % vtail DVPREL
    if VAR_vtail_flag==1
        for ii = 1:length(wing_box_v)
            [wing_box_v(ii), DVPREL1_count,DVPREL1_id,dvprel1,...
                DVPREL2_count,DVPREL2_id,dvprel2, pbar,pshell] = ...
                wing_box_v(ii).create_DVPREL(DVPREL1_count,DVPREL1_id,dvprel1,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                desvar, pbar, pshell,...
                vtail_spar_XLB, vtail_spar_XUB, vtail_str_XLB, vtail_str_XUB,...
                vtail_skin_XLB, vtail_skin_XUB, vtail_web_XLB, vtail_web_XUB,...
                DEQATN_I1_id, DEQATN_I2_id, DEQATN_J_id, 6);
        end
    end
end

%% 定义响应 DRESP2(扭转) 
% 找出翼尖前后缘点
GRID_num_right_tip_lead = 0;
GRID_num_right_tip_tail = 0;
GRID_y_right = 0;
GRID_num_left_tip_lead = 0;
GRID_num_left_tip_tail = 0;
GRID_y_left = 0;
for ii = 1:length(rib)
    if strcmp(rib(ii).region,'wing')==1
        grid_y = grids(rib(ii).GRID_lead_num).loc(2);
        if  grid_y>GRID_y_right
            GRID_num_right_tip_lead = rib(ii).GRID_lead_num;
            GRID_num_right_tip_tail = rib(ii).GRID_tail_num;
            GRID_y_right = grid_y;
        elseif grid_y<GRID_y_left
            GRID_num_left_tip_lead = rib(ii).GRID_lead_num;
            GRID_num_left_tip_tail = rib(ii).GRID_tail_num;
            GRID_y_left = grid_y;
        end
    end
end
ATTA = 5;% y_rotate
% RTIPROT
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RTIPROT_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RTIPROT', 'DISP', [], ATTA, grids(GRID_num_right_tip_lead).id, 'DISP');
% LTIPROT
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LTIPROT_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LTIPROT', 'DISP', [], ATTA, grids(GRID_num_left_tip_lead).id, 'DISP');
% RROOROT
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RROOROT_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RROOROT', 'DISP', [], ATTA, grids(GRID_num_right_root_lead).id, 'DISP');
% LROOROT
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LROOROT_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LROOROT', 'DISP', [], ATTA, grids(GRID_num_left_root_lead).id, 'DISP');
% twist formula
DEQATN_count = DEQATN_count+1;
DEQATN_id = DEQATN_id+1;
DEQATN_twist_id = DEQATN_id;
EQATN = 'F(TIP,ROOT) = TIP - ROOT';
deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
% Rwing twist
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
DRESP2_RWTWIST_id = DRESP_id;
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'RWTWIST', DEQATN_twist_id, [], [],...
    [DRESP1_RTIPROT_id, DRESP1_RROOROT_id], [], [], 'DISP');
% Lwing twist
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
DRESP2_LWTWIST_id = DRESP_id;
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'LWTWIST', DEQATN_twist_id, [], [],...
    [DRESP1_LTIPROT_id, DRESP1_LROOROT_id], [], [], 'DISP');
%% 定义响应 DRESP2(弯曲挠度)
ATTA = 3;% z_disp
% Rwing_tip_lead_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RTIPLZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RTIPLZ', 'DISP', [], ATTA, grids(GRID_num_right_tip_lead).id, 'DISP');
% Rwing_tip_tail_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RTIPTZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RTIPTZ', 'DISP', [], ATTA, grids(GRID_num_right_tip_tail).id, 'DISP');
% Rwing_root_lead_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RROOLZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RROOLZ', 'DISP', [], ATTA, grids(GRID_num_right_root_lead).id, 'DISP');
% Rwing_root_tail_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_RROOTZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'RROOTZ', 'DISP', [], ATTA, grids(GRID_num_right_root_tail).id, 'DISP');
%
% Lwing_tip_lead_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LTIPLZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LTIPLZ', 'DISP', [], ATTA, grids(GRID_num_left_tip_lead).id, 'DISP');
% Lwing_tip_tail_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LTIPTZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LTIPTZ', 'DISP', [], ATTA, grids(GRID_num_left_tip_tail).id, 'DISP');
% Lwing_root_lead_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LROOLZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LROOLZ', 'DISP', [], ATTA, grids(GRID_num_left_root_lead).id, 'DISP');
% Lwing_root_tail_z
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_LROOTZ_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'LROOTZ', 'DISP', [], ATTA, grids(GRID_num_left_root_tail).id, 'DISP');
% z_relative_disp formula
DEQATN_count = DEQATN_count+1;
DEQATN_id = DEQATN_id+1;
DEQATN_zdisp_id = DEQATN_id;
EQATN = 'F(A,B,C,D)=0.5*(A+B)-0.5*(C+D)';
deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
% Rwing zdisp
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
DRESP2_RWZDISP_id = DRESP_id;
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'RWZDISP', DEQATN_zdisp_id, [], [],...
    [DRESP1_RTIPLZ_id, DRESP1_RTIPTZ_id, DRESP1_RROOLZ_id, DRESP1_RROOTZ_id], [], [], 'DISP');
% Lwing zdisp
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
DRESP2_LWZDISP_id = DRESP_id;
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'LWZDISP', DEQATN_zdisp_id, [], [],...
    [DRESP1_LTIPLZ_id, DRESP1_LTIPTZ_id, DRESP1_LROOLZ_id, DRESP1_LROOTZ_id], [], [], 'DISP');


