classdef CQUAD_area
    %UNTITLED3 此处显示有关此类的摘要
    properties
        GRID1_loc;
        GRID2_loc;
        GRID3_loc;
        GRID4_loc;
        m;% 弦向块数
        n;% 展向块数
        PSHELL_num;% 1
        CQUAD_num;% m*n 
        GRIDij_num; %(m+1)*(n+1)
    end
    
    methods
        function obj = CQUAD_area(GRID1_loc,GRID2_loc,GRID3_loc,GRID4_loc, PSHELL_num)
            obj.GRID1_loc = GRID1_loc;
            obj.GRID2_loc = GRID2_loc;
            obj.GRID3_loc = GRID3_loc;
            obj.GRID4_loc = GRID4_loc;
            obj.PSHELL_num = PSHELL_num;
        end 
        %%
        function [obj, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] = create_CQUAD(obj, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, m, CBAR_area1, CBAR_area2, region)
            % cquad, CQUAD_count, CQUAD_id
            % grids, GRID_count, GRID_id
            GRID1_num = CBAR_area1.GRIDi_num;% 前边界的点列
            GRID2_num = CBAR_area2.GRIDi_num;% 后边界的点列
            obj.n = length(GRID1_num)-1;
            obj.m = m;
            % GRIDij_num
            obj.GRIDij_num = zeros(obj.m+1, obj.n+1);
            obj.GRIDij_num(1,:) = GRID1_num;
            obj.GRIDij_num(obj.m+1,:) = GRID2_num;
            for ii = 1:obj.m-1
                GRID1_inter = obj.GRID1_loc + ii*(obj.GRID2_loc-obj.GRID1_loc)/obj.m;
                GRID3_inter = obj.GRID3_loc + ii*(obj.GRID4_loc-obj.GRID3_loc)/obj.m;
                for jj = 1:obj.n+1                
                    grid_loc = GRID1_inter + (jj-1)*(GRID3_inter-GRID1_inter)/obj.n;
                    GRID_count = GRID_count + 1;
                    GRID_id = GRID_id + 1;
                    grids(GRID_count) = GRID(GRID_id, region, grid_loc);
                    obj.GRIDij_num(ii+1,jj) = GRID_count;
                end
            end
            % CQUAD_num
            for ii = 1:obj.m
                for jj = 1:obj.n
                    CQUAD_count = CQUAD_count+1;
                    CQUAD_id = CQUAD_id+1;
                    obj.CQUAD_num(ii,jj) = CQUAD_count;
                    cquad(CQUAD_count) = CQUAD(CQUAD_id, obj.PSHELL_num, obj.GRIDij_num(ii,jj), obj.GRIDij_num(ii,jj+1), obj.GRIDij_num(ii+1,jj+1),obj.GRIDij_num(ii+1,jj),  region);
                end
            end
        end
        %% plot
        function y = plot_quad(obj, grids, color, linewidth)
            y = obj.m * obj.n;
            for ii = 1:obj.m
                for jj = 1:obj.n
                    P1 = grids(obj.GRIDij_num(ii,jj)).loc;
                    P2 = grids(obj.GRIDij_num(ii+1,jj)).loc;
                    P3 = grids(obj.GRIDij_num(ii,jj+1)).loc;
                    P4 = grids(obj.GRIDij_num(ii+1,jj+1)).loc;
                    plot3_square(P1,P2,P3,P4, 1,1, color, linewidth);
                end
            end
        end
    end
end

