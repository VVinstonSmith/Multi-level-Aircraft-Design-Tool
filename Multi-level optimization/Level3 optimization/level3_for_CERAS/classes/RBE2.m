classdef RBE2
    %UNTITLED32 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        id;
        GN_id;% 独立自由度结点的编号，6个自由度都独立
        GN_num;
        GM_id;% 自由度非独立的结点编号
        GM_num;
        
        CM;% 非独立的自由度
    end
    
    methods
        function obj = RBE2(id, GN_id, GN_num, GM_id, GM_num, CM)
            obj.id = id;
            obj.GN_id = GN_id;
            obj.GN_num = GN_num;
            obj.GM_id = GM_id;
            obj.GM_num = GM_num;
            obj.CM = CM;
        end
        function plot(obj, grids, color,linewidth)
            for ii = 1:length(obj.GM_num)
                P1 = grids(obj.GN_num).loc;
                P2 = grids(obj.GM_num(ii)).loc;
                plot3_line(P1,P2, color, linewidth);
            end
        end
            
    end
    
end

