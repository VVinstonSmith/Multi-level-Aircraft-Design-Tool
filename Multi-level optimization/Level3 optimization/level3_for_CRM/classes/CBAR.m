classdef CBAR
    %UNTITLED30 此处显示有关此类的摘要
    %   此处显示详细说明
   
    properties
        id;
        pid;
        p_num;
        region;
        sub_region;
        
        GRID1_num;
        GRID2_num;
        GRID1_id;
        GRID2_id;
        V;
    end
    
    methods
        function obj = CBAR(id, p_num, region, V, grids, GRID1_num, GRID2_num)
            obj.id = id;
            obj.p_num = p_num;
            obj.region = region;
            obj.V = V;
            obj.GRID1_num = GRID1_num;
            obj.GRID1_id = grids(GRID1_num).id;
            obj.GRID2_num = GRID2_num;
            obj.GRID2_id = grids(GRID2_num).id;
        end        
        
        function [m, X] = mass_center(obj,grids,pbar,mat)
            A = pbar(obj.p_num).A; 
            rho = mat(pbar(obj.p_num).M_num).RHO;
            P1 = grids(obj.GRID1_num).loc;
            P2 = grids(obj.GRID2_num).loc;
            m = A*rho*norm(P1-P2);
            X = 0.5*(P1+P2);
        end
        
        function plot(obj, grids, color, linewidth)
            P1 = grids(obj.GRID1_num).loc;
            P2 = grids(obj.GRID2_num).loc;
            plot3_line(P1,P2, color, linewidth);
        end
            
    end
    
end

