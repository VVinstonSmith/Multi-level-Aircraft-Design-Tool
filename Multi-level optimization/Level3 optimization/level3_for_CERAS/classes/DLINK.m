classdef DLINK
    % DDVID = C0 + CMULT*sigma(Ci*IDVi)
    % 变量关联
    properties
        ID;
        DDVID;% DDVID: 变量编号
        C0;% C0: 常数项
        CMULT;% CMULT: 常数
        IDVi;% IDVi: 设计变量编号
        Ci;% Ci: 系数
    end
    
    methods
        function obj = DLINK(ID, DDVID, C0, CMULT, IDVi, Ci)
            obj.ID = ID;
            obj.DDVID = DDVID;
            obj.C0 = C0;
            obj.CMULT = CMULT;
            obj.IDVi = IDVi;
            obj.Ci = Ci;
        end
    end
end

