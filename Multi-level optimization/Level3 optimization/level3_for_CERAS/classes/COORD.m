classdef COORD
    % RID:�ο�����ϵ
    % A:ԭ��
    % B:z��
    % C:xzƽ��
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

