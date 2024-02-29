classdef DRESP1
    %
    % STABDER: �����������ȶ��Ե���
    % ATTA: AESTAT�� �� AESURF�� �� ID
    % ATTB: 0��ʾ��Լ����1��ʾ��Լ��
    % ATTi: �������ɶȷ���
    %
    % TRIM: ����������ƽ������Ӧ
    % ATTA: AESTAT�� �� AESURF�� �� ID
    % ATTB: empty
    % ATTi: empty
    %
    % FLUTTER: ����������ƽ������Ӧ
    % ATTA: empty
    % ATTB: empty
    % ATT1: ����ģ̬SET1����ID
    % ATT2: �ܶȱ�FLFACT����ID
    % ATT3: �����FLFACT����ID
    % ATT4: �ٶ�FLFACT����ID
    properties
        ID;
        LABEL;% ��Ӧ����
        RTYPE;% ��Ӧ�������ͣ���DISP, STRESS, STABDER
        PTYPE;% ���Կ����ͣ��� PBAR,PROD
        ATTA;% ��Ӧ���� 
        ATTi;% ����ID
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

