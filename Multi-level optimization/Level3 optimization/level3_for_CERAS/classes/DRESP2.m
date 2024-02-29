classdef DRESP2

    properties
        ID;
        LABEL;
        EQID; % EQID: DEQATN_id
        DESVAR;% DESVAR: DVIDi
        DTABLE;% DTABLE: LABLi
        DRESP1;% DRESP1: NRi
        DNODE;% DNODE: 节点号Gi 结点自由度号Ci
        DVPRLE1;% DVPRLE1: DPIPi
        type;
    end
    
    methods
        function obj = DRESP2(ID, LABEL, EQID, DESVAR, DTABLE, DRESP1, DNODE, DVPRLE1, type)
            obj.ID = ID;
            obj.LABEL = LABEL;
            obj.EQID = EQID;
            obj.DESVAR = DESVAR;
            obj.DTABLE = DTABLE;
            obj.DRESP1 = DRESP1;
            obj.DNODE = DNODE;
            obj.DVPRLE1 = DVPRLE1;
            obj.type = type;
        end
        function print(obj,fid)
            print_DRESP2(fid, obj.ID, obj.LABEL, obj.EQID, obj.DESVAR, obj.DTABLE, obj.DRESP1, obj.DNODE, obj.DVPRLE1);
        end
    end
end

