classdef DVPREL1
    properties
        ID;
        TYPE;% �������ͣ���PBAR
        P_num;
        PID;% ���Կ�ID
        PNAME;% ���Կ��������λ��
        PMIN;
        PMAX;
        C0;
        DVID;% DESVAR��ID
        COEF;% ��Ȩϵ��
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

