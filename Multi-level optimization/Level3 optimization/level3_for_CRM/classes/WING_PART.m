classdef WING_PART
    properties
       %%
        direction;
        ns;
        region;
       %% 根部，梢部前后梁,长桁的坐标
        P_LE_root;
        P_TE_root;
        P_str_root;
        P_mid_root;
        P_fspar_root;
        P_rspar_root;
        %
        P_LE_tip;
        P_TE_tip;
        P_str_tip;
        P_mid_tip;
        P_fspar_tip;
        P_rspar_tip;
       %% 展向分段(前缘后缘点列）
        n;% 展向段数
        P_LE;
        P_fspar;
        P_str;
        P_rspar;
        P_TE;
        P_mid;
        toc;
        %% 每段的剖面厚度
        T_fspar;
        T_rspar;
        T_str;        
        %% z向数据
        up_angle;
        height;
    end
    methods
        %% 形状控制点输入和规则形状形成
        function obj = WING_PART(POINT1,POINT2,POINT3,POINT4, Cf_root,Cr_root,Cf_tip,Cr_tip, inner_contr,outer_contr, region,direction,ns)
            obj.region = region;
            obj.direction = direction;
            obj.ns = ns;
            obj.P_LE_root = POINT1;
            obj.P_TE_root = POINT2;
            obj.P_LE_tip = POINT3;
            obj.P_TE_tip = POINT4;
            obj.P_fspar_root = POINT1 + Cf_root*(POINT2-POINT1);
            obj.P_rspar_root = POINT1 + Cr_root*(POINT2-POINT1);
            obj.P_fspar_tip = POINT3 + Cf_tip*(POINT4-POINT3);
            obj.P_rspar_tip = POINT3 + Cr_tip*(POINT4-POINT3);
            obj.P_mid_root = 0.5*(obj.P_fspar_root+obj.P_rspar_root);
            obj.P_mid_tip = 0.5*(obj.P_fspar_tip+obj.P_rspar_tip);
            obj.P_str_root = zeros(ns, 2);
            obj.P_str_tip = zeros(ns, 2);
            for ii = 1:obj.ns
                obj.P_str_root(ii,:) = obj.P_fspar_root + ii/(ns+1) * (obj.P_rspar_root-obj.P_fspar_root);
                obj.P_str_tip(ii,:) = obj.P_fspar_tip + ii/(ns+1) * (obj.P_rspar_tip-obj.P_fspar_tip);
            end            
            if inner_contr == 1
                obj.P_mid_root = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_fspar_root);
                obj.P_rspar_root = two_line_cross(obj.P_fspar_root,obj.P_mid_root, obj.P_rspar_root,obj.P_rspar_tip);
            elseif inner_contr == 2
                obj.P_mid_root = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_rspar_root);
                obj.P_fspar_root = two_line_cross(obj.P_rspar_root,obj.P_mid_root, obj.P_fspar_root,obj.P_fspar_tip);
            elseif inner_contr == 2.5
                obj.P_mid_root = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_TE_root);
                obj.P_fspar_root = two_line_cross(obj.P_TE_root,obj.P_mid_root, obj.P_fspar_root,obj.P_fspar_tip);
                obj.P_rspar_root = two_line_cross(obj.P_TE_root,obj.P_mid_root, obj.P_rspar_root,obj.P_rspar_tip);
            end
            if outer_contr == 3
                obj.P_mid_tip = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_fspar_tip);
                obj.P_rspar_tip = two_line_cross(obj.P_fspar_tip,obj.P_mid_tip, obj.P_rspar_root,obj.P_rspar_tip);
            elseif outer_contr == 4
                obj.P_mid_tip = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_rspar_tip);
                obj.P_fspar_tip = two_line_cross(obj.P_rspar_tip,obj.P_mid_tip, obj.P_fspar_root,obj.P_fspar_tip);
            end
        end
                 
        %% get_z
        function obj = get_z(obj, height,up_angle)
            obj.height = height;
            obj.up_angle = up_angle;
        end
        %% cut_block_ave
        function obj = cut_block_ave(obj,n)
            obj.n = n;
            for ii = 1:n+1
                obj.P_fspar(ii,:) = obj.P_fspar_root + (ii-1)/n * (obj.P_fspar_tip-obj.P_fspar_root);
                obj.P_rspar(ii,:) = obj.P_rspar_root + (ii-1)/n * (obj.P_rspar_tip-obj.P_rspar_root);
                obj.P_LE(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_LE_root, obj.P_LE_tip);
                obj.P_TE(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_TE_root, obj.P_TE_tip);
                obj.P_mid(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_mid_root, obj.P_mid_tip);
                for jj = 1:obj.ns
                    obj.P_str{ii,jj} = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_str_root(jj,:), obj.P_str_tip(jj,:));
                end
            end
        end
        %% cut_block_vertical
        function obj = cut_block_vertical(obj,n)
            obj.n = n;
            P_mid_bottom = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_LE_root);
            P_mid_top = drop_point(obj.P_mid_root, obj.P_mid_tip, obj.P_TE_tip);      
            for ii = 1:n+1
                if ii~=1 && ii~=n+1
                    P_center = P_mid_bottom + (ii-1)/n * (P_mid_top-P_mid_bottom);
                    obj.P_mid(ii,:) = P_center;
                    obj.P_LE(ii,:) = vertical_cross_point(P_mid_top, P_mid_bottom, P_center, obj.P_LE_root, obj.P_LE_tip);
                    obj.P_TE(ii,:) = vertical_cross_point(P_mid_top, P_mid_bottom, P_center, obj.P_TE_root, obj.P_TE_tip);
                    obj.P_fspar(ii,:) = vertical_cross_point(P_mid_top, P_mid_bottom, P_center, obj.P_fspar_root, obj.P_fspar_tip);
                    obj.P_rspar(ii,:) = vertical_cross_point(P_mid_top, P_mid_bottom, P_center, obj.P_rspar_root, obj.P_rspar_tip);
                    for jj=1:obj.ns
                        obj.P_str{ii,jj} = vertical_cross_point(P_mid_top, P_mid_bottom, P_center, obj.P_str_root(jj,:), obj.P_str_tip(jj,:));
                    end
                else
                    obj.P_fspar(ii,:) = obj.P_fspar_root + (ii-1)/n * (obj.P_fspar_tip-obj.P_fspar_root);
                    obj.P_rspar(ii,:) = obj.P_rspar_root + (ii-1)/n * (obj.P_rspar_tip-obj.P_rspar_root);
                    obj.P_LE(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_LE_root, obj.P_LE_tip);
                    obj.P_TE(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_TE_root, obj.P_TE_tip);
                    obj.P_mid(ii,:) = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_mid_root, obj.P_mid_tip);
                    for jj = 1:obj.ns
                        obj.P_str{ii,jj} = two_line_cross(obj.P_fspar(ii,:), obj.P_rspar(ii,:), obj.P_str_root(jj,:), obj.P_str_tip(jj,:));
                    end
                end
            end
        end
        %% calculate thickness
        function obj = cal_thick(obj, airfoil, half_span)
            for ii=1:obj.n+1
                span_eta = obj.P_mid(ii,2)/half_span;
                toc = get_toc(obj.region, span_eta);
                obj.toc(ii) = toc;
                chord  = obj.P_TE(ii,:) - obj.P_LE(ii,:);
                chord0 = chord;
                chord0(2) = 0;
                chord_norm = norm(chord);
                cos_sweep = norm(chord0) / chord_norm;
                thick_factor = chord_norm * toc/airfoil.toc_origin / cos_sweep;
                obj.T_fspar(ii) = interp1(airfoil.range, airfoil.thick, ...
                                    norm(obj.P_fspar(ii,:)-obj.P_LE(ii,:))/chord_norm, 'linear') * thick_factor;
                obj.T_rspar(ii) = interp1(airfoil.range, airfoil.thick, ...
                                    norm(obj.P_rspar(ii,:)-obj.P_LE(ii,:))/chord_norm, 'linear') * thick_factor;
                for jj=1:obj.ns
                    obj.T_str(ii,jj) = interp1(airfoil.range, airfoil.thick, ...
                                    norm(obj.P_str{ii,jj}-obj.P_LE(ii,:))/chord_norm, 'linear') * thick_factor;
                end
            end
        end
        %% 手动输入结构控制点
        function obj=input_edge_point(obj, P_fspar_root,P_rspar_root,P_str_root, P_fspar_tip,P_rspar_tip,P_str_tip)
            obj.P_fspar_root = P_fspar_root;
            obj.P_rspar_root = P_rspar_root;
            obj.P_mid_root = 0.5*(P_fspar_root+P_rspar_root);
            obj.P_str_root = P_str_root;
            obj.P_fspar_tip = P_fspar_tip;
            obj.P_rspar_tip = P_rspar_tip;
            obj.P_mid_tip = 0.5*(P_fspar_tip+P_rspar_tip);
            obj.P_str_tip = P_str_tip;
            obj.ns = length(P_str_root(:,1));
        end
        %% 厚度插值
        function obj = thick_interp(obj, T_fspar_root,T_rspar_root, T_str_root, T_fspar_tip,T_rspar_tip, T_str_tip) 
            nn = obj.n;
            for ii = 1:nn+1
                obj.T_fspar(ii) = T_fspar_root + (ii-1)*(T_fspar_tip-T_fspar_root)/nn;
                obj.T_rspar(ii) = T_rspar_root + (ii-1)*(T_rspar_tip-T_rspar_root)/nn;
                for jj = 1:obj.ns
                    obj.T_str(ii,jj) = T_str_root(jj) + (ii-1)*(T_str_tip(jj)-T_str_root(jj))/nn;
                end
            end
        end
        %% connect 2 wingParts
        function obj = connect_part_th(obj, part1, part2, n)
            obj.ns = size(part1.P_str,2);
            obj.P_LE_root = part1.P_LE(end,:);
            obj.P_TE_root = part1.P_TE(end,:);
            obj.P_fspar_root = part1.P_fspar(end,:);
            obj.P_rspar_root = part1.P_rspar(end,:);
            obj.P_mid_root = part1.P_mid(end,:);
            obj.P_LE_tip = part2.P_LE(1,:);
            obj.P_TE_tip = part2.P_TE(1,:);
            obj.P_fspar_tip = part2.P_fspar(1,:);
            obj.P_rspar_tip = part2.P_rspar(1,:);
            obj.P_mid_tip = part2.P_mid(1,:);
            for ii=1:obj.ns
                obj.P_str_root(ii,:) = part1.P_str{end,ii};
                obj.P_str_tip(ii,:) = part2.P_str{1,ii};
            end
            %
            obj = obj.cut_block_ave(n);
            T_fspar_root = part1.T_fspar(end);
            T_rspar_root = part1.T_rspar(end);
            T_str_root = part1.T_str(end,:);
            T_fspar_tip = part2.T_fspar(1);
            T_rspar_tip = part2.T_rspar(1);
            T_str_tip = part2.T_str(1,:);
            obj = obj.thick_interp(T_fspar_root,T_rspar_root, T_str_root, T_fspar_tip,T_rspar_tip, T_str_tip);  
        end
        %% cut wing_part into wing_box
        function [wing_box,WING_BOX_count]= cut_into_box(obj, wing_box,WING_BOX_count,nb,nc, V)
            % wing_box, WING_BOX_count
            for ii = 1:obj.n
                if obj.direction=='z'
                    POINT1_lead = [obj.P_LE(ii,:), obj.height + abs(obj.P_LE(ii,2))*tan(obj.up_angle)];
                    POINT1_tail = [obj.P_TE(ii,:), obj.height + abs(obj.P_TE(ii,2))*tan(obj.up_angle)];
                    POINT3_lead = [obj.P_LE(ii+1,:), obj.height + abs(obj.P_LE(ii+1,2))*tan(obj.up_angle)];
                    POINT3_tail = [obj.P_TE(ii+1,:), obj.height + abs(obj.P_TE(ii+1,2))*tan(obj.up_angle)];
                    POINT1_f = [obj.P_fspar(ii,:), 0.5*obj.T_fspar(ii) + obj.height + abs(obj.P_fspar(ii,2))*tan(obj.up_angle)];
                    POINT2_f = [obj.P_fspar(ii,:), -0.5*obj.T_fspar(ii) + obj.height + abs(obj.P_fspar(ii,2))*tan(obj.up_angle)];
                    POINT3_f = [obj.P_fspar(ii+1,:), 0.5*obj.T_fspar(ii+1) + obj.height + abs(obj.P_fspar(ii+1,2))*tan(obj.up_angle)];
                    POINT4_f = [obj.P_fspar(ii+1,:), -0.5*obj.T_fspar(ii+1) + obj.height + abs(obj.P_fspar(ii+1,2))*tan(obj.up_angle)];
                    POINT1_r = [obj.P_rspar(ii,:), 0.5*obj.T_rspar(ii) + obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle)];
                    POINT2_r = [obj.P_rspar(ii,:), -0.5*obj.T_rspar(ii) + obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle)];
                    POINT3_r = [obj.P_rspar(ii+1,:), 0.5*obj.T_rspar(ii+1) + obj.height + abs(obj.P_rspar(ii+1,2))*tan(obj.up_angle)];
                    POINT4_r = [obj.P_rspar(ii+1,:), -0.5*obj.T_rspar(ii+1) + obj.height + abs(obj.P_rspar(ii+1,2))*tan(obj.up_angle)];
                    for jj = 1:obj.ns
                        P1 = obj.P_str{ii,jj};
                        P3 = obj.P_str{ii+1,jj};
                        POINT1_s(jj,:) = [P1, 0.5*obj.T_str(ii,jj) + obj.height + abs(P1(2))*tan(obj.up_angle)];
                        POINT2_s(jj,:) = [P1, -0.5*obj.T_str(ii,jj) + obj.height + abs(P1(2))*tan(obj.up_angle)];
                        POINT3_s(jj,:) = [P3, 0.5*obj.T_str(ii+1,jj) + obj.height + abs(P3(2))*tan(obj.up_angle)];
                        POINT4_s(jj,:) = [P3, -0.5*obj.T_str(ii+1,jj) + obj.height + abs(P3(2))*tan(obj.up_angle)];
                    end 
                else
                    POINT1_lead = [obj.P_LE(ii,1), 0, obj.P_LE(ii,2)];
                    POINT1_tail = [obj.P_TE(ii,1), 0, obj.P_TE(ii,2)];
                    POINT3_lead = [obj.P_LE(ii+1,1), 0, obj.P_LE(ii+1,2)];
                    POINT3_tail = [obj.P_TE(ii+1,1), 0, obj.P_TE(ii+1,2)];
                    POINT1_f = [obj.P_fspar(ii,1), 0.5*obj.T_fspar(ii), obj.P_fspar(ii,2)];
                    POINT2_f = [obj.P_fspar(ii,1), -0.5*obj.T_fspar(ii), obj.P_fspar(ii,2)];
                    POINT3_f = [obj.P_fspar(ii+1,1), 0.5*obj.T_fspar(ii+1), obj.P_fspar(ii+1,2)];
                    POINT4_f = [obj.P_fspar(ii+1,1), -0.5*obj.T_fspar(ii+1), obj.P_fspar(ii+1,2)];
                    POINT1_r = [obj.P_rspar(ii,1), 0.5*obj.T_rspar(ii), obj.P_rspar(ii,2)];
                    POINT2_r = [obj.P_rspar(ii,1), -0.5*obj.T_rspar(ii), obj.P_rspar(ii,2)];
                    POINT3_r = [obj.P_rspar(ii+1,1), 0.5*obj.T_rspar(ii+1), obj.P_rspar(ii+1,2)];
                    POINT4_r = [obj.P_rspar(ii+1,1), -0.5*obj.T_rspar(ii+1), obj.P_rspar(ii+1,2)];
                    for jj = 1:obj.ns
                        P1 = obj.P_str{ii,jj};
                        P3 = obj.P_str{ii+1,jj};
                        POINT1_s(jj,:) = [P1(1), 0.5*obj.T_str(ii,jj), P1(2)];
                        POINT2_s(jj,:) = [P1(1), -0.5*obj.T_str(ii,jj), P1(2)];
                        POINT3_s(jj,:) = [P3(1), 0.5*obj.T_str(ii+1,jj), P3(2)];
                        POINT4_s(jj,:) = [P3(1), -0.5*obj.T_str(ii+1,jj), P3(2)];
                    end
                end   
                WING_BOX_count = WING_BOX_count+1;
                wing_box(WING_BOX_count) = WING_BOX(obj.region,nb,nc);
                wing_box(WING_BOX_count).V = V;
                wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_lead_tail(POINT1_lead, POINT1_tail, POINT3_lead, POINT3_tail);
                wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_f(POINT1_f, POINT2_f, POINT3_f, POINT4_f);
                wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_r(POINT1_r, POINT2_r, POINT3_r, POINT4_r);
                wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_s(POINT1_s, POINT2_s, POINT3_s, POINT4_s);
                wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_skin_width();
            end
        end
        %% create vers_y part
        function obj1 = vers_y(obj)
            obj1 = obj;
            obj1.P_LE_root = vers_y(obj1.P_LE_root);
            obj1.P_TE_root = vers_y(obj1.P_TE_root);
            obj1.P_fspar_root = vers_y(obj1.P_fspar_root);
            obj1.P_rspar_root = vers_y(obj1.P_rspar_root);
            obj1.P_mid_root = vers_y(obj1.P_mid_root);
            obj1.P_LE_tip = vers_y(obj1.P_LE_tip);
            obj1.P_TE_tip = vers_y(obj1.P_TE_tip);
            obj1.P_fspar_tip = vers_y(obj1.P_fspar_tip);
            obj1.P_rspar_tip = vers_y(obj1.P_rspar_tip);
            obj1.P_mid_tip = vers_y(obj1.P_mid_tip);
            for jj = 1:obj1.ns
                obj1.P_str_root(jj,:) = vers_y(obj1.P_str_root(jj,:));
                obj1.P_str_tip(jj,:) = vers_y(obj1.P_str_tip(jj,:));
            end
            obj1.P_LE = vers_y(obj1.P_LE);
            obj1.P_TE = vers_y(obj1.P_TE);
            obj1.P_fspar = vers_y(obj1.P_fspar);
            obj1.P_rspar = vers_y(obj1.P_rspar);
            obj1.P_mid = vers_y(obj1.P_mid);
            for ii = 1:obj1.n+1
                for jj = 1:obj1.ns
                    obj1.P_str{ii,jj} = vers_y(obj1.P_str{ii,jj});
                end
            end
        end
        %%  plot
        function plot_shape(obj)
            if obj.direction=='z'
                linewidth = 1;
                plot([obj.P_LE_root(1),obj.P_LE_tip(1)], [obj.P_LE_root(2),obj.P_LE_tip(2)], 'r--o', 'linewidth', linewidth); hold on;
                plot([obj.P_TE_root(1),obj.P_TE_tip(1)], [obj.P_TE_root(2),obj.P_TE_tip(2)], 'r--o', 'linewidth', linewidth); hold on;
                plot([obj.P_fspar_root(1),obj.P_fspar_tip(1)], [obj.P_fspar_root(2),obj.P_fspar_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                plot([obj.P_rspar_root(1),obj.P_rspar_tip(1)], [obj.P_rspar_root(2),obj.P_rspar_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                plot([obj.P_mid_root(1),obj.P_mid_tip(1)], [obj.P_mid_root(2),obj.P_mid_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                for ii  = 1:obj.ns
                    plot([obj.P_str_root(ii,1),obj.P_str_tip(ii,1)], [obj.P_str_root(ii,2),obj.P_str_tip(ii,2)], 'r--o', 'linewidth', linewidth); hold on;
                end
            else
                linewidth = 1;
                plot3([obj.P_LE_root(1),obj.P_LE_tip(1)], [0,0], [obj.P_LE_root(2),obj.P_LE_tip(2)], 'r--o', 'linewidth', linewidth); hold on;
                plot3([obj.P_TE_root(1),obj.P_TE_tip(1)], [0,0], [obj.P_TE_root(2),obj.P_TE_tip(2)], 'r--o', 'linewidth', linewidth); hold on;
                plot3([obj.P_fspar_root(1),obj.P_fspar_tip(1)], [0,0], [obj.P_fspar_root(2),obj.P_fspar_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                plot3([obj.P_rspar_root(1),obj.P_rspar_tip(1)], [0,0], [obj.P_rspar_root(2),obj.P_rspar_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                plot3([obj.P_mid_root(1),obj.P_mid_tip(1)], [0,0], [obj.P_mid_root(2),obj.P_mid_tip(2)], 'g--o', 'linewidth', linewidth); hold on;
                for ii  = 1:obj.ns
                    plot3([obj.P_str_root(ii,1),obj.P_str_tip(ii,1)], [0,0], [obj.P_str_root(ii,2),obj.P_str_tip(ii,2)], 'r--o', 'linewidth', linewidth); hold on;
                end
            end
        end
        function plot_block_point(obj)
            linewidth = 2;
            if obj.direction=='z'
                for ii  = 1:obj.n
                    plot([obj.P_LE(ii,1),obj.P_LE(ii+1,1)], [obj.P_LE(ii,2),obj.P_LE(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot([obj.P_TE(ii,1),obj.P_TE(ii+1,1)], [obj.P_TE(ii,2),obj.P_TE(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot([obj.P_fspar(ii,1),obj.P_fspar(ii+1,1)], [obj.P_fspar(ii,2),obj.P_fspar(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot([obj.P_rspar(ii,1),obj.P_rspar(ii+1,1)], [obj.P_rspar(ii,2),obj.P_rspar(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot([obj.P_mid(ii,1),obj.P_mid(ii+1,1)], [obj.P_mid(ii,2),obj.P_mid(ii+1,2)], '*-k', 'linewidth', linewidth); hold on; 
                    plot(obj.P_fspar(ii,1), obj.P_fspar(ii,2), '*k'); hold on;
                    plot(obj.P_rspar(ii,1), obj.P_rspar(ii,2), '*k'); hold on;
                    plot(obj.P_mid(ii,1), obj.P_mid(ii,2), '*k'); hold on;
                    for jj = 1:1:obj.ns
                        P1 = obj.P_str{ii,jj};
                        P2 = obj.P_str{ii+1,jj};
                        plot([P1(1),P2(1)], [P1(2),P2(2)], '*-k', 'linewidth', linewidth); hold on;
                    end
                end
            else
                for ii  = 1:obj.n
                    plot3([obj.P_LE(ii,1),obj.P_LE(ii+1,1)], [0,0], [obj.P_LE(ii,2),obj.P_LE(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot3([obj.P_TE(ii,1),obj.P_TE(ii+1,1)], [0,0], [obj.P_TE(ii,2),obj.P_TE(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot3([obj.P_fspar(ii,1),obj.P_fspar(ii+1,1)], [0,0], [obj.P_fspar(ii,2),obj.P_fspar(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot3([obj.P_rspar(ii,1),obj.P_rspar(ii+1,1)], [0,0], [obj.P_rspar(ii,2),obj.P_rspar(ii+1,2)], '*-k', 'linewidth', linewidth); hold on;
                    plot3([obj.P_mid(ii,1),obj.P_mid(ii+1,1)], [0,0], [obj.P_mid(ii,2),obj.P_mid(ii+1,2)], '*-k', 'linewidth', linewidth); hold on; 
                    plot3(obj.P_fspar(ii,1), 0, obj.P_fspar(ii,2), '*k'); hold on;
                    plot3(obj.P_rspar(ii,1), 0, obj.P_rspar(ii,2), '*k'); hold on;
                    plot3(obj.P_mid(ii,1), 0, obj.P_mid(ii,2), '*k'); hold on;
                    for jj = 1:1:obj.ns
                        P1 = obj.P_str{ii,jj};
                        P2 = obj.P_str{ii+1,jj};
                        plot([P1(1),P2(1)], [0,0], [P1(2),P2(2)], '*-k', 'linewidth', linewidth); hold on;
                    end
                end
            end
        end        
        function plot_STRpoint_xyz(obj)
            for ii  = 1:obj.n+1
                if obj.direction=='z'
                    Pup = [obj.P_fspar(ii,:), obj.height + abs(obj.P_fspar(ii,2))*tan(obj.up_angle) + 0.5*obj.T_fspar(ii)];
                    Pdown = [obj.P_fspar(ii,:), obj.height + abs(obj.P_fspar(ii,2))*tan(obj.up_angle) - 0.5*obj.T_fspar(ii)];
                else
                    Pup = [obj.P_fspar(ii,1), 0, obj.P_fspar(ii,2)];
                    Pdown = [obj.P_fspar(ii,1), 0, obj.P_fspar(ii,2)];
                end
                plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
                plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
                %
                if obj.direction=='z'
                    Pup = [obj.P_rspar(ii,:), obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle) + 0.5*obj.T_rspar(ii)];
                    Pdown = [obj.P_rspar(ii,:), obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle) - 0.5*obj.T_rspar(ii)];
                else
                    Pup = [obj.P_rspar(ii,1), obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle) + 0.5*obj.T_rspar(ii), obj.P_rspar(ii,2)];
                    Pdown = [obj.P_rspar(ii,1), obj.height + abs(obj.P_rspar(ii,2))*tan(obj.up_angle) - 0.5*obj.T_rspar(ii), obj.P_rspar(ii,2)];
                end
                plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
                plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
                %
                for jj = 1:obj.ns
                    P = obj.P_str{ii,jj};
                    if obj.direction=='z'
                        Pup = [P, obj.height + abs(P(2))*tan(obj.up_angle) + 0.5*obj.T_str(ii,jj)];
                        Pdown = [P, obj.height + abs(P(2))*tan(obj.up_angle) - 0.5*obj.T_str(ii,jj)];
                    else
                        Pup = [P(1), 0, P(2)];
                        Pdown = [P(1), 0, P(2)];
                    end
                    plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
                    plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
                end
            end
        end
    end 
end


% classdef WING_PART
%     properties
%         direction;
%         %% 原始点
%         POINT1;
%         POINT2;
%         POINT3;
%         POINT4;
%         POINT5;
%         POINT6;
%         %% 规则点
%         POINT1_bar;
%         POINT2_bar;
%         POINT3_bar;
%         POINT4_bar;
%         POINT5_bar;
%         POINT6_bar;
%         %% 根部，梢部前后梁,长桁的相对弦长
%         ns;
%         Cf_root;
%         Cr_root;
%         Cs_root;
%         Cf_tip;
%         Cr_tip;
%         Cs_tip;
%         %% 根部，梢部前后梁,长桁的坐标
%         Pf_root;
%         Pr_root;
%         Ps_root;
%         Pf_tip;
%         Pr_tip;
%         Ps_tip;
%         %% 展向分段(前缘后缘点列）
%         n;% 展向段数
%         P_lead;% 前缘分块点
%         P_tail;% 后缘分块点
%         P_q;% 1/4弦分块点
%         P_f;% 前梁分块点
%         P_r;% 后梁分块点
%         P_s;% 长桁分块点  
%         %% 每段的剖面厚度
%         T_f;
%         T_r;
%         T_s;        
%         %% 翼型
%         air_root_num;
%         air_tip_num;
%         %% z向数据
%         up_angle;
%         height;
%     end
%     methods
%         %% 形状控制点输入和规则形状形成
%         function obj = WING_PART(POINT1,POINT2,POINT3,POINT4,POINT5,POINT6, inner_contr, outer_contr, direction)
%             obj.direction = direction;
%             obj.POINT1 = POINT1;
%             obj.POINT2 = POINT2;
%             obj.POINT3 = POINT3;
%             obj.POINT4 = POINT4;
%             POINT5 = two_line_cross(POINT5, POINT6, POINT1, POINT2);
%             POINT6 = two_line_cross(POINT5, POINT6, POINT3, POINT4);
%             obj.POINT5 = POINT5;
%             obj.POINT6 = POINT6;
%             if inner_contr == 1
%                 obj.POINT1_bar = POINT1;
%                 obj.POINT5_bar = drop_point(POINT5, POINT6, POINT1);
%                 obj.POINT2_bar = two_line_cross(obj.POINT1_bar, obj.POINT5_bar, POINT2, POINT4);
%             elseif inner_contr == 2
%                 obj.POINT2_bar = POINT2;
%                 obj.POINT5_bar = drop_point(POINT5, POINT6, POINT2);
%                 obj.POINT1_bar = two_line_cross(obj.POINT2_bar, obj.POINT5_bar, POINT1, POINT3);
%             else
%                 obj.POINT1_bar = POINT1;
%                 obj.POINT2_bar = POINT2;
%                 obj.POINT5_bar = POINT5;
%             end
%             if outer_contr == 3
%                 obj.POINT3_bar = POINT3;
%                 obj.POINT6_bar = drop_point(POINT5, POINT6, POINT3);
%                 obj.POINT4_bar = two_line_cross(obj.POINT3_bar, obj.POINT6_bar, POINT2, POINT4);
%             elseif outer_contr == 4
%                 obj.POINT4_bar = POINT4;
%                 obj.POINT6_bar = drop_point(POINT5, POINT6, POINT4);
%                 obj.POINT3_bar = two_line_cross(obj.POINT4_bar, obj.POINT6_bar, POINT1, POINT3);
%             else
%                 obj.POINT3_bar = POINT3;
%                 obj.POINT4_bar = POINT4;
%                 obj.POINT6_bar = POINT6;
%             end
%         end
%         %% 根据纵向原件的相对位置生成两端的结构控制点
%         function obj = STR_pos(obj, Cf_root,Cr_root,Cs_root,Cf_tip,Cr_tip,Cs_tip)
%             obj.ns = length(Cs_root);
%             obj.Cf_root = Cf_root;
%             obj.Cr_root = Cr_root;
%             obj.Cs_root = Cs_root;
%             obj.Cf_tip = Cf_tip;
%             obj.Cr_tip = Cr_tip;
%             obj.Cs_tip = Cs_tip;
%             %
%             obj.Pf_root = obj.POINT1_bar + Cf_root*(obj.POINT2_bar-obj.POINT1_bar);
%             obj.Pr_root = obj.POINT1_bar + Cr_root*(obj.POINT2_bar-obj.POINT1_bar);
%             for ii  = 1:obj.ns
%                 obj.Ps_root(ii,:) = obj.POINT1_bar + Cs_root(ii)*(obj.POINT2_bar-obj.POINT1_bar);
%             end
%             obj.Pf_tip = obj.POINT3_bar + Cf_tip*(obj.POINT4_bar-obj.POINT3_bar);
%             obj.Pr_tip = obj.POINT3_bar + Cr_tip*(obj.POINT4_bar-obj.POINT3_bar);
%             for ii  = 1:obj.ns
%                 obj.Ps_tip(ii,:) = obj.POINT3_bar + Cs_tip(ii)*(obj.POINT4_bar-obj.POINT3_bar);
%             end
%         end        
%         %% get_z
%         function obj = get_z(obj, height,up_angle)
%             obj.height = height;
%             obj.up_angle = up_angle;
%         end
%         %% get_airfoil
%         function obj = get_airfoil(obj, air_root_num, air_tip_num)
%             obj.air_root_num = air_root_num;
%             obj.air_tip_num = air_tip_num;
%         end
%         %% cut_block_ave(前后缘均分)
%         function obj = cut_block_ave(obj,n)
%             obj.n = n;
%             for ii = 1:n+1
%                 obj.P_lead(ii,:) = obj.POINT1 + (ii-1)*(obj.POINT3-obj.POINT1)/n;
%                 obj.P_tail(ii,:) = obj.POINT2 + (ii-1)*(obj.POINT4-obj.POINT2)/n;
%                 obj.P_f(ii,:) = two_line_cross(obj.P_lead(ii,:), obj.P_tail(ii,:), obj.Pf_root, obj.Pf_tip);
%                 obj.P_r(ii,:) = two_line_cross(obj.P_lead(ii,:), obj.P_tail(ii,:), obj.Pr_root, obj.Pr_tip);
%                 obj.P_q(ii,:) = two_line_cross(obj.P_lead(ii,:), obj.P_tail(ii,:), obj.POINT5, obj.POINT6);
%                 for jj = 1:obj.ns
%                     obj.P_s{ii,jj} = two_line_cross(obj.P_lead(ii,:), obj.P_tail(ii,:), obj.Ps_root(jj,:), obj.Ps_tip(jj,:));
%                 end
%             end
%         end    
%         %% cut_block_ave_q(1/4弦均分)
%         function obj = cut_block_ave_q(obj,n)
%             obj.n = n;
%             P_half_root = 0.5*(obj.POINT1+obj.POINT2);
%             P_half_tip = 0.5*(obj.POINT3+obj.POINT4);
%             obj.P_q(1,:) = drop_point(obj.POINT5, obj.POINT6, P_half_root);
%             obj.P_q(n+1,:) = drop_point(obj.POINT5, obj.POINT6, P_half_tip);
%             for ii = 2:n
%                 obj.P_q(ii,:) = obj.P_q(1,:) + (ii-1)*(obj.P_q(n+1,:)-obj.P_q(1,:))/n;
%             end
%             obj.P_q(1,:) = two_line_cross(obj.POINT1, obj.POINT2, obj.POINT5, obj.POINT6);
%             obj.P_q(n+1,:) = two_line_cross(obj.POINT3, obj.POINT4, obj.POINT5, obj.POINT6);
%             obj.P_tail(1,:) = obj.POINT2;
%             obj.P_tail(n+1,:) = obj.POINT4;
%             for ii = 2:n
%                 obj.P_tail(ii,:) = ...
%                     vertical_cross_point(obj.POINT5, obj.POINT6, obj.P_q(ii,:), obj.POINT2, obj.POINT4);
%             end
%             for ii = 1:n+1
%                 obj.P_lead(ii,:) = two_line_cross(obj.P_q(ii,:), obj.P_tail(ii,:), obj.POINT1, obj.POINT3);
%                 obj.P_f(ii,:) = two_line_cross(obj.P_q(ii,:), obj.P_tail(ii,:), obj.Pf_root, obj.Pf_tip);
%                 obj.P_r(ii,:) = two_line_cross(obj.P_q(ii,:), obj.P_tail(ii,:), obj.Pr_root, obj.Pr_tip);
%                 for jj = 1:obj.ns
%                     obj.P_s{ii,jj} = two_line_cross(obj.P_lead(ii,:), obj.P_tail(ii,:), obj.Ps_root(jj,:), obj.Ps_tip(jj,:));
%                 end
%             end  
%         end
%         %% 根据某点位置，以及根部梢部翼型，求某点处的厚度
%         function y = thick_somepoint(obj, P, airfoil)
%             C_root = norm(obj.POINT2_bar - obj.POINT1_bar);
%             C_tip = norm(obj.POINT4_bar - obj.POINT3_bar);
%             % d = norm(cross(Q2-Q1,P-Q1))/norm(Q2-Q1);点到直线距离
%             distance_r = norm(cross([obj.POINT2_bar,0]-[obj.POINT1_bar,0],[P,0]-[obj.POINT1_bar,0]))/norm([obj.POINT2_bar,0]-[obj.POINT1_bar,0]);
%             distance_t = norm(cross([obj.POINT4_bar,0]-[obj.POINT3_bar,0],[P,0]-[obj.POINT3_bar,0]))/norm([obj.POINT4_bar,0]-[obj.POINT3_bar,0]);
%             C_len = (C_root*distance_t + C_tip*distance_r) / (distance_t + distance_r);% 该点处的弦长
%             P_drop_q = drop_point(obj.POINT5, obj.POINT6, P);% 该点在1/4弦处的投影点
%             P_drop_lead = two_line_cross(obj.POINT1, obj.POINT3, P, P_drop_q);% 该点在前缘处的投影点
%             P_drop_tail = two_line_cross(obj.POINT2, obj.POINT4, P, P_drop_q);% 该点在后缘处的投影点
%             C_pos = norm(P-P_drop_lead)/norm(P_drop_tail-P_drop_lead);% 弦向相对位置
%             y = (airfoil(obj.air_root_num).get_thick(C_pos) * distance_t +...
%                 airfoil(obj.air_tip_num).get_thick(C_pos) * distance_r)/...
%                 (distance_r+distance_t);
%             y = y * C_len;
%         end
%         %% calculate thickness
%         function obj = cal_thick(obj, airfoil)
%             for ii=1:obj.n+1
%                 % 前梁位置
%                 obj.T_f(ii) = thick_somepoint(obj, obj.P_f(ii,:), airfoil);
%                 % 后梁位置
%                 obj.T_r(ii) = thick_somepoint(obj, obj.P_r(ii,:), airfoil);
%                 % 长桁位置
%                 for jj = 1:obj.ns
%                     obj.T_s(ii,jj) = thick_somepoint(obj, obj.P_s{ii,jj}, airfoil);
%                 end
%             end
%         end
%         
%         %% 手动输入结构控制点
%         function obj=input_edge_point(obj, Pf_root,Pr_root,Ps_root, Pf_tip,Pr_tip,Ps_tip)
%             obj.Pf_root = Pf_root;
%             obj.Pr_root = Pr_root;
%             obj.Ps_root = Ps_root;
%             obj.Pf_tip = Pf_tip;
%             obj.Pr_tip = Pr_tip;
%             obj.Ps_tip = Ps_tip;
%             obj.ns = length(Ps_root(:,1));
%         end
%         %% 插值分割
%         function obj = cut_interp(obj,n)
%             obj.n = n;
%             for ii = 1:n+1
%                 obj.P_lead(ii,:) = obj.POINT1 + (ii-1)*(obj.POINT3-obj.POINT1)/n;
%                 obj.P_tail(ii,:) = obj.POINT2 + (ii-1)*(obj.POINT4-obj.POINT2)/n;
%                 obj.P_f(ii,:) = obj.Pf_root + (ii-1)*(obj.Pf_tip-obj.Pf_root)/n;
%                 obj.P_r(ii,:) = obj.Pr_root + (ii-1)*(obj.Pr_tip-obj.Pr_root)/n;
%                 obj.P_q(ii,:) = obj.POINT5 + (ii-1)*(obj.POINT6-obj.POINT5)/n;
%                 for jj = 1:obj.ns
%                     obj.P_s{ii,jj} = obj.Ps_root(jj,:) + (ii-1)*(obj.Ps_tip(jj,:)-obj.Ps_root(jj,:))/n;
%                 end
%             end
%         end
%         %% 厚度插值
%         function obj = thick_interp(obj, T_f_root,T_r_root, T_s_root, T_f_tip,T_r_tip, T_s_tip) 
%             nn = obj.n;
%             for ii = 1:nn+1
%                 obj.T_f(ii) = T_f_root + (ii-1)*(T_f_tip-T_f_root)/nn;
%                 obj.T_r(ii) = T_r_root + (ii-1)*(T_r_tip-T_r_root)/nn;
%                 for jj = 1:obj.ns
%                     obj.T_s(ii,jj) = T_s_root(jj) + (ii-1)*(T_s_tip(jj)-T_s_root(jj))/nn;
%                 end
%             end
%         end
%         %% connect 2 wingParts
%         function obj = connect_part_th(obj, part1, part2,n)
%             obj.POINT1 = part1.POINT3;
%             obj.POINT2 = part1.POINT4;
%             obj.POINT5 = part1.POINT6;
%             obj.POINT3 = part2.POINT1;
%             obj.POINT4 = part2.POINT2;
%             obj.POINT6 = part2.POINT5;
%             obj.POINT1_bar = obj.POINT1;
%             obj.POINT2_bar = obj.POINT2;
%             obj.POINT5_bar = obj.POINT5;
%             obj.POINT3_bar = obj.POINT3;
%             obj.POINT4_bar = obj.POINT4;
%             obj.POINT6_bar = obj.POINT6; 
%             obj.ns = size(part1.P_s,2);
%             %
%             obj.Pf_root = part1.P_f(end,:);
%             obj.Pr_root = part1.P_r(end,:);
%             for jj = 1:obj.ns
%                 obj.Ps_root(jj,:) = part1.P_s{end,jj};
%             end  
%             obj.Pf_tip = part2.P_f(1,:);
%             obj.Pr_tip = part2.P_r(1,:);
%             for jj = 1:obj.ns
%                 obj.Ps_tip(jj,:) = part2.P_s{1,jj};
%             end
%             %
%             obj = obj.cut_interp(n);
%             T_f_root = part1.T_f(end);
%             T_r_root = part1.T_r(end);
%             T_s_root = part1.T_s(end,:);
%             T_f_tip = part2.T_f(1);
%             T_r_tip = part2.T_r(1);
%             T_s_tip = part2.T_s(1,:);
%             obj = obj.thick_interp(T_f_root,T_r_root, T_s_root, T_f_tip,T_r_tip, T_s_tip);  
%         end
%         %
%         function obj = connect_part_hh(obj, part1, part2,n)
%             obj.POINT1 = part1.POINT1;
%             obj.POINT2 = part1.POINT2;
%             obj.POINT5 = part1.POINT5;
%             obj.POINT3 = part2.POINT1;
%             obj.POINT4 = part2.POINT2;
%             obj.POINT6 = part2.POINT5;
%             obj.POINT1_bar = obj.POINT1;
%             obj.POINT2_bar = obj.POINT2;
%             obj.POINT5_bar = obj.POINT5;
%             obj.POINT3_bar = obj.POINT3;
%             obj.POINT4_bar = obj.POINT4;
%             obj.POINT6_bar = obj.POINT6;
%             obj.ns = size(part1.P_s,2);
%             %
%             obj.Pf_root = part1.P_f(1,:);
%             obj.Pr_root = part1.P_r(1,:);
%             for jj = 1:obj.ns
%                 obj.Ps_root(jj,:) = part1.P_s{1,jj};
%             end  
%             obj.Pf_tip = part2.P_f(1,:);
%             obj.Pr_tip = part2.P_r(1,:);
%             for jj = 1:obj.ns
%                 obj.Ps_tip(jj,:) = part2.P_s{1,jj};
%             end
%             %
%             obj = obj.cut_interp(n);
%             T_f_root = part1.T_f(1);
%             T_r_root = part1.T_r(1);
%             T_s_root = part1.T_s(1,:);
%             T_f_tip = part2.T_f(1);
%             T_r_tip = part2.T_r(1);
%             T_s_tip = part2.T_s(1,:);
%             obj = obj.thick_interp(T_f_root,T_r_root, T_s_root, T_f_tip,T_r_tip, T_s_tip);  
%         end
%         %% cut wing_part into wing_box
%         function [wing_box,WING_BOX_count]= cut_into_box(obj, wing_box,WING_BOX_count, region,nb,nc, V)
%             % wing_box, WING_BOX_count
%             for ii = 1:obj.n
%                 if obj.direction=='z'
%                     POINT1_lead = [obj.P_lead(ii,:), obj.height + abs(obj.P_lead(ii,2))*tan(obj.up_angle)];
%                     POINT1_tail = [obj.P_tail(ii,:), obj.height + abs(obj.P_tail(ii,2))*tan(obj.up_angle)];
%                     POINT3_lead = [obj.P_lead(ii+1,:), obj.height + abs(obj.P_lead(ii+1,2))*tan(obj.up_angle)];
%                     POINT3_tail = [obj.P_tail(ii+1,:), obj.height + abs(obj.P_tail(ii+1,2))*tan(obj.up_angle)];
%                     POINT1_f = [obj.P_f(ii,:), 0.5*obj.T_f(ii) + obj.height + abs(obj.P_f(ii,2))*tan(obj.up_angle)];
%                     POINT2_f = [obj.P_f(ii,:), -0.5*obj.T_f(ii) + obj.height + abs(obj.P_f(ii,2))*tan(obj.up_angle)];
%                     POINT3_f = [obj.P_f(ii+1,:), 0.5*obj.T_f(ii+1) + obj.height + abs(obj.P_f(ii+1,2))*tan(obj.up_angle)];
%                     POINT4_f = [obj.P_f(ii+1,:), -0.5*obj.T_f(ii+1) + obj.height + abs(obj.P_f(ii+1,2))*tan(obj.up_angle)];
%                     POINT1_r = [obj.P_r(ii,:), 0.5*obj.T_r(ii) + obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle)];
%                     POINT2_r = [obj.P_r(ii,:), -0.5*obj.T_r(ii) + obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle)];
%                     POINT3_r = [obj.P_r(ii+1,:), 0.5*obj.T_r(ii+1) + obj.height + abs(obj.P_r(ii+1,2))*tan(obj.up_angle)];
%                     POINT4_r = [obj.P_r(ii+1,:), -0.5*obj.T_r(ii+1) + obj.height + abs(obj.P_r(ii+1,2))*tan(obj.up_angle)];
%                     for jj = 1:obj.ns
%                         P1 = obj.P_s{ii,jj};
%                         P3 = obj.P_s{ii+1,jj};
%                         POINT1_s(jj,:) = [P1, 0.5*obj.T_s(ii,jj) + obj.height + abs(P1(2))*tan(obj.up_angle)];
%                         POINT2_s(jj,:) = [P1, -0.5*obj.T_s(ii,jj) + obj.height + abs(P1(2))*tan(obj.up_angle)];
%                         POINT3_s(jj,:) = [P3, 0.5*obj.T_s(ii+1,jj) + obj.height + abs(P3(2))*tan(obj.up_angle)];
%                         POINT4_s(jj,:) = [P3, -0.5*obj.T_s(ii+1,jj) + obj.height + abs(P3(2))*tan(obj.up_angle)];
%                     end 
%                 else
%                     POINT1_lead = [obj.P_lead(ii,1), 0, obj.P_lead(ii,2)];
%                     POINT1_tail = [obj.P_tail(ii,1), 0, obj.P_tail(ii,2)];
%                     POINT3_lead = [obj.P_lead(ii+1,1), 0, obj.P_lead(ii+1,2)];
%                     POINT3_tail = [obj.P_tail(ii+1,1), 0, obj.P_tail(ii+1,2)];
%                     POINT1_f = [obj.P_f(ii,1), 0.5*obj.T_f(ii), obj.P_f(ii,2)];
%                     POINT2_f = [obj.P_f(ii,1), -0.5*obj.T_f(ii), obj.P_f(ii,2)];
%                     POINT3_f = [obj.P_f(ii+1,1), 0.5*obj.T_f(ii+1), obj.P_f(ii+1,2)];
%                     POINT4_f = [obj.P_f(ii+1,1), -0.5*obj.T_f(ii+1), obj.P_f(ii+1,2)];
%                     POINT1_r = [obj.P_r(ii,1), 0.5*obj.T_r(ii), obj.P_r(ii,2)];
%                     POINT2_r = [obj.P_r(ii,1), -0.5*obj.T_r(ii), obj.P_r(ii,2)];
%                     POINT3_r = [obj.P_r(ii+1,1), 0.5*obj.T_r(ii+1), obj.P_r(ii+1,2)];
%                     POINT4_r = [obj.P_r(ii+1,1), -0.5*obj.T_r(ii+1), obj.P_r(ii+1,2)];
%                     for jj = 1:obj.ns
%                         P1 = obj.P_s{ii,jj};
%                         P3 = obj.P_s{ii+1,jj};
%                         POINT1_s(jj,:) = [P1(1), 0.5*obj.T_s(ii,jj), P1(2)];
%                         POINT2_s(jj,:) = [P1(1), -0.5*obj.T_s(ii,jj), P1(2)];
%                         POINT3_s(jj,:) = [P3(1), 0.5*obj.T_s(ii+1,jj), P3(2)];
%                         POINT4_s(jj,:) = [P3(1), -0.5*obj.T_s(ii+1,jj), P3(2)];
%                     end
%                 end   
%                 WING_BOX_count = WING_BOX_count+1;
%                 wing_box(WING_BOX_count) = WING_BOX(region,nb,nc);
%                 wing_box(WING_BOX_count).V = V;
%                 wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_lead_tail(POINT1_lead, POINT1_tail, POINT3_lead, POINT3_tail);
%                 wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_f(POINT1_f, POINT2_f, POINT3_f, POINT4_f);
%                 wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_r(POINT1_r, POINT2_r, POINT3_r, POINT4_r);
%                 wing_box(WING_BOX_count) = wing_box(WING_BOX_count).get_POINT_s(POINT1_s, POINT2_s, POINT3_s, POINT4_s);
%             end
%         end
%         %%  plot
%         function plot_shape(obj)
%             if obj.direction=='z'
%                 linewidth = 2;
%                 plot([obj.POINT1(1),obj.POINT2(1)], [obj.POINT1(2),obj.POINT2(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT1(1),obj.POINT3(1)], [obj.POINT1(2),obj.POINT3(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT2(1),obj.POINT4(1)], [obj.POINT2(2),obj.POINT4(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT3(1),obj.POINT4(1)], [obj.POINT3(2),obj.POINT4(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT5(1),obj.POINT6(1)], [obj.POINT5(2),obj.POINT6(2)], 'b--o', 'linewidth', linewidth); hold on;
%                 linewidth = 1;
%                 plot([obj.POINT1_bar(1),obj.POINT2_bar(1)], [obj.POINT1_bar(2),obj.POINT2_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT1_bar(1),obj.POINT3_bar(1)], [obj.POINT1_bar(2),obj.POINT3_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT2_bar(1),obj.POINT4_bar(1)], [obj.POINT2_bar(2),obj.POINT4_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT3_bar(1),obj.POINT4_bar(1)], [obj.POINT3_bar(2),obj.POINT4_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot([obj.POINT5_bar(1),obj.POINT6_bar(1)], [obj.POINT5_bar(2),obj.POINT6_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%             else
%                 linewidth = 2;
%                 plot3([obj.POINT1(1),obj.POINT2(1)], [0,0], [obj.POINT1(2),obj.POINT2(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT1(1),obj.POINT3(1)], [0,0], [obj.POINT1(2),obj.POINT3(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT2(1),obj.POINT4(1)], [0,0], [obj.POINT2(2),obj.POINT4(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT3(1),obj.POINT4(1)], [0,0], [obj.POINT3(2),obj.POINT4(2)], 'b-o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT5(1),obj.POINT6(1)], [0,0], [obj.POINT5(2),obj.POINT6(2)], 'b--o', 'linewidth', linewidth); hold on;
%                 linewidth = 1;
%                 plot3([obj.POINT1_bar(1),obj.POINT2_bar(1)], [0,0], [obj.POINT1_bar(2),obj.POINT2_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT1_bar(1),obj.POINT3_bar(1)], [0,0], [obj.POINT1_bar(2),obj.POINT3_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT2_bar(1),obj.POINT4_bar(1)], [0,0], [obj.POINT2_bar(2),obj.POINT4_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT3_bar(1),obj.POINT4_bar(1)], [0,0], [obj.POINT3_bar(2),obj.POINT4_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%                 plot3([obj.POINT5_bar(1),obj.POINT6_bar(1)], [0,0], [obj.POINT5_bar(2),obj.POINT6_bar(2)], 'r--o', 'linewidth', linewidth); hold on;
%             end
%         end
%         function plot_STRpoint(obj)
%             if obj.direction=='z'
%                 linewidth = 1;
%                 plot([obj.Pf_root(1),obj.Pf_tip(1)], [obj.Pf_root(2),obj.Pf_tip(2)], 'g--*', 'linewidth', linewidth); hold on;
%                 plot([obj.Pr_root(1),obj.Pr_tip(1)], [obj.Pr_root(2),obj.Pr_tip(2)], 'g--*', 'linewidth', linewidth); hold on;
%                 for ii  = 1:obj.ns
%                     plot([obj.Ps_root(ii,1),obj.Ps_tip(ii,1)], [obj.Ps_root(ii,2),obj.Ps_tip(ii,2)], 'g--*', 'linewidth', linewidth); hold on;
%                 end
%                 linewidth = 2;
%                 plot([obj.P_f(1,1),obj.P_f(end,1)], [obj.P_f(1,2),obj.P_f(end,2)], 'g-*', 'linewidth', linewidth); hold on;
%                 plot([obj.P_r(1,1),obj.P_r(end,1)], [obj.P_r(1,2),obj.P_r(end,2)], 'g-*', 'linewidth', linewidth); hold on;
%                 for jj  = 1:obj.ns
%                     P1 = obj. P_s{1,jj};
%                     P2 = obj.P_s{end,jj};
%                     plot([P1(1),P2(1)], [P1(2),P2(2)], 'g-*', 'linewidth', linewidth); hold on;
%                 end
%             else
%                 linewidth = 1;
%                 plot3([obj.Pf_root(1),obj.Pf_tip(1)], [0,0], [obj.Pf_root(2),obj.Pf_tip(2)], 'g--*', 'linewidth', linewidth); hold on;
%                 plot3([obj.Pr_root(1),obj.Pr_tip(1)], [0,0], [obj.Pr_root(2),obj.Pr_tip(2)], 'g--*', 'linewidth', linewidth); hold on;
%                 for ii  = 1:obj.ns
%                     plot3([obj.Ps_root(ii,1),obj.Ps_tip(ii,1)], [0,0], [obj.Ps_root(ii,2),obj.Ps_tip(ii,2)], 'g--*', 'linewidth', linewidth); hold on;
%                 end
%                 linewidth = 2;
%                 plot3([obj.P_f(1,1),obj.P_f(end,1)], [0,0], [obj.P_f(1,2),obj.P_f(end,2)], 'g-*', 'linewidth', linewidth); hold on;
%                 plot3([obj.P_r(1,1),obj.P_r(end,1)], [0,0], [obj.P_r(1,2),obj.P_r(end,2)], 'g-*', 'linewidth', linewidth); hold on;
%                 for jj  = 1:obj.ns
%                     P1 = obj. P_s{1,jj};
%                     P2 = obj.P_s{end,jj};
%                     plot3([P1(1),P2(1)], [0,0], [P1(2),P2(2)], 'g-*', 'linewidth', linewidth); hold on;
%                 end  
%             end
%         end
%         function plot_block_point(obj)
%             if obj.direction=='z'
%                 for ii  = 1:obj.n+1
%                     plot(obj.P_lead(ii,1), obj.P_lead(ii,2), '*k'); hold on;
%                     plot(obj.P_tail(ii,1), obj.P_tail(ii,2), '*k'); hold on;
%                     plot(obj.P_f(ii,1), obj.P_f(ii,2), '*k'); hold on;
%                     plot(obj.P_r(ii,1), obj.P_r(ii,2), '*k'); hold on;
%                     plot(obj.P_q(ii,1), obj.P_q(ii,2), '*k'); hold on;
%                     for jj = 1:1:obj.ns
%                         P = obj.P_s{ii,jj};
%                         plot(P(1), P(2), '*k'); hold on;
%                     end
%                 end
%             else
%                 for ii  = 1:obj.n+1
%                     plot3(obj.P_lead(ii,1), 0, obj.P_lead(ii,2),  '*k'); hold on;
%                     plot3(obj.P_tail(ii,1), 0, obj.P_tail(ii,2),  '*k'); hold on;
%                     plot3(obj.P_f(ii,1), 0, obj.P_f(ii,2),  '*k'); hold on;
%                     plot3(obj.P_r(ii,1), 0, obj.P_r(ii,2),  '*k'); hold on;
%                     plot3(obj.P_q(ii,1), 0, obj.P_q(ii,2),  '*k'); hold on;
%                     for jj = 1:1:obj.ns
%                         P = obj.P_s{ii,jj};
%                         plot3(P(1), 0, P(2),  '*k'); hold on;
%                     end
%                 end
%             end
%         end
%         function plot_STRpoint_xyz(obj)
%             for ii  = 1:obj.n+1
%                 if obj.direction=='z'
%                     Pup = [obj.P_f(ii,:), obj.height + abs(obj.P_f(ii,2))*tan(obj.up_angle) + 0.5*obj.T_f(ii)];
%                     Pdown = [obj.P_f(ii,:), obj.height + abs(obj.P_f(ii,2))*tan(obj.up_angle) - 0.5*obj.T_f(ii)];
%                 else
%                     Pup = [obj.P_f(ii,1), 0, obj.P_f(ii,2)];
%                     Pdown = [obj.P_f(ii,1), 0, obj.P_f(ii,2)];
%                 end
%                 plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
%                 plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
%                 %
%                 if obj.direction=='z'
%                     Pup = [obj.P_r(ii,:), obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle) + 0.5*obj.T_r(ii)];
%                     Pdown = [obj.P_r(ii,:), obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle) - 0.5*obj.T_r(ii)];
%                 else
%                     Pup = [obj.P_r(ii,1), obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle) + 0.5*obj.T_r(ii), obj.P_r(ii,2)];
%                     Pdown = [obj.P_r(ii,1), obj.height + abs(obj.P_r(ii,2))*tan(obj.up_angle) - 0.5*obj.T_r(ii), obj.P_r(ii,2)];
%                 end
%                 plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
%                 plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
%                 %
%                 for jj = 1:obj.ns
%                     P = obj.P_s{ii,jj};
%                     if obj.direction=='z'
%                         Pup = [P, obj.height + abs(P(2))*tan(obj.up_angle) + 0.5*obj.T_s(ii,jj)];
%                         Pdown = [P, obj.height + abs(P(2))*tan(obj.up_angle) - 0.5*obj.T_s(ii,jj)];
%                     else
%                         Pup = [P(1), 0, P(2)];
%                         Pdown = [P(1), 0, P(2)];
%                     end
%                     plot3(Pup(1), Pup(2), Pup(3), '*k'); hold on;
%                     plot3(Pdown(1), Pdown(2), Pdown(3), '*k'); hold on;
%                 end
%             end
%         end
%         %% create vers_y part
%         function obj1 = vers_y(obj)
%             obj1 = obj;
%             obj1.POINT1 = vers_y(obj1.POINT1);
%             obj1.POINT2 = vers_y(obj1.POINT2);
%             obj1.POINT3 = vers_y(obj1.POINT3);
%             obj1.POINT4 = vers_y(obj1.POINT4);
%             obj1.POINT5 = vers_y(obj1.POINT5);
%             obj1.POINT6 = vers_y(obj1.POINT6);
%             %
%             obj1.POINT1_bar = vers_y(obj1.POINT1_bar);
%             obj1.POINT2_bar = vers_y(obj1.POINT2_bar);
%             obj1.POINT3_bar = vers_y(obj1.POINT3_bar);
%             obj1.POINT4_bar = vers_y(obj1.POINT4_bar);
%             obj1.POINT5_bar = vers_y(obj1.POINT5_bar);
%             obj1.POINT6_bar = vers_y(obj1.POINT6_bar);
%             %
%             obj1.Pf_root = vers_y(obj1.Pf_root);
%             obj1.Pr_root = vers_y(obj1.Pr_root);
%             obj1.Ps_root = vers_y(obj1.Ps_root);
%             obj1.Pf_tip = vers_y(obj1.Pf_tip);
%             obj1.Pr_tip = vers_y(obj1.Pr_tip);
%             obj1.Ps_tip = vers_y(obj1.Ps_tip);
%             %
%             obj1.P_lead = vers_y(obj1.P_lead);
%             obj1.P_tail = vers_y(obj1.P_tail);
%             obj1.P_q = vers_y(obj1.P_q);
%             obj1.P_f = vers_y(obj1.P_f);
%             obj1.P_r = vers_y(obj1.P_r);
%             for ii = 1:obj1.n+1
%                 for jj = 1:obj1.ns
%                     obj1.P_s{ii,jj} = vers_y(obj1.P_s{ii,jj});
%                 end
%             end
%         end
%     end
%     
% end

