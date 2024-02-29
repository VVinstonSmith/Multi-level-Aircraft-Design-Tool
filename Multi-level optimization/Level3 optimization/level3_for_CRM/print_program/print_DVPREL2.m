function y = print_DVPREL2(fid, ID, TYPE, PID,  PNAME, PMIN, PMAX, EQID, DESVAR, DTABLE)
% TYPE: �������ͣ���PBAR
% PID: ���Կ�ID
% PNAME: ���Կ��������λ��
% EQID: DEQATN���ݿ����
% DESVAR: ��ʽ�е�DESBARid
% DTABLE: ��ʽ�еĳ���

y = 0;

fprintf(fid,'DVPREL2  ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',TYPE);
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',PNAME);
if PMAX > PMIN
    print_form_number(fid,PMIN);
    print_form_number(fid,PMAX);
else
    fprintf(fid,'        ');
    fprintf(fid,'        ');
end
fprintf(fid,'%-7d\n', EQID);

if isempty(DESVAR) == 0
    fprintf(fid,'         ');
    fprintf(fid,'DESVAR   ');
    for ii= 1:length(DESVAR)
        fprintf(fid,'%-7d ',DESVAR(ii));
    end
    fprintf(fid,'\n');
end
    
if isempty(DTABLE) == 0
    fprintf(fid,'         ');
    fprintf(fid,'DTABLE   ');
    for ii= 1:length(DTABLE)
        fprintf(fid,'%-7s ',DTABLE{ii});
    end
    fprintf(fid,'\n');
end

end
    
