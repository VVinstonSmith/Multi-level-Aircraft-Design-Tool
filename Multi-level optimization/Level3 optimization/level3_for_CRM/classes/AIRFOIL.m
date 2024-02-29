classdef AIRFOIL
    properties
        name;
        id;
        toc_origin;
        range;
        thick;
    end
    methods
%         function obj = AIRFOIL()
%         end
        function obj = AIRFOIL(name, id, range, thick, toc_origin)
            obj.name = name;
            obj.id = id;
            obj.toc_origin = toc_origin;
            obj.range = range;
            obj.thick = thick;
        end
        function y = get_thick(obj, x)
            y = interp1(obj.range,obj.thick,x,'linear');
        end
        function plot_airfoil(obj)
            grid on
            axis equal; hold on;
            plot(obj.range, -0.5*obj.thick, '-o'); hold on;
            plot(obj.range, 0.5*obj.thick, '-o'); hold on;
        end
    end
end
