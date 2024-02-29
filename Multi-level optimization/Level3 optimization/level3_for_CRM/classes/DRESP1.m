classdef DRESP1
    %
    % STABDER: 静气动弹性稳定性导数
    % ATTA: AESTAT卡 或 AESURF卡 的 ID
    % ATTB: 0表示无约束，1表示有约束
    % ATTi: 刚体自由度分量
    %
    % TRIM: 气动弹性配平变量响应
    % ATTA: AESTAT卡 或 AESURF卡 的 ID
    % ATTB: empty
    % ATTi: empty
    %
    % FLUTTER: 气动弹性配平变量响应
    % ATTA: empty
    % ATTB: empty
    % ATT1: 颤振模态SET1卡的ID
    % ATT2: 密度比FLFACT卡的ID
    % ATT3: 马赫数FLFACT卡的ID
    % ATT4: 速度FLFACT卡的ID
    properties
        ID;
        LABEL;% 响应名称
        RTYPE;% 响应属性类型，如DISP, STRESS, STABDER
        PTYPE;% 属性卡类型，如 PBAR,PROD
        ATTA;% 响应特性 
        ATTi;% 属性ID
        type;
    end
    
    methods
        function obj = DRESP1(ID, LABEL, RTYPE, PTYPE, ATTA, ATTi, type)
            obj.ID = ID;
            obj.LABEL = LABEL;
            obj.RTYPE = RTYPE;
            obj.PTYPE = PTYPE;
            obj.ATTA = ATTA;
            obj.ATTi = ATTi;
            obj.type = type;
        end
        function print(obj,fid)
            if strcmp(obj.RTYPE,'STABDER') || strcmp(obj.RTYPE,'TRIM') || strcmp(obj.RTYPE,'FLUTTER')
                print_DRESP1_areoelastic(fid, obj.ID, obj.LABEL, obj.RTYPE, obj.ATTA, 0, obj.ATTi);
            else
                print_DRESP1(fid, obj.ID, obj.LABEL, obj.RTYPE, obj.PTYPE, obj.ATTA, obj.ATTi);
            end
        end
    end
end

