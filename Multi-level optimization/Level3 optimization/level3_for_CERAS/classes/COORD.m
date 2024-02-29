classdef COORD
    % RID:参考坐标系
    % A:原点
    % B:z轴
    % C:xz平面
    properties
        id;
        RID;
        A;
        B;
        C;
    end
    
    methods
        function obj = COORD(id, RID, A, B, C)
            obj.id = id;
            obj.RID = RID;
            obj.A = A;
            obj.B = B;
            obj.C = C;
        end
    end
    
end

