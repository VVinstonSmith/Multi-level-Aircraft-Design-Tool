classdef CBAR_area
    %相同单元属性的多单元区域(杆)
    
    properties
        GRID1_loc;
        GRID2_loc;
        GRIDi_num; % n+1
        PBAR_num;% 1
        CBAR_num;% n
        V;% pbar矢量
    end
    
    methods
        function obj = CBAR_area(GRID1_loc, GRID2_loc, PBAR_num)
            obj.GRID1_loc = GRID1_loc;
            obj.GRID2_loc = GRID2_loc;
            obj.PBAR_num = PBAR_num;
        end 
        %%
        function [obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] = create_CBAR(obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, n, region)
            % cbar, CBAR_count, CBAR_id
            % grids, GRID_count, GRID_id
            for ii = 1:n+1
                grid_loc = obj.GRID1_loc + (ii-1)*(obj.GRID2_loc - obj.GRID1_loc)/n;
                GRID_count = GRID_count + 1;
                GRID_id = GRID_id + 1;
                obj.GRIDi_num(ii) = GRID_count;
                grids(GRID_count) = GRID(GRID_id, region, grid_loc);
            end   
            for ii = 1:n
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id + 1;
                obj.CBAR_num(ii) = CBAR_count;
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, region, obj.V,...
                    grids, obj.GRIDi_num(ii), obj.GRIDi_num(ii+1));
            end
        end
        %%
        function y = plot_cbar(obj, grids, color, linewidth)
            y = length(obj.GRIDi_num)-1;
            for ii = 1:y
                P1 = grids(obj.GRIDi_num(ii)).loc;
                P2 = grids(obj.GRIDi_num(ii+1)).loc;
                plot3_line(P1, P2, color, linewidth);
            end
        end                 
        %%
        function y = NUM(obj)
            y = length(obj.CBAR_num);
        end
        %%
        function y = LEN(obj)
            y = norm(obj.GRID1_loc - obj.GRID2_loc);
        end   
    end
    
end

