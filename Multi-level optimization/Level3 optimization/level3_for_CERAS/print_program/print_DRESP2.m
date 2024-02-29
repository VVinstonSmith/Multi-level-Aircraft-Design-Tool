function y = print_DRESP2(fid, ID, LABEL, EQID, DESVAR, DTABLE, DRESP1, DNODE, DVPRLE1)
% EQID: DEQATN_id
% DESVAR: DVIDi
% DTABLE: LABLi
% DRESP1: NRi
% DNODE: 节点号Gi 结点自由度号Ci
% DVPRLE1: DPIPi

y = 0;
fprintf(fid,'DRESP2   ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',LABEL);
fprintf(fid,'%-7d \n',EQID);

if length(DESVAR)>0
    fprintf(fid,'         ');
    fprintf(fid,'DESVAR  ');
    for ii = 1:length(DESVAR)
        fprintf(fid,'%-7d ',DESVAR(ii));
    end
    fprintf(fid,'\n');
end

if length(DTABLE)>0
    fprintf(fid,'         ');
    fprintf(fid,'DTABLE  ');
    for ii = 1:length(DTABLE)
        fprintf(fid,'%-7d ',DTABLE{ii});
    end
    fprintf(fid,'\n');
end

if length(DRESP1)>0
    fprintf(fid,'         ');
    fprintf(fid,'DRESP1  ');
    for ii = 1:length(DRESP1)
        fprintf(fid,'%-7d ',DRESP1(ii));
    end
    fprintf(fid,'\n');
end

if length(DNODE)>0
    fprintf(fid,'         ');
    fprintf(fid,'DNODE   ');
    for ii = 1:length(DNODE(:,1))
        fprintf(fid,'%-7d ',DNODE(ii,1));
        fprintf(fid,'%-7d ',DNODE(ii,2));
    end
    fprintf(fid,'\n');
end

if length(DVPRLE1)>0
    fprintf(fid,'         ');
    fprintf(fid,'DVPRLE1 ');
    for ii = 1:length(DVPRLE1)
        fprintf(fid,'%-7d ',DVPRLE1(ii));
    end
    fprintf(fid,'\n');
end

end
    
