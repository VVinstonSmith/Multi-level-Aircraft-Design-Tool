classdef GRID
    %UNTITLED23 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        id;
        region;
        loc;   
    end
    
    methods
        function obj = GRID(id, region, loc)
            obj.id = id;
            obj.region = region;
            obj.loc = loc;
        end
    end
    
end

