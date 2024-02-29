classdef WING_AERO_BLOCK
    %UNTITLED17 此处显示有关此类的摘要
    %   此处显示详细说明
    properties
        id;
        region;
        sub_region;
        GRID_1;
        GRID_2;
        GRID_3;
        GRID_4; 
        aero_vector;
        axis_x;
        axis_y;
        axis_z;
    end
    
    methods
        function y = B(obj)% 展长
            if obj.aero_vector=='z'
                y = 0.5*(obj.GRID_3(2)+obj.GRID_4(2)) - 0.5*(obj.GRID_1(2)+obj.GRID_2(2));
            else
                y = 0.5*(obj.GRID_3(3)+obj.GRID_4(3)) - 0.5*(obj.GRID_1(3)+obj.GRID_2(3));
            end
            y = abs(y);
        end
        function y = C_root(obj)% 根弦长
            y = obj.GRID_2(1) - obj.GRID_1(1);
        end
        function y = C_tip(obj)% 梢弦长
            y = obj.GRID_4(1) - obj.GRID_3(1);
        end
        function y = S(obj)% 面积
            y = obj.B() * 0.5 * (obj.C_root()+obj.C_tip());
        end
        function y = up_angle(obj)% 上反角
            y = atan((obj.GRID_3(3)-obj.GRID_1(3)) / (obj.GRID_3(2)-obj.GRID_1(2)));
            y = abs(y);
        end
        function y = ka(obj)% 1/4后掠角
            GRID_q_root = obj.GRID_1 + 0.25*(obj.GRID_2-obj.GRID_1);
            GRID_q_tip = obj.GRID_3 + 0.25*(obj.GRID_4-obj.GRID_3);
            if obj.aero_vector=='z'
                y = atan(GRID_q_tip(1)-GRID_q_root(1))/(GRID_q_tip(2)-GRID_q_root(2));
            else
                y = atan(GRID_q_tip(1)-GRID_q_root(1))/(GRID_q_tip(3)-GRID_q_root(3));
            end
            y = abs(y); 
        end
        function y = C_A(obj)% 平均气动弦长
            y = (obj.B()/3)*(obj.C_tip()^2 + obj.C_tip()*obj.C_root() + obj.C_root()^2)/obj.S();  
        end
        function y = X_F(obj,x0)% 焦点
            x1 = obj.GRID_1(1) - x0;% x0:机翼前缘坐标
            x3 = obj.GRID_3(1) - x0;
            y = (obj.B()*(4*obj.C_root()*x1 + 2*obj.C_root()*x3 + 2*obj.C_tip()*x1 + 4*obj.C_tip()*x3 + obj.C_root()^2 + obj.C_tip()^2 + obj.C_root()*obj.C_tip()))/(12*obj.S());
        end
        function plot_block(obj, color, linewidth)
            plot3([obj.GRID_1(1),obj.GRID_2(1)], [obj.GRID_1(2),obj.GRID_2(2)], [obj.GRID_1(3),obj.GRID_2(3)], color, 'linewidth',linewidth);hold on;
            plot3([obj.GRID_1(1),obj.GRID_3(1)], [obj.GRID_1(2),obj.GRID_3(2)], [obj.GRID_1(3),obj.GRID_3(3)], color, 'linewidth',linewidth);hold on;
            plot3([obj.GRID_3(1),obj.GRID_4(1)], [obj.GRID_3(2),obj.GRID_4(2)], [obj.GRID_3(3),obj.GRID_4(3)], color, 'linewidth',linewidth);hold on;
            plot3([obj.GRID_2(1),obj.GRID_4(1)], [obj.GRID_2(2),obj.GRID_4(2)], [obj.GRID_2(3),obj.GRID_4(3)], color, 'linewidth',linewidth);hold on;
        end
        function plot_axis(obj, linewidth)
            k = 5;
            plot3([obj.GRID_3(1),obj.GRID_3(1)+k*obj.axis_x(1)], [obj.GRID_3(2),obj.GRID_3(2)+k*obj.axis_x(2)], [obj.GRID_3(3),obj.GRID_3(3)+k*obj.axis_x(3)],'r','linewidth',linewidth);hold on;
            plot3([obj.GRID_3(1),obj.GRID_3(1)+k*obj.axis_y(1)], [obj.GRID_3(2),obj.GRID_3(2)+k*obj.axis_y(2)], [obj.GRID_3(3),obj.GRID_3(3)+k*obj.axis_y(3)],'y','linewidth',linewidth);hold on;
            plot3([obj.GRID_3(1),obj.GRID_3(1)+k*obj.axis_z(1)], [obj.GRID_3(2),obj.GRID_3(2)+k*obj.axis_z(2)], [obj.GRID_3(3),obj.GRID_3(3)+k*obj.axis_z(3)],'g','linewidth',linewidth);hold on;
        end
            
    end
    
end
