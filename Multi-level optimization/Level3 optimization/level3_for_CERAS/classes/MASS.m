classdef MASS
    %UNTITLED28 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        id;% COMN2 id
        region;
        desc;
        loc;
        GRID_num;
        mass;
        I;% [I11, I21, I22, I31, I32, I33]
    end
    
    methods
        function obj = MASS(id, region, desc, loc, GRID_num, mass, I)
            obj.id = id;
            obj.region = region;
            obj.desc = desc;
            obj.loc = loc;
            obj.GRID_num = GRID_num;
            obj.mass = mass;
            obj.I = I;
        end
        function plot(obj, grids, color)
            P = grids(obj.GRID_num).loc;
            plot3(P(1), P(2), P(3), color);hold on;
        end
    end
end
