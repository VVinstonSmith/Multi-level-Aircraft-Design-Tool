classdef PSHELL
    %UNTITLED45 此处显示有关此类的摘要
    %  (fid, PID, MID1, thick, MID2, MID3, NSM)
    
    properties
        id;
        region;
        M_num;
        thick;
        MID1;
        MID2;
        MID3;
        NSM;
        desvar_id;
        %
        DVPREL1_thick_num;
        DVPREL2_thick_num;
    end
    
    methods
        function obj = PSHELL(id, M_num, thick, region)
            obj.id = id;
            obj.M_num = M_num;
            obj.thick = thick;
            obj.NSM = 0;
            obj.region = region;
        end
        function obj = get_MID(obj, mat)
            obj.MID1 = mat(obj.M_num).id;
            obj.MID2 = obj.MID1;
            obj.MID3 = obj.MID1;
        end
        
    end
    
end

