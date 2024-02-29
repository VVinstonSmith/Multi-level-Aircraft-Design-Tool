classdef DESVAR

    properties
        id;
        LABEL;% ������
        XINT;% XINT:��ֵ
        XFIN;%��ֵ
        XLB;% ����
        XUB;% ����
        DELXV;% �������ı���
        region;
        region_number;
        component;
        y;
    end
    
    methods
        function obj = DESVAR(id, LABEL, XINT, XLB, XUB, DELXV,...
                region, region_number, component, y)
            obj.id = id;
            obj.LABEL = LABEL;
            obj.XINT = XINT;
            obj.XLB = XLB;
            obj.XUB = XUB;
            obj.DELXV = DELXV;
            obj.region = region;
            obj.region_number = region_number;
            obj.component = component;
            obj.y = y;
        end
        function print_XINT(obj,fid)
            print_DESVAR(fid, obj.id, obj.LABEL, obj.XINT, obj.XLB, obj.XUB, obj.DELXV);
        end
        function print_XFIN(obj,fid)
            print_DESVAR(fid, obj.id, obj.LABEL, obj.XFIN, obj.XLB, obj.XUB, obj.DELXV);
        end 
    end
    
end

