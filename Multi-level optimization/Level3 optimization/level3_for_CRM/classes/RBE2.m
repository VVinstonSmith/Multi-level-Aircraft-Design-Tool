classdef RBE2
    %UNTITLED32 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        id;
        GN_id;% �������ɶȽ��ı�ţ�6�����ɶȶ�����
        GN_num;
        GM_id;% ���ɶȷǶ����Ľ����
        GM_num;
        
        CM;% �Ƕ��������ɶ�
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

