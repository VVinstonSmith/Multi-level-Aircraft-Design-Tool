classdef DCONSTR
    % Լ��
    properties
        id;
        RID;% ��Ӧ��id
        LALLOW;% ����
        UALLOW;% ����
        type;
        condition;
    end
    
    methods
        function obj = DCONSTR(DCID, RID, LALLOW, UALLOW, type, condition)
            obj.id = DCID;
            obj.RID = RID;
            obj.LALLOW = LALLOW;
            obj.UALLOW = UALLOW;
            obj.type = type;
            obj.condition = condition;
        end
        function print(obj,fid)
            print_DCONSTR(fid, obj.id, obj.RID, obj.LALLOW, obj.UALLOW);
        end
    end
end

