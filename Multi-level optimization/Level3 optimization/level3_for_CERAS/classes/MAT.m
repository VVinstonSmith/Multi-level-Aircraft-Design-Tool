classdef MAT
    %UNTITLED37 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    properties
        id;
        RHO;
        E;
        G;
        NU;
        
    end
    methods
        function obj=MAT(id, E, NU, RHO)
            obj.id = id;
            obj.E = E;
            obj.NU = NU;
            obj.RHO = RHO;
            obj.G = E/(2*(1+NU));
        end
            
    end
    
end

