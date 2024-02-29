classdef DLINK
    % DDVID = C0 + CMULT*sigma(Ci*IDVi)
    % ��������
    properties
        ID;
        DDVID;% DDVID: �������
        C0;% C0: ������
        CMULT;% CMULT: ����
        IDVi;% IDVi: ��Ʊ������
        Ci;% Ci: ϵ��
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

