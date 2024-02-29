classdef DVPREL1
    properties
        ID;
        TYPE;% 属性类型，如PBAR
        P_num;
        PID;% 属性卡ID
        PNAME;% 属性卡中字域的位置
        PMIN;
        PMAX;
        C0;
        DVID;% DESVAR的ID
        COEF;% 加权系数
    end
    
    methods
        function obj = DVPREL1(ID, TYPE, P_num, PID, PNAME, PMIN, PMAX, C0, DVID, COEF)
            obj.ID = ID;
            obj.TYPE = TYPE;
            obj.P_num = P_num;
            obj.PID = PID;
            obj.PNAME = PNAME;
            obj.PMIN = PMIN;
            obj.PMAX = PMAX;
            obj.C0 = C0;
            obj.DVID = DVID;
            obj.COEF = COEF;
        end
        function print(obj, fid)
            print_DVPREL1(fid, obj.ID, obj.TYPE, obj.PID, obj.PNAME, obj.PMIN, obj.PMAX, obj.C0, obj.DVID, obj.COEF);
        end
    end
end

