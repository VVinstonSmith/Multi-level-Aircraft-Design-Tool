classdef WING_STR_BLOCK
    %UNTITLED15 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
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

