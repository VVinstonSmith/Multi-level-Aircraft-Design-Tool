classdef RIB
    %UNTITLED11 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties 
        region;
        GRID_lead_num;
        GRID_tail_num;
        GRIDs_up_num;
        GRIDs_down_num;
        CBARs_num;
        PBAR_num;
        V;
        RBARs_num;
    end
    
    methods       
        function [obj, cbar,CBAR_count,CBAR_id] = create_CBAR(obj, grids, cbar,CBAR_count,CBAR_id)
            chord_vector = grids(obj.GRID_tail_num).loc - grids(obj.GRID_lead_num).loc;
            chord_vector = chord_vector / norm(chord_vector);
            V_xy = chord_vector + obj.V;
            % 前缘
            CBAR_count = CBAR_count+1;
            CBAR_id = CBAR_id+1;
            GRID1_num = obj.GRID_lead_num;
            GRID2_num = obj.GRIDs_up_num(1);
            cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                grids, GRID1_num,GRID2_num);
            obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            %
            CBAR_count = CBAR_count+1;
            CBAR_id = CBAR_id+1;
            GRID1_num = obj.GRID_lead_num;
            GRID2_num = obj.GRIDs_down_num(1);
            cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                grids, GRID1_num,GRID2_num);
            obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            % 后缘
            CBAR_count = CBAR_count+1;
            CBAR_id = CBAR_id+1;
            GRID1_num = obj.GRID_tail_num;
            GRID2_num = obj.GRIDs_up_num(end);
            cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                grids, GRID1_num,GRID2_num);
            obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            %
            CBAR_count = CBAR_count+1;
            CBAR_id = CBAR_id+1;
            GRID1_num = obj.GRID_tail_num;
            GRID2_num = obj.GRIDs_down_num(end);
            cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                grids, GRID1_num,GRID2_num);
            obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            %
            CBAR_count = CBAR_count+1;
            CBAR_id = CBAR_id+1;
            GRID1_num = obj.GRIDs_up_num(1);
            GRID2_num = obj.GRIDs_down_num(1);
            cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                grids, GRID1_num,GRID2_num);
            obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            for ii = 1:length(obj.GRIDs_up_num)-1
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id+1;
                GRID1_num = obj.GRIDs_up_num(ii);
                GRID2_num = obj.GRIDs_up_num(ii+1);
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                    grids, GRID1_num,GRID2_num);
                obj.CBARs_num = [obj.CBARs_num, CBAR_count];
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id+1;
                GRID1_num = obj.GRIDs_down_num(ii);
                GRID2_num = obj.GRIDs_down_num(ii+1);
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                    grids, GRID1_num,GRID2_num);
                obj.CBARs_num = [obj.CBARs_num, CBAR_count];
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id+1;
                GRID1_num = obj.GRIDs_up_num(ii+1);
                GRID2_num = obj.GRIDs_down_num(ii+1);
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                    grids, GRID1_num,GRID2_num);
                obj.CBARs_num = [obj.CBARs_num, CBAR_count];
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id+1;
                GRID1_num = obj.GRIDs_up_num(ii);
                GRID2_num = obj.GRIDs_down_num(ii+1);
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, obj.region, V_xy,...
                    grids, GRID1_num,GRID2_num);
                obj.CBARs_num = [obj.CBARs_num, CBAR_count];
            end
        end
        
%         function [obj, rbar, RBAR_count, RBAR_id] = create_RBAR(obj, rbar, RBAR_count, RBAR_id)
%             % 前缘
%             RBAR_count = RBAR_count+1;
%             RBAR_id = RBAR_id+1;
%             rbar(RBAR_count) = RBAR(obj.GRID_lead_num, obj.GRIDs_up_num(1), RBAR_id);
%             obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             %
%             RBAR_count = RBAR_count+1;
%             RBAR_id = RBAR_id+1;
%             rbar(RBAR_count) = RBAR(obj.GRID_lead_num, obj.GRIDs_down_num(1), RBAR_id);
%             obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             % 后缘
%             RBAR_count = RBAR_count+1;
%             RBAR_id = RBAR_id+1;
%             rbar(RBAR_count) = RBAR(obj.GRID_tail_num, obj.GRIDs_up_num(end), RBAR_id);
%             obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             %
%             RBAR_count = RBAR_count+1;
%             RBAR_id = RBAR_id+1;
%             rbar(RBAR_count) = RBAR(obj.GRID_tail_num, obj.GRIDs_down_num(end), RBAR_id);
%             obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             %
%             RBAR_count = RBAR_count+1;
%             RBAR_id = RBAR_id+1;
%             rbar(RBAR_count) = RBAR(obj.GRIDs_up_num(1), obj.GRIDs_down_num(1), RBAR_id);
%             obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             for ii = 1:length(obj.GRIDs_up_num)-1
%                 RBAR_count = RBAR_count+1;
%                 RBAR_id = RBAR_id+1;
%                 rbar(RBAR_count) = RBAR(obj.GRIDs_up_num(ii), obj.GRIDs_up_num(ii+1), RBAR_id);
%                 obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%                 %
%                 RBAR_count = RBAR_count+1;
%                 RBAR_id = RBAR_id+1;
%                 rbar(RBAR_count) = RBAR(obj.GRIDs_down_num(ii), obj.GRIDs_down_num(ii+1), RBAR_id);
%                 obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%                 %
%                 RBAR_count = RBAR_count+1;
%                 RBAR_id = RBAR_id+1;
%                 rbar(RBAR_count) = RBAR(obj.GRIDs_up_num(ii+1), obj.GRIDs_down_num(ii+1), RBAR_id);
%                 obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%                 %
%                 RBAR_count = RBAR_count+1;
%                 RBAR_id = RBAR_id+1;
%                 rbar(RBAR_count) = RBAR(obj.GRIDs_up_num(ii), obj.GRIDs_down_num(ii+1), RBAR_id);
%                 obj.RBARs_num = [obj.RBARs_num, RBAR_count];
%             end
%         end
%         
        function grid_close_num = seek_nearest_grid(obj, P, grids)
%             grid_close_num = obj.GRID_lead_num;
%             len_close = norm(grids(grid_close_num).loc - P);
%             if norm(grids(obj.GRID_tail_num).loc-P) < len_close
%                 grid_close_num = obj.GRID_tail_num;
%                 len_close = norm(grids(grid_close_num).loc - P);
%             end
            grid_close_num = obj.GRID_tail_num;
            len_close = norm(grids(grid_close_num).loc - P);
            for ii = 1:length(obj.GRIDs_up_num)
                len_temp = norm(grids(obj.GRIDs_up_num(ii)).loc - P);
                if len_temp < len_close
                    grid_close_num = obj.GRIDs_up_num(ii);
                    len_close = norm(grids(grid_close_num).loc - P);
                end
            end
            for ii = 1:length(obj.GRIDs_down_num)
                len_temp = norm(grids(obj.GRIDs_down_num(ii)).loc - P);
                if len_temp < len_close
                    grid_close_num = obj.GRIDs_down_num(ii);
                    len_close = norm(grids(grid_close_num).loc - P);
                end
            end
        end
%%
        function plot(obj,grids, cbar, color, linewidth)
            for ii = 1:length(obj.CBARs_num)
                cbar(obj.CBARs_num(ii)).plot(grids, color, linewidth);
            end
        end
    end
    
end

