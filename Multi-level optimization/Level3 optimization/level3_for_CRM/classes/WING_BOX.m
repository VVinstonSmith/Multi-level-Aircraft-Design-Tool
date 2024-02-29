classdef WING_BOX
%         3
%        /|
%    1 / / 4
%     |/
%     2
    properties
        region;
        side;
        mirror_num;
        V;% 气动面法向量
        %% 两侧翼肋
        rib_left_num;
        rib_right_num;
        %% for skin_width
        point_froot;
        point_rroot;
        point_ftip;
        point_rtip;
        mid_point_root;
        mid_point_tip;
        skin_width;
        %% shape grids
        % 前梁
        POINT1_f;
        POINT2_f;
        POINT3_f;
        POINT4_f;
        POINT_f;
        % 后梁
        POINT1_r;
        POINT2_r;
        POINT3_r;
        POINT4_r;
        POINT_r;
        % 长桁
        POINT1_s;
        POINT2_s;
        POINT3_s;
        POINT4_s;
        % 前后缘
        POINT1_lead;
        POINT1_tail;
        POINT3_lead;
        POINT3_tail;
        %% 属性
        PBAR_f_num;% 前梁属性序号
        PBAR_r_num;% 后梁属性序号
        PBAR_s_num;% 长桁属性序号(数量是长桁数量)
        PSHELL_f_num;% 前腹板属性序号
        PSHELL_r_num;% 后腹板属性序号
        PSHELL_b_num;% 蒙皮属性序号(数量是长桁数量+1)
       %% 分块数量
        ns;% 长桁数量
        nb;% 展向块数
        nc;% 弦向块数(两杆之间)
        %% CABR_area
        CBAR_uf_num;% 前梁上缘条区域序号(CBAR_area)
        CBAR_df_num;% 前梁下缘条区域序号(CBAR_area)
        CBAR_ur_num;% 后梁上缘条区域序号(CBAR_area)
        CBAR_dr_num;% 后梁下缘条区域序号(CBAR_area)
        CBAR_us_num;% 上翼面长桁区域序号(ns个(CBAR_area))
        CBAR_ds_num;% 下翼面长桁区域序号(ns个(CBAR_area))
        %% CQUAD_area
        CQUAD_f_num;% 前腹板区域序号(CQUAD_area)
        CQUAD_r_num;% 后腹板区域序号(CQUAD_area)
        CQUAD_u_num;% 上蒙皮区域单元序号((ns+1)个CQUAD_area)
        CQUAD_d_num;% 下蒙皮区域单元序号((ns+1)个CQUAD_area)
        %% 所有的GRID序号
        GRIDs_num;
        %% 属性变量序号
        VAR_fbar_num;% 前梁截面积
        VAR_rbar_num;% 后梁截面积
        VAR_string_num;% 单个长桁截面积
        VAR_fweb_num;% 前腹板厚度
        VAR_rweb_num;% 后腹板厚度
        VAR_board_num;% 蒙皮厚度
    end
    
    methods 
        function obj = WING_BOX(region,nb,nc)
            obj.region = region;
            obj.nb = nb;
            obj.nc = nc;
        end
        %% input grid locations
        function obj = get_POINT_lead_tail(obj,point1_lead, point1_tail, point3_lead, point3_tail)
            obj.POINT1_lead = point1_lead;
            obj.POINT1_tail = point1_tail;
            obj.POINT3_lead = point3_lead;
            obj.POINT3_tail = point3_tail;
        end
        function obj = get_POINT_f(obj,point1_f, point2_f, point3_f, point4_f)
            obj.POINT1_f = point1_f;
            obj.POINT2_f = point2_f;
            obj.POINT3_f = point3_f;
            obj.POINT4_f = point4_f;
            obj.POINT_f = 0.25*(point1_f + point2_f + point3_f + point4_f);
        end
        function obj = get_POINT_r(obj, point1_r, point2_r, point3_r, point4_r)
            obj.POINT1_r = point1_r;
            obj.POINT2_r = point2_r;
            obj.POINT3_r = point3_r;
            obj.POINT4_r = point4_r;
            obj.POINT_r = 0.25*(point1_r + point2_r + point3_r + point4_r);
        end
        function obj = get_POINT_s(obj, POINT1_s, POINT2_s, POINT3_s, POINT4_s)
            obj.POINT1_s = POINT1_s;
            obj.POINT2_s = POINT2_s;
            obj.POINT3_s = POINT3_s;
            obj.POINT4_s = POINT4_s;
            obj.ns = length(POINT1_s(:,1));
        end
        function obj = get_skin_width(obj)
            obj.point_froot = 0.5*(obj.POINT1_f + obj.POINT2_f);
            obj.point_rroot = 0.5*(obj.POINT1_r + obj.POINT2_r);
            obj.point_ftip = 0.5*(obj.POINT3_f + obj.POINT4_f);
            obj.point_rtip = 0.5*(obj.POINT3_r + obj.POINT4_r);
            obj.mid_point_root = 0.5*(obj.point_froot + obj.point_rroot);
            obj.mid_point_tip = 0.5*(obj.point_ftip + obj.point_rtip);
            mid_point = 0.5*(obj.mid_point_root + obj.mid_point_tip);
            Pf_cross = vertical_cross_point(obj.mid_point_root(1:2), obj.mid_point_tip(1:2),...
                                            mid_point(1:2), obj.point_froot(1:2), obj.point_ftip(1:2));
            Pr_cross = vertical_cross_point(obj.mid_point_root(1:2), obj.mid_point_tip(1:2),...
                                            mid_point(1:2), obj.point_rroot(1:2), obj.point_rtip(1:2));
            obj.skin_width = norm(Pf_cross-Pr_cross);                      
        end
       %% create PBAR
        % PBAR_f
        function [obj, pbar,PBAR_count,PBAR_id] = create_PBAR_f(obj, PBAR_count, PBAR_id, pbar, M_num, h, b, Izz, Iyy, J)
            PBAR_count = PBAR_count+1;
            PBAR_id = PBAR_id+1;
            pbar(PBAR_count) = PBAR(PBAR_id, M_num, b*h, Izz, Iyy, J, h,b, obj.region);
            obj.PBAR_f_num = PBAR_count;
            pbar(PBAR_count).component = 'fspar';
        end
        % PBAR_r
        function [obj,pbar, PBAR_count,PBAR_id] = create_PBAR_r(obj, PBAR_count, PBAR_id, pbar, M_num, h, b, Izz, Iyy, J)
            PBAR_count = PBAR_count+1;
            PBAR_id = PBAR_id+1;
            pbar(PBAR_count) = PBAR(PBAR_id, M_num, b*h, Izz, Iyy, J, h,b, obj.region);
            obj.PBAR_r_num = PBAR_count;
            pbar(PBAR_count).component = 'rspar';
        end
        % PBAR_s
        function [obj,pbar, PBAR_count,PBAR_id] = create_PBAR_s(obj, PBAR_count, PBAR_id, pbar, M_num, h, b, Izz, Iyy, J)
            if length(Izz) == 1
                PBAR_count = PBAR_count+1;
                PBAR_id = PBAR_id+1;
                pbar(PBAR_count) = PBAR(PBAR_id, M_num, b*h, Izz, Iyy, J, h,b, obj.region);
                obj.PBAR_s_num(1:obj.ns) = PBAR_count;
                pbar(PBAR_count).component = 'str';
            else
                for ii = 1:length(obj.POINT1_s)
                    PBAR_count = PBAR_count+1;
                    PBAR_id = PBAR_id+1;    
                    pbar(PBAR_count) = PBAR(PBAR_id, M_num, b(ii)*h(ii), Izz(ii), Iyy(ii), J(ii), h(ii),b(ii), obj.region);
                    obj.PBAR_s_num(ii) = PBAR_count;
                    pbar(PBAR_count).component = 'str';
                end
            end
        end
       %% create PSHELL
        % PSHELL_f
        function [obj,pshell, PSHELL_count,PSHELL_id] = create_PSHELL_f(obj, PSHELL_count, PSHELL_id, pshell, M_num, thick)
            PSHELL_count = PSHELL_count+1;
            PSHELL_id = PSHELL_id+1;
            pshell(PSHELL_count) = PSHELL(PSHELL_id, M_num, thick, obj.region);
            obj.PSHELL_f_num = PSHELL_count;
        end
        % PSHELL_r
        function [obj,pshell, PSHELL_count,PSHELL_id] = create_PSHELL_r(obj, PSHELL_count, PSHELL_id, pshell, M_num, thick)
            PSHELL_count = PSHELL_count+1;
            PSHELL_id = PSHELL_id+1;
            pshell(PSHELL_count) = PSHELL(PSHELL_id, M_num, thick, obj.region);
            obj.PSHELL_r_num = PSHELL_count;
        end
        % PSHELL_b
        function [obj,pshell, PSHELL_count,PSHELL_id] = create_PSHELL_b(obj, PSHELL_count, PSHELL_id, pshell, M_num, thick)
            if length(thick) == 1
                PSHELL_count = PSHELL_count+1;
                PSHELL_id = PSHELL_id+1;
                pshell(PSHELL_count) = PSHELL(PSHELL_id, M_num, thick, obj.region);
                obj.PSHELL_b_num(1:obj.ns+1) = PSHELL_count;
            else         
                for ii = 1:obj.ns+1
                    PSHELL_count = PSHELL_count+1;
                    PSHELL_id = PSHELL_id+1;
                    pshell(PSHELL_count) = PSHELL(PSHELL_id, M_num, thick(ii), obj.region);
                    obj.PSHELL_b_num(ii) = PSHELL_count;
                end
            end
        end
        %% create CBAR_area (include CBARs and GRIDs)
        function [obj,cbar_area, CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] = create_CBAR(obj, cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id)
            % cbar_area, CBAR_area_count
            % cbar, CBAR_count, CBAR_id
            % grids, GRID_count, GRID_id
            % up_front
            CBAR_area_count = CBAR_area_count + 1;
            cbar_area(CBAR_area_count) = CBAR_area(obj.POINT1_f, obj.POINT3_f, obj.PBAR_f_num);
            cbar_area(CBAR_area_count).V = obj.V;
            GRID_num_old = GRID_count+1;
            [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
            obj.CBAR_uf_num = CBAR_area_count;
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
            % down_front
            CBAR_area_count = CBAR_area_count + 1;
            cbar_area(CBAR_area_count) = CBAR_area(obj.POINT2_f, obj.POINT4_f, obj.PBAR_f_num);
            cbar_area(CBAR_area_count).V = obj.V;
            GRID_num_old = GRID_count+1;
            [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
            obj.CBAR_df_num = CBAR_area_count;
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
            % up_rear
            CBAR_area_count = CBAR_area_count + 1;
            cbar_area(CBAR_area_count) = CBAR_area(obj.POINT1_r, obj.POINT3_r, obj.PBAR_r_num);
            cbar_area(CBAR_area_count).V = obj.V;
            GRID_num_old = GRID_count+1;
            [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
            obj.CBAR_ur_num = CBAR_area_count;
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
            % down_rear
            CBAR_area_count = CBAR_area_count + 1;
            cbar_area(CBAR_area_count) = CBAR_area(obj.POINT2_r, obj.POINT4_r, obj.PBAR_r_num);
            cbar_area(CBAR_area_count).V = obj.V;
            GRID_num_old = GRID_count+1;
            [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
            obj.CBAR_dr_num = CBAR_area_count;
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
            % up_and_down_s
            GRID_num_old = GRID_count+1;
            for ii = 1:length(obj.POINT1_s(:,1))
                % up
                CBAR_area_count = CBAR_area_count + 1;
                cbar_area(CBAR_area_count) = CBAR_area(obj.POINT1_s(ii,:), obj.POINT3_s(ii,:), obj.PBAR_s_num(ii)); 
                cbar_area(CBAR_area_count).V = obj.V;
                [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                    cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
                obj.CBAR_us_num(ii) = CBAR_area_count;
                % down
                CBAR_area_count = CBAR_area_count + 1;
                cbar_area(CBAR_area_count) = CBAR_area(obj.POINT2_s(ii,:), obj.POINT4_s(ii,:), obj.PBAR_s_num(ii)); 
                cbar_area(CBAR_area_count).V = obj.V;
                [cbar_area(CBAR_area_count), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                    cbar_area(CBAR_area_count).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, obj.nb, obj.region);
                obj.CBAR_ds_num(ii) = CBAR_area_count;
            end
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
        end
        
        %% create CQUAD_area (include CQUADs and GRIDs)
        function [obj,cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = create_CQUAD(obj, cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id)
            % cquad_area, CQUAD_area_count
            % cbar_area
            % cquad, CQUAD_count, CQUAD_id
            % grids, GRID_count, GRID_id
            GRID_num_old = GRID_count+1;
            % front web
            CQUAD_area_count = CQUAD_area_count + 1;
            cquad_area(CQUAD_area_count) = CQUAD_area(obj.POINT1_f, obj.POINT2_f, obj.POINT3_f, obj.POINT4_f, obj.PSHELL_f_num);
            [cquad_area(CQUAD_area_count), cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = ...
                cquad_area(CQUAD_area_count).create_CQUAD(cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, 1, cbar_area(obj.CBAR_uf_num), cbar_area(obj.CBAR_df_num), obj.region);
            obj.CQUAD_f_num = CQUAD_area_count;
            % rear web
            CQUAD_area_count = CQUAD_area_count + 1;
            cquad_area(CQUAD_area_count) = CQUAD_area(obj.POINT1_r, obj.POINT2_r, obj.POINT3_r, obj.POINT4_r, obj.PSHELL_r_num);
            [cquad_area(CQUAD_area_count), cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = ...
                cquad_area(CQUAD_area_count).create_CQUAD(cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, 1, cbar_area(obj.CBAR_ur_num), cbar_area(obj.CBAR_dr_num), obj.region);
            obj.CQUAD_r_num = CQUAD_area_count;
            % board
            for ii=1:obj.ns+1
                % up board
                if ii==1
                    P1 = obj.POINT1_f;
                    P3 = obj.POINT3_f;
                    cbar_area1 = cbar_area(obj.CBAR_uf_num);
                else
                    P1 = obj.POINT1_s(ii-1,:);
                    P3 = obj.POINT3_s(ii-1,:);
                    cbar_area1 = cbar_area(obj.CBAR_us_num(ii-1));
                end 
                if ii==obj.ns+1
                    P2 = obj.POINT1_r;
                    P4 = obj.POINT3_r;
                    cbar_area2 = cbar_area(obj.CBAR_ur_num);
                else  
                    P2 = obj.POINT1_s(ii,:);
                    P4 = obj.POINT3_s(ii,:);
                    cbar_area2 = cbar_area(obj.CBAR_us_num(ii));
                end
                CQUAD_area_count = CQUAD_area_count + 1;
                cquad_area(CQUAD_area_count) = CQUAD_area(P1, P2, P3, P4, obj.PSHELL_b_num(ii));
                [cquad_area(CQUAD_area_count), cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = ...
                    cquad_area(CQUAD_area_count).create_CQUAD(cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, obj.nc, cbar_area1, cbar_area2, obj.region);
                obj.CQUAD_u_num(ii) = CQUAD_area_count;
                % down board
                if ii==1
                    P1 = obj.POINT2_f;
                    P3 = obj.POINT4_f;
                    cbar_area1 = cbar_area(obj.CBAR_df_num);
                else
                    P1 = obj.POINT2_s(ii-1,:);
                    P3 = obj.POINT4_s(ii-1,:);
                    cbar_area1 = cbar_area(obj.CBAR_ds_num(ii-1));
                end 
                if ii==obj.ns+1
                    P2 = obj.POINT2_r;
                    P4 = obj.POINT4_r;
                    cbar_area2 = cbar_area(obj.CBAR_dr_num);
                else  
                    P2 = obj.POINT2_s(ii,:);
                    P4 = obj.POINT4_s(ii,:);
                    cbar_area2 = cbar_area(obj.CBAR_ds_num(ii));
                end
                CQUAD_area_count = CQUAD_area_count + 1;
                cquad_area(CQUAD_area_count) = CQUAD_area(P1, P2, P3, P4, obj.PSHELL_b_num(ii));
                [cquad_area(CQUAD_area_count), cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = ...
                    cquad_area(CQUAD_area_count).create_CQUAD(cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, obj.nc, cbar_area1, cbar_area2, obj.region);
                obj.CQUAD_d_num(ii) = CQUAD_area_count;
            end
            obj.GRIDs_num = [obj.GRIDs_num, GRID_num_old:GRID_count];
        end
        %% center_xyz
        function center_point = center_point(obj)
            center_point = obj.POINT1_f + obj.POINT2_f + obj.POINT3_f + obj.POINT4_f +...
                obj.POINT1_r + obj.POINT2_r + obj.POINT3_r + obj.POINT4_r;
            center_point = center_point/8;
        end
        function center_point = center_point_fspar(obj)
            center_point = obj.POINT1_f + obj.POINT2_f + obj.POINT3_f + obj.POINT4_f;
            center_point = center_point/4;
        end
        function center_point = center_point_rspar(obj)
            center_point = obj.POINT1_r + obj.POINT2_r + obj.POINT3_r + obj.POINT4_r;
            center_point = center_point/4;
        end
        
        %% create rib
        function [rib,RIB_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                create_rib(obj, rib,RIB_count, cbar_area, cbar,CBAR_count,CBAR_id, side, grids,GRID_count,GRID_id, PBAR_num)
            RIB_count = RIB_count+1;
            rib(RIB_count) = RIB();
            rib(RIB_count).PBAR_num = PBAR_num;
            rib(RIB_count).region = obj.region;
            rib(RIB_count).V = obj.V;
            GRIDs_up_num = zeros(1,2+obj.ns);
            GRIDs_down_num = zeros(1,2+obj.ns);
            if strcmp(obj.region,'vtail')==1
                p1 = obj.POINT1_f(3);
                p3 = obj.POINT3_f(3);
            else
                p1 = obj.POINT1_f(2);
                p3 = obj.POINT3_f(2);
            end
            if (strcmp(side,'left')==1 && p1<p3) || (strcmp(side,'right')==1 && p1>p3)
                GRID_count = GRID_count+1;
                GRID_id = GRID_id+1;
                grids(GRID_count) = GRID(GRID_id, obj.region, obj.POINT1_lead);
                GRID_lead_num = GRID_count;
                GRID_count = GRID_count+1;
                GRID_id = GRID_id+1;
                grids(GRID_count) = GRID(GRID_id, obj.region, obj.POINT1_tail);
                GRID_tail_num = GRID_count; 
                GRIDs_up_num(1) = cbar_area(obj.CBAR_uf_num).GRIDi_num(1);
                GRIDs_down_num(1) = cbar_area(obj.CBAR_df_num).GRIDi_num(1);
                for jj = 1:obj.ns
                    GRIDs_up_num(jj+1) = cbar_area(obj.CBAR_us_num(jj)).GRIDi_num(1);
                    GRIDs_down_num(jj+1) = cbar_area(obj.CBAR_ds_num(jj)).GRIDi_num(1);
                end
                GRIDs_up_num(end) = cbar_area(obj.CBAR_ur_num).GRIDi_num(1);
                GRIDs_down_num(end) = cbar_area(obj.CBAR_dr_num).GRIDi_num(1);
            else
                GRID_count = GRID_count+1;
                GRID_id = GRID_id+1;
                grids(GRID_count) = GRID(GRID_id, obj.region, obj.POINT3_lead);
                GRID_lead_num = GRID_count;
                GRID_count = GRID_count+1;
                GRID_id = GRID_id+1;
                grids(GRID_count) = GRID(GRID_id, obj.region, obj.POINT3_tail);
                GRID_tail_num = GRID_count; 
                GRIDs_up_num(1) = cbar_area(obj.CBAR_uf_num).GRIDi_num(end);
                GRIDs_down_num(1) = cbar_area(obj.CBAR_df_num).GRIDi_num(end);
                for jj = 1:obj.ns
                    GRIDs_up_num(jj+1) = cbar_area(obj.CBAR_us_num(jj)).GRIDi_num(end);
                    GRIDs_down_num(jj+1) = cbar_area(obj.CBAR_ds_num(jj)).GRIDi_num(end);
                end
                GRIDs_up_num(end) = cbar_area(obj.CBAR_ur_num).GRIDi_num(end);
                GRIDs_down_num(end) = cbar_area(obj.CBAR_dr_num).GRIDi_num(end);
            end
            rib(RIB_count).GRID_lead_num = GRID_lead_num;
            rib(RIB_count).GRID_tail_num = GRID_tail_num;
            rib(RIB_count).GRIDs_up_num = GRIDs_up_num;
            rib(RIB_count).GRIDs_down_num = GRIDs_down_num;
            [rib(RIB_count),cbar,CBAR_count,CBAR_id] = rib(RIB_count).create_CBAR(grids, cbar,CBAR_count,CBAR_id);
        end
        %% get volume
        function V = volume(obj)
            h = 0;            
            for ii=1:size(obj.POINT1_s,1)
                h = h + norm(obj.POINT1_s(ii,:)-obj.POINT2_s(ii,:))...
                      + norm(obj.POINT3_s(ii,:)-obj.POINT4_s(ii,:));
            end
            h =  h+ norm(obj.POINT1_f-obj.POINT2_f) + norm(obj.POINT1_r-obj.POINT2_r) +...
                norm(obj.POINT3_f-obj.POINT4_f) + norm(obj.POINT3_r-obj.POINT4_r);
            h = h / (4+2*size(obj.POINT1_s,1));
            S = S_triangle(obj.POINT1_f, obj.POINT3_f, obj.POINT1_r) +...
                S_triangle(obj.POINT1_r, obj.POINT3_r, obj.POINT3_f);
            V = S*h;
        end  
        %% create_mass_vol
        function [obj,mass,MASS_count,MASS_id] = create_mass_vol(obj, total_mass, grids,cbar_area, mass,MASS_count,MASS_id, region)
            n_points = (obj.nb+1)*(obj.ns*2+4);
            single_mass = total_mass/n_points;
            %
            desc = 'fuel';
            for ii = 1:obj.nb+1
                % uf
                MASS_count = MASS_count+1;
                MASS_id = MASS_id+1;
                GRID_num = cbar_area(obj.CBAR_uf_num).GRIDi_num(ii); % n+1
                mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                % df
                MASS_count = MASS_count+1;
                MASS_id = MASS_id+1;
                GRID_num = cbar_area(obj.CBAR_df_num).GRIDi_num(ii); % n+1
                mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                % ur
                MASS_count = MASS_count+1;
                MASS_id = MASS_id+1;
                GRID_num = cbar_area(obj.CBAR_ur_num).GRIDi_num(ii); % n+1
                mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                % dr
                MASS_count = MASS_count+1;
                MASS_id = MASS_id+1;
                GRID_num = cbar_area(obj.CBAR_dr_num).GRIDi_num(ii); % n+1
                mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                for jj = 1:obj.ns
                    % us
                    MASS_count = MASS_count+1;
                    MASS_id = MASS_id+1;
                    GRID_num = cbar_area(obj.CBAR_us_num(jj)).GRIDi_num(ii); % n+1
                    mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                    % ds
                    MASS_count = MASS_count+1;
                    MASS_id = MASS_id+1;
                    GRID_num = cbar_area(obj.CBAR_ds_num(jj)).GRIDi_num(ii); % n+1
                    mass(MASS_count) = MASS(MASS_id, region, desc, grids(GRID_num).loc, GRID_num, single_mass, zeros(1,6));
                end
            end
        end
        %% plot
        function plot_boards(obj, cquad_area, grids, color, linewidth)
            cquad_area(obj.CQUAD_f_num).plot_quad(grids, color, linewidth);
            cquad_area(obj.CQUAD_r_num).plot_quad(grids, color, linewidth);
            for ii = 1:obj.ns+1
                cquad_area(obj.CQUAD_u_num(ii)).plot_quad(grids, color, linewidth);
                cquad_area(obj.CQUAD_d_num(ii)).plot_quad(grids, color, linewidth);
            end
        end
        %
        function plot_rods(obj, cbar_area, grids, color_bar, color_str, linewidth)
            cbar_area(obj.CBAR_uf_num).plot_cbar(grids, color_bar, linewidth);
            cbar_area(obj.CBAR_df_num).plot_cbar(grids, color_bar, linewidth);
            cbar_area(obj.CBAR_ur_num).plot_cbar(grids, color_bar, linewidth);
            cbar_area(obj.CBAR_dr_num).plot_cbar(grids, color_bar, linewidth);
            for ii = 1:length(obj.POINT1_s(:,1))
                cbar_area(obj.CBAR_us_num(ii)).plot_cbar(grids, color_str, linewidth);
                cbar_area(obj.CBAR_ds_num(ii)).plot_cbar(grids, color_str, linewidth);
            end
        end
        %
        function plot_frame(obj)
            plot3_square(obj.POINT1_f, obj.POINT2_f, obj.POINT3_f, obj.POINT4_f, 1,1, 'ro-', 4); hold on;
            plot3_square(obj.POINT1_r, obj.POINT2_r, obj.POINT3_r, obj.POINT4_r, 1,1, 'ro-', 4); hold on;
            for ii = 1:length(obj.POINT1_s(:,1))
                plot3_line(obj.POINT1_s(ii,:), obj.POINT3_s(ii,:), '-ob', 2); hold on;
                plot3_line(obj.POINT2_s(ii,:), obj.POINT4_s(ii,:), '-ob', 2); hold on;
            end
            for ii = 1:length(obj.POINT1_s(:,1))
                if ii == 1
                    plot3_line(obj.POINT1_s(ii,:), obj.POINT1_f, '-or', 1); hold on;
                    plot3_line(obj.POINT2_s(ii,:), obj.POINT2_f, '-or', 1); hold on;
                    plot3_line(obj.POINT3_s(ii,:), obj.POINT3_f, '-or', 1); hold on;
                    plot3_line(obj.POINT4_s(ii,:), obj.POINT4_f, '-or', 1); hold on;
                end
                if ii == length(obj.POINT1_s(:,1))
                    plot3_line(obj.POINT1_s(ii,:), obj.POINT1_r, '-or', 1); hold on;
                    plot3_line(obj.POINT2_s(ii,:), obj.POINT2_r, '-or', 1); hold on;
                    plot3_line(obj.POINT3_s(ii,:), obj.POINT3_r, '-or', 1); hold on;
                    plot3_line(obj.POINT4_s(ii,:), obj.POINT4_r, '-or', 1); hold on;
                else
                    plot3_line(obj.POINT1_s(ii,:), obj.POINT1_s(ii+1,:), '-or', 1); hold on;
                    plot3_line(obj.POINT2_s(ii,:), obj.POINT2_s(ii+1,:), '-or', 1); hold on;
                    plot3_line(obj.POINT3_s(ii,:), obj.POINT3_s(ii+1,:), '-or', 1); hold on;
                    plot3_line(obj.POINT4_s(ii,:), obj.POINT4_s(ii+1,:), '-or', 1); hold on;
                end
            end
        end
        % var_mode=6: fweb,rweb,skin,str,fspar,rspar
        % var_mode=5: fweb,rweb,skin,fspar,rspar
        % var_mode=3: fweb,rweb,skin
        %% create DESVAR
        function [obj,DESVAR_count,DESVAR_id,desvar,...
                pbar,pshell] = ...
                create_DESVAR(obj, DESVAR_count,DESVAR_id,...
                desvar, pbar, pshell,...
                spar_XLB, spar_XUB, str_XLB, str_XUB, skin_XLB, skin_XUB, web_XLB, web_XUB,...
                region_number, var_mode)
            if var_mode==5 || var_mode==6
                % 前梁截面积
                DESVAR_count = DESVAR_count+1;
                DESVAR_id = DESVAR_id+1;
                desvar(DESVAR_count) =...
                    DESVAR(DESVAR_id, ['PBAR',num2str(DESVAR_id)],...
                    pbar(obj.PBAR_f_num).A, spar_XLB, spar_XUB, [],...
                    obj.region, region_number, 'fspar', obj.POINT_f(2));
                obj.VAR_fbar_num = DESVAR_count;
                pbar(obj.PBAR_f_num).desvar_id = DESVAR_id;
                % 后梁截面积
                DESVAR_count = DESVAR_count+1;
                DESVAR_id = DESVAR_id+1;
                desvar(DESVAR_count) =...
                    DESVAR(DESVAR_id, ['PBAR',num2str(DESVAR_id)],...
                    pbar(obj.PBAR_r_num).A, spar_XLB, spar_XUB, [],...
                    obj.region, region_number, 'rspar', obj.POINT_r(2));
                obj.VAR_rbar_num = DESVAR_count;
                pbar(obj.PBAR_r_num).desvar_id = DESVAR_id;
            end
            if var_mode==6
                % 长桁截面积
                DESVAR_count = DESVAR_count+1;
                DESVAR_id = DESVAR_id+1;
                desvar(DESVAR_count) =...
                    DESVAR(DESVAR_id, ['PBAR',num2str(DESVAR_id)],...
                    pbar(obj.PBAR_s_num(1)).A, str_XLB, str_XUB, [],...
                    obj.region, region_number, 'str', 0.5*(obj.POINT_f(2)+obj.POINT_r(2)));
                obj.VAR_string_num = DESVAR_count;
                pbar(obj.PBAR_s_num(1)).desvar_id = DESVAR_id;
            end
            % 前腹板
            DESVAR_count = DESVAR_count+1;
            DESVAR_id = DESVAR_id+1;
            desvar(DESVAR_count) =...
                DESVAR(DESVAR_id, ['PSHEL',num2str(DESVAR_id)],...
                pshell(obj.PSHELL_f_num).thick, web_XLB, web_XUB, [],...
                obj.region, region_number, 'fweb', obj.POINT_f(2));
            obj.VAR_fweb_num = DESVAR_count;
            pshell(obj.PSHELL_f_num).desvar_id = DESVAR_id;
            % 后腹板
            DESVAR_count = DESVAR_count+1;
            DESVAR_id = DESVAR_id+1;
            desvar(DESVAR_count) =...
                DESVAR(DESVAR_id, ['PSHEL',num2str(DESVAR_id)],...
                pshell(obj.PSHELL_r_num).thick, web_XLB, web_XUB, [],...
                obj.region, region_number, 'rweb', obj.POINT_r(2));
            obj.VAR_rweb_num = DESVAR_count;
            pshell(obj.PSHELL_r_num).desvar_id = DESVAR_id;
            % 蒙皮
            DESVAR_count = DESVAR_count+1;
            DESVAR_id = DESVAR_id+1;
            desvar(DESVAR_count) =...
                DESVAR(DESVAR_id, ['PSHEL',num2str(DESVAR_id)],...
                pshell(obj.PSHELL_b_num(1)).thick, skin_XLB, skin_XUB, [],...
                obj.region, region_number, 'skin', 0.5*(obj.POINT_f(2)+obj.POINT_r(2)));
            obj.VAR_board_num = DESVAR_count;
            pshell(obj.PSHELL_b_num(1)).desvar_id = DESVAR_id;
        end

        %% create DVPREL
        function [obj, DVPREL1_count,DVPREL1_id, dvprel1,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                pbar, pshell] = ...
                create_DVPREL(obj, DVPREL1_count,DVPREL1_id,dvprel1,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                desvar, pbar, pshell,...
                spar_XLB, spar_XUB, str_XLB, str_XUB,...
                skin_XLB, skin_XUB, web_XLB, web_XUB,...
                DEQATN_I1_bar_id, DEQATN_I2_bar_id, DEQATN_J_bar_id,...
                DEQATN_I1_str_id, DEQATN_I2_str_id, DEQATN_J_str_id)
            % b=10*h, 10*h*h=A, h=sqrt(0.1*A), I1=(h^3*b)/12=A^3/120,
            % I2=(b^3*h)/12=(5/6)*A^2, J=I2=(5/6)*A^2
            % 字段：A=4, I1=5, I2=6, J=7, THICK=4
            % PBAR_f
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% A
            DVID = desvar(obj.VAR_fbar_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                spar_XLB, spar_XUB, 0, DVID, COEF);
            pbar(obj.PBAR_f_num).DVPREL1_A_num = DVPREL1_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_I1_bar_id, DVID, []);
            pbar(obj.PBAR_f_num).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_I2_bar_id, DVID, []);
            pbar(obj.PBAR_f_num).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_J_bar_id, DVID, []);
            pbar(obj.PBAR_f_num).DVPREL2_J_num = DVPREL2_count;
            % PBAR_r
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% A
            DVID = desvar(obj.VAR_rbar_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                spar_XLB, spar_XUB, 0, DVID, COEF);
            pbar(obj.PBAR_r_num).DVPREL1_A_num = DVPREL1_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_I1_bar_id, DVID, []);
            pbar(obj.PBAR_r_num).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_I2_bar_id, DVID, []);
            pbar(obj.PBAR_r_num).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_J_bar_id, DVID, []);
            pbar(obj.PBAR_r_num).DVPREL2_J_num = DVPREL2_count;
            % PBAR_s
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% A
            DVID = desvar(obj.VAR_string_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                str_XLB, str_XUB, 0, DVID, COEF);
            pbar(obj.PBAR_s_num(1)).DVPREL1_A_num = DVPREL1_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I1_str_id, DVID, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I2_str_id, DVID, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id ,'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_J_str_id, DVID, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_J_num = DVPREL2_count;
            %
            % PSHELL_f
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_fweb_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_f_num, pshell(obj.PSHELL_f_num).id, PNAME,...
                web_XLB, web_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_f_num).DVPREL1_thick_num = DVPREL1_count;
            % PSHELL_r
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_rweb_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_r_num, pshell(obj.PSHELL_r_num).id, PNAME,...
                web_XLB, web_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_r_num).DVPREL1_thick_num = DVPREL1_count;
            % PSHELL_b
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_board_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_b_num(1), pshell(obj.PSHELL_b_num(1)).id, PNAME,...
                skin_XLB, skin_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_b_num(1)).DVPREL1_thick_num = DVPREL1_count;
        end
        %
        function [obj, DEQATN_count, DEQATN_id, deqatn,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                pbar, pshell] = ...
                create_DVPREL2(obj, DEQATN_count, DEQATN_id, deqatn,...
                DVPREL2_count,DVPREL2_id, dvprel2,...
                pbar, pshell, desvar,...
                spar_XLB, spar_XUB, str_XLB, str_XUB,...
                skin_XLB, skin_XUB, web_XLB, web_XUB,...
                half_span, block_id, DVID)
            % b=10*h, 10*h*h=A, h=sqrt(0.1*A), I1=(h^3*b)/12=A^3/120,
            % I2=(b^3*h)/12=(5/6)*A^2, J=I2=(5/6)*A^2
            % 字段：A=4, I1=5, I2=6, J=7, THICK=4
            DVID_fspar = DVID(1:3); DVID_rspar = DVID(4:6); DVID_str = DVID(7:9);
            DVID_fweb = DVID(10:12); DVID_rweb = DVID(13:15); DVID_skin = DVID(16:18);
            y_fspar = abs(obj.POINT_f(2));
            y_rspar = abs(obj.POINT_r(2));
            y_str = 0.5 * (y_fspar + y_rspar);
           %% EQATN : PBAR_fspar
            A_st = ['(a*EXP(b*', num2str(1-y_fspar/half_span), ')+c)'];
            % A
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_A_fspar_id = DEQATN_id;
            EQATN_A = ['Afspar', num2str(block_id), '(a,b,c)=', A_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_A);
            % I1
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I1_fspar_id = DEQATN_id;
            EQATN_I1 = ['I1fspar', num2str(block_id), '(a,b,c)=', A_st, '**2/48.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I1);
            % I2
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I2_fspar_id = DEQATN_id;
            EQATN_I2 = ['I2fspar', num2str(block_id), '(a,b,c)=', A_st, '**2/3.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I2);
            % J
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_J_fspar_id = DEQATN_id;
            EQATN_J = ['Jfspar', num2str(block_id), '(a,b,c)=', A_st, '**2/3.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_J);
           %% EQATN : PBAR_rspar
            A_st = ['(a*EXP(b*', num2str(1-y_rspar/half_span), ')+c)'];
            % A
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_A_rspar_id = DEQATN_id;
            EQATN_A = ['Arspar', num2str(block_id), '(a,b,c)=', A_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_A);
            % I1
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I1_rspar_id = DEQATN_id;
            EQATN_I1 = ['I1rspar', num2str(block_id), '(a,b,c)=', A_st, '**2/48.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I1);
            % I2
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I2_rspar_id = DEQATN_id;
            EQATN_I2 = ['I2rspar', num2str(block_id), '(a,b,c)=', A_st, '**2/3.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I2);
            % J
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_J_rspar_id = DEQATN_id;
            EQATN_J = ['Jrspar', num2str(block_id), '(a,b,c)=', A_st, '**2/3.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_J);
           %% EQATN : PBAR_str
            A_st = ['(a*EXP(b*', num2str(1-y_str/half_span), ')+c)'];
            % A
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_A_str_id = DEQATN_id;
            EQATN_A = ['Astr', num2str(block_id), '(a,b,c)=', A_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_A);
            % I1
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I1_str_id = DEQATN_id;
            EQATN_I1 = ['I1str', num2str(block_id), '(a,b,c)=', A_st, '**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I1);
            % I2
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I2_str_id = DEQATN_id;
            EQATN_I2 = ['I2str', num2str(block_id), '(a,b,c)=', A_st, '**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I2);
            % J
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_J_str_id = DEQATN_id;
            EQATN_J = ['Jstr', num2str(block_id), '(a,b,c)=', A_st, '**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_J);
           %% EQATN : Pshell_fweb
            T_st = ['a*EXP(b*', num2str(1-y_fspar/half_span), ')+c'];
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_T_fweb_id = DEQATN_id;
            EQATN_thick = ['Tfweb', num2str(block_id), '(a,b,c)=', T_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_thick);
           %% EQATN : Pshell_rweb
            T_st = ['a*EXP(b*', num2str(1-y_rspar/half_span), ')+c'];
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_T_rweb_id = DEQATN_id;
            EQATN_thick = ['Trweb', num2str(block_id), '(a,b,c)=', T_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_thick);
           %% EQATN : Pshell_skin
            T_st = ['a*EXP(b*', num2str(1-y_str/half_span), ')+c'];
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_T_skin_id = DEQATN_id;
            EQATN_thick = ['Tskin', num2str(block_id), '(a,b,c)=', T_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_thick);       
           %% DVPREL2 : fspar
            % A
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% A
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                spar_XLB, spar_XUB, DEQATN_A_fspar_id, DVID_fspar, []);
            pbar(obj.PBAR_f_num).DVPREL2_A_num = DVPREL2_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_I1_fspar_id, DVID_fspar, []);
            pbar(obj.PBAR_f_num).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_I2_fspar_id, DVID_fspar, []);
            pbar(obj.PBAR_f_num).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                [], [], DEQATN_J_fspar_id, DVID_fspar, []);
            pbar(obj.PBAR_f_num).DVPREL2_J_num = DVPREL2_count;
            % write pbar as desvar
            a=desvar(DVID_fspar(1)).XINT; b=desvar(DVID_fspar(2)).XINT; c=desvar(DVID_fspar(3)).XINT;
            A = a * exp(b * (1-y_fspar/half_span)) + c;
            pbar(obj.PBAR_f_num).A = A;
            pbar(obj.PBAR_f_num).Izz = A^2 / 48;
            pbar(obj.PBAR_f_num).Iyy = A^2 / 3;
            pbar(obj.PBAR_f_num).J = A^2 / 3;
            pbar(obj.PBAR_f_num).h = 0.5*sqrt(A);
            pbar(obj.PBAR_f_num).b = 2*sqrt(A);
           %% DVPREL2 : rspar
            % A
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% A
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                spar_XLB, spar_XUB, DEQATN_A_rspar_id, DVID_rspar, []);
            pbar(obj.PBAR_r_num).DVPREL2_A_num = DVPREL2_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_I1_rspar_id, DVID_rspar, []);
            pbar(obj.PBAR_r_num).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_I2_rspar_id, DVID_rspar, []);
            pbar(obj.PBAR_r_num).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                [], [], DEQATN_J_rspar_id, DVID_rspar, []);
            pbar(obj.PBAR_r_num).DVPREL2_J_num = DVPREL2_count;
            % write pbar as desvar
            a=desvar(DVID_rspar(1)).XINT; b=desvar(DVID_rspar(2)).XINT; c=desvar(DVID_rspar(3)).XINT;
            A = a * exp(b * (1-y_rspar/half_span)) + c;
            pbar(obj.PBAR_r_num).A = A;
            pbar(obj.PBAR_r_num).Izz = A^2 / 48;
            pbar(obj.PBAR_r_num).Iyy = A^2 / 3;
            pbar(obj.PBAR_r_num).J = A^2 / 3;
            pbar(obj.PBAR_r_num).h = 0.5*sqrt(A);
            pbar(obj.PBAR_r_num).b = 2*sqrt(A);
           %% DVPREL2 : str
            % A
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% A
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                str_XLB, str_XUB, DEQATN_A_str_id, DVID_str, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_A_num = DVPREL2_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I1_str_id, DVID_str, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I2_str_id, DVID_str, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_J_str_id, DVID_str, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_J_num = DVPREL2_count;
            % write pbar as desvar
            a=desvar(DVID_str(1)).XINT; b=desvar(DVID_str(2)).XINT; c=desvar(DVID_str(3)).XINT;
            A = a * exp(b * (1-y_str/half_span)) + c;
            pbar(obj.PBAR_s_num(1)).A = A;
            pbar(obj.PBAR_s_num(1)).Izz = A^2 / 12;
            pbar(obj.PBAR_s_num(1)).Iyy = A^2 / 12;
            pbar(obj.PBAR_s_num(1)).J = A^2 / 12;
            pbar(obj.PBAR_s_num(1)).h = sqrt(A);
            pbar(obj.PBAR_s_num(1)).b = sqrt(A);
           %% DVPREL2 : fweb
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% thick
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PSHELL', obj.PSHELL_f_num, pshell(obj.PSHELL_f_num).id, PNAME,...
                web_XLB, web_XUB, DEQATN_T_fweb_id, DVID_fweb, []);
            pshell(obj.PSHELL_f_num).DVPREL2_thick_num = DVPREL2_count;
            % write pshell as desvar
            a=desvar(DVID_fweb(1)).XINT; b=desvar(DVID_fweb(2)).XINT; c=desvar(DVID_fweb(3)).XINT;
            T = a * exp(b * (1-y_fspar/half_span)) + c;
            pshell(obj.PSHELL_f_num).thick = T;
           %% DVPREL2 : rweb
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% thick
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PSHELL', obj.PSHELL_r_num, pshell(obj.PSHELL_r_num).id, PNAME,...
                web_XLB, web_XUB, DEQATN_T_rweb_id, DVID_rweb, []);
            pshell(obj.PSHELL_r_num).DVPREL2_thick_num = DVPREL2_count;
            % write pshell as desvar
            a=desvar(DVID_rweb(1)).XINT; b=desvar(DVID_rweb(2)).XINT; c=desvar(DVID_rweb(3)).XINT;
            T = a * exp(b * (1-y_rspar/half_span)) + c;
            pshell(obj.PSHELL_r_num).thick = T;
           %% DVPREL2 : skin
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% thick
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PSHELL', obj.PSHELL_b_num(1), pshell(obj.PSHELL_b_num(1)).id, PNAME,...
                skin_XLB, skin_XUB, DEQATN_T_skin_id, DVID_skin, []);
            pshell(obj.PSHELL_b_num(1)).DVPREL2_thick_num = DVPREL2_count;
            % write pshell as desvar
            a=desvar(DVID_skin(1)).XINT; b=desvar(DVID_skin(2)).XINT; c=desvar(DVID_skin(3)).XINT;
            T = a * exp(b * (1-y_str/half_span)) + c;
            pshell(obj.PSHELL_b_num(1)).thick = T;
        end
        %% create_DVPREL3
        function [obj, DEQATN_count, DEQATN_id, deqatn,...
                DVPREL1_count, DVPREL1_id, dvprel1,...
                DVPREL2_count, DVPREL2_id, dvprel2,...
                pbar, pshell] = ...
                create_DVPREL3(obj, DEQATN_count, DEQATN_id, deqatn,...
                DVPREL1_count, DVPREL1_id, dvprel1,...
                DVPREL2_count, DVPREL2_id, dvprel2,...
                pbar, pshell, desvar,...
                spar_XLB, spar_XUB, str_XLB, str_XUB,...
                skin_XLB, skin_XUB, web_XLB, web_XUB,...
                DEQATN_I1_bar_id, DEQATN_I2_bar_id, DEQATN_J_bar_id,...
                A_over_bt, block_id, var_mode)% str decided by skin
            if var_mode==5 
                %% PBAR_f
                DVPREL1_count = DVPREL1_count+1;
                DVPREL1_id = DVPREL1_id+1;
                PNAME = 4;% A
                DVID = desvar(obj.VAR_fbar_num).id;
                COEF = 1;
                dvprel1(DVPREL1_count) = ...
                    DVPREL1(DVPREL1_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    spar_XLB, spar_XUB, 0, DVID, COEF);
                pbar(obj.PBAR_f_num).DVPREL1_A_num = DVPREL1_count;
                % I1
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 5;% I1
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_I1_bar_id, DVID, []);
                pbar(obj.PBAR_f_num).DVPREL2_I1_num = DVPREL2_count;
                % I2
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 6;% I2
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_I2_bar_id, DVID, []);
                pbar(obj.PBAR_f_num).DVPREL2_I2_num = DVPREL2_count;
                % J
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 7;% J
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_J_bar_id, DVID, []);
                pbar(obj.PBAR_f_num).DVPREL2_J_num = DVPREL2_count;
                %% PBAR_r
                DVPREL1_count = DVPREL1_count+1;
                DVPREL1_id = DVPREL1_id+1;
                PNAME = 4;% A
                DVID = desvar(obj.VAR_rbar_num).id;
                COEF = 1;
                dvprel1(DVPREL1_count) = ...
                    DVPREL1(DVPREL1_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    spar_XLB, spar_XUB, 0, DVID, COEF);
                pbar(obj.PBAR_r_num).DVPREL1_A_num = DVPREL1_count;
                % I1
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 5;% I1
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_I1_bar_id, DVID, []);
                pbar(obj.PBAR_r_num).DVPREL2_I1_num = DVPREL2_count;
                % I2
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 6;% I2
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_I2_bar_id, DVID, []);
                pbar(obj.PBAR_r_num).DVPREL2_I2_num = DVPREL2_count;
                % J
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 7;% J
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_J_bar_id, DVID, []);
                pbar(obj.PBAR_r_num).DVPREL2_J_num = DVPREL2_count;
            end
            %% PSHELL_f
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_fweb_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_f_num, pshell(obj.PSHELL_f_num).id, PNAME,...
                web_XLB, web_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_f_num).DVPREL1_thick_num = DVPREL1_count;
            %% PSHELL_r
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_rweb_num).id;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_r_num, pshell(obj.PSHELL_r_num).id, PNAME,...
                web_XLB, web_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_r_num).DVPREL1_thick_num = DVPREL1_count;
            %% PSHELL_b
            DVPREL1_count = DVPREL1_count+1;
            DVPREL1_id = DVPREL1_id+1;
            PNAME = 4;% thick
            DVID = desvar(obj.VAR_board_num).id;
            DVID_skin = DVID;
            COEF = 1;
            dvprel1(DVPREL1_count) = ...
                DVPREL1(DVPREL1_id, 'PSHELL', obj.PSHELL_b_num(1), pshell(obj.PSHELL_b_num(1)).id, PNAME,...
                skin_XLB, skin_XUB, 0, DVID, COEF);
            pshell(obj.PSHELL_b_num(1)).DVPREL1_thick_num = DVPREL1_count;
           %% DEQATN_str
            A_st = [num2str(A_over_bt * obj.skin_width/(1+obj.ns)),'*t'];
            % A
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_A_str_id = DEQATN_id;
            EQATN_A = ['Astr', num2str(block_id), '(t)=', A_st];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_A);
            % I1
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I1_str_id = DEQATN_id;
            EQATN_I1 = ['I1str', num2str(block_id), '(t)=(', A_st, ')**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I1);
            % I2
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_I2_str_id = DEQATN_id;
            EQATN_I2 = ['I2str', num2str(block_id), '(t)=(', A_st, ')**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_I2);
            % J
            DEQATN_count = DEQATN_count + 1;
            DEQATN_id = DEQATN_id + 1;
            DEQATN_J_str_id = DEQATN_id;
            EQATN_J = ['Jstr', num2str(block_id), '(t)=(', A_st, ')**2/12.'];
            deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN_J);
           %% DVPREL2 : str
            % A
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 4;% A
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                str_XLB, str_XUB, DEQATN_A_str_id, DVID_skin, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_A_num = DVPREL2_count;
            % I1
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 5;% I1
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I1_str_id, DVID_skin, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I1_num = DVPREL2_count;
            % I2
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 6;% I2
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_I2_str_id, DVID_skin, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_I2_num = DVPREL2_count;
            % J
            DVPREL2_count = DVPREL2_count+1;
            DVPREL2_id = DVPREL2_id+1;
            PNAME = 7;% J
            dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_s_num(1), pbar(obj.PBAR_s_num(1)).id, PNAME,...
                [], [], DEQATN_J_str_id, DVID_skin, []);
            pbar(obj.PBAR_s_num(1)).DVPREL2_J_num = DVPREL2_count;
            %% DVPREL2 : fspar, rspar
            if var_mode==3
                % A
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 4;% A
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    spar_XLB, spar_XUB, DEQATN_A_str_id, DVID_skin, []);
                pbar(obj.PBAR_f_num).DVPREL2_A_num = DVPREL2_count;
                % I1
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 5;% I1
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_I1_str_id, DVID_skin, []);
                pbar(obj.PBAR_f_num).DVPREL2_I1_num = DVPREL2_count;
                % I2
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 6;% I2
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_I2_str_id, DVID_skin, []);
                pbar(obj.PBAR_f_num).DVPREL2_I2_num = DVPREL2_count;
                % J
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 7;% J
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_f_num, pbar(obj.PBAR_f_num).id, PNAME,...
                    [], [], DEQATN_J_str_id, DVID_skin, []);
                pbar(obj.PBAR_f_num).DVPREL2_J_num = DVPREL2_count;
                %% A
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 4;% A
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    spar_XLB, spar_XUB, DEQATN_A_str_id, DVID_skin, []);
                pbar(obj.PBAR_r_num).DVPREL2_A_num = DVPREL2_count;
                % I1
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 5;% I1
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_I1_str_id, DVID_skin, []);
                pbar(obj.PBAR_r_num).DVPREL2_I1_num = DVPREL2_count;
                % I2
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 6;% I2
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_I2_str_id, DVID_skin, []);
                pbar(obj.PBAR_r_num).DVPREL2_I2_num = DVPREL2_count;
                % J
                DVPREL2_count = DVPREL2_count+1;
                DVPREL2_id = DVPREL2_id+1;
                PNAME = 7;% J
                dvprel2(DVPREL2_count) = DVPREL2(DVPREL2_id, 'PBAR', obj.PBAR_r_num, pbar(obj.PBAR_r_num).id, PNAME,...
                    [], [], DEQATN_J_str_id, DVID_skin, []);
                pbar(obj.PBAR_r_num).DVPREL2_J_num = DVPREL2_count;
            end
        end
    end
end

