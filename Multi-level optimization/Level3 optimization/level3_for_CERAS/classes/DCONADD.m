classdef DCONADD
    % DC: DCONSTRÊý¾Ý¿¨±àºÅ
    properties
        DCID;
        DC;
        condition;
    end
    
    methods
        function obj = DCONADD(DCID, DC, condition)
            obj.DCID = DCID;
            obj.DC = DC;
            obj.condition = condition;
        end
        function print(obj,fid)
            fprintf(fid, ['$ ',obj.condition,'\n']);
            print_DCONADD(fid, obj.DCID, obj.DC);
        end
    end
end

