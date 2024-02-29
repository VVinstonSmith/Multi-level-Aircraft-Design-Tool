classdef DVPREL2
    properties
        ID;
        TYPE;% �������ͣ���PBAR
        P_num;
        PID;% ���Կ�ID
        PNAME;% ���Կ��������λ��
        PMIN;
        PMAX;
        EQID;% EQID: DEQATN���ݿ����
        DESVAR;% ��ʽ�е�DESBARid
        DTABLE;% ��ʽ�еĳ���
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

