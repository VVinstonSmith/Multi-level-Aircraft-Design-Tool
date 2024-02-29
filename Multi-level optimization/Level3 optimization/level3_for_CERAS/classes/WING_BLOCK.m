classdef WING_STR_BLOCK
    %UNTITLED15 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        GRID_u_1;
        GRID_u_2;
        GRID_u_3;
        GRID_u_4;
        GRID_d_1;
        GRID_d_2;
        GRID_d_3;
        GRID_d_4;  
    end
    
    methods
        function y = center(obj)
            y = obj.GRID_u_1 + obj.GRID_u_2 + obj.GRID_u_3 + obj.GRID_u_4 +...
                obj.GRID_d_1 + obj.GRID_d_2 + obj.GRID_d_3 + obj.GRID_d_4;
            y = y/8;
        end
        function y = grid1(obj)
            y = obj.GRID_u_1;
        end
        
    end
    
end

