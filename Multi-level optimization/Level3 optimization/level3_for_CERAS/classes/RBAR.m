classdef RBAR
    %UNTITLED31 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        id;
        GRID1_num;
        GRID2_num;
        GRID1_id;
        GRID2_id;
        CNA;
        CNB;
    end
    
    methods
        function obj = RBAR(GRID1_num, GRID2_num, id)
            obj.GRID1_num = GRID1_num;
            obj.GRID2_num = GRID2_num;
            obj.id = id;
        end
        function plot(obj, grids, color, linewidth)
            P1 = grids(obj.GRID1_num).loc;
            P2 = grids(obj.GRID2_num).loc;
            plot3_line(P1,P2, color, linewidth);
        end
    end
    
end

