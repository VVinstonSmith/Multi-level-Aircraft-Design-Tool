classdef DEQATN
    properties
        EQID;
        EQATN;
    end
    
    methods
        function obj = DEQATN(EQID, EQATN)
            obj.EQID = EQID;
            obj.EQATN = EQATN;
        end
        function print(obj, fid)
            print_DEQATN(fid, obj.EQID, obj.EQATN);
        end
    end
end

