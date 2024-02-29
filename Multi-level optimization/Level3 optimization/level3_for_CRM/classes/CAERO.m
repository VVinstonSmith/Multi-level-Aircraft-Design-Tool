classdef CAERO
    %UNTITLED22 此处显示有关此类的摘要
    %   此处显示详细说明
    properties
        id;
        region;
        sub_region;
        pid;
        %
        P1; P2; P3; P4;
        m; n;
        SET_num; SET_id;
    end
    
    methods
        function y = L1(obj)
            y = obj.P2(1) - obj.P1(1);
        end
        function y = L3(obj)
            y = obj.P4(1) - obj.P3(1);
        end
        function y = plot_CAERO(obj, color, linewidth)
            y = obj.m * obj.n;
            for ii = 1:obj.n+1
                G1 = obj.P1 + (ii-1)*(obj.P3-obj.P1)/obj.n;
                G2 = obj.P2 + (ii-1)*(obj.P4-obj.P2)/obj.n;
                plot3([G1(1),G2(1)], [G1(2),G2(2)], [G1(3),G2(3)], color, 'linewidth', linewidth);
                hold on;
            end
            for ii = 1:obj.m+1
                G1 = obj.P1 + (ii-1)*(obj.P2-obj.P1)/obj.m;
                G3 = obj.P3 + (ii-1)*(obj.P4-obj.P3)/obj.m;
                plot3([G1(1),G3(1)], [G1(2),G3(2)], [G1(3),G3(3)], color, 'linewidth', linewidth);
            end
        end
    end
    
end
