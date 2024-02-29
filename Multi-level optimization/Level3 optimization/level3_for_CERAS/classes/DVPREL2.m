classdef DVPREL2
    properties
        ID;
        TYPE;% 属性类型，如PBAR
        P_num;
        PID;% 属性卡ID
        PNAME;% 属性卡中字域的位置
        PMIN;
        PMAX;
        EQID;% EQID: DEQATN数据卡编号
        DESVAR;% 公式中的DESBARid
        DTABLE;% 公式中的常量
    end
    
    methods
        function obj = DVPREL2(ID, TYPE, P_num, PID, PNAME, PMIN, PMAX, EQID, DESVAR, DTABLE)
            obj.ID = ID;
            obj.TYPE = TYPE;
            obj.P_num = P_num;
            obj.PID = PID;
            obj.PNAME = PNAME;
            obj.PMIN = PMIN;
            obj.PMAX = PMAX;
            obj.EQID = EQID;
            obj.DESVAR = DESVAR;
            obj.DTABLE = DTABLE;
        end
        function print(obj,fid)
            print_DVPREL2(fid, obj.ID, obj.TYPE, obj.PID, obj.PNAME, obj.PMIN, obj.PMAX, obj.EQID, obj.DESVAR, obj.DTABLE);
        end
    end
end

