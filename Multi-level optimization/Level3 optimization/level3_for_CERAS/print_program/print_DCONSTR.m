function y = print_DCONSTR(fid, DCID, RID, LALLOW, UALLOW)
% RID: ��Ӧ��id
% LALLOW:����
% UALLOW:����
y = 0;
fprintf(fid,'DCONSTR  ');
fprintf(fid,'%-7d ',DCID);
fprintf(fid,'%-7d ',RID);
if isempty(LALLOW)
    fprintf(fid,'%-7s ',' ');
else
    print_form_number(fid,LALLOW);
end
if isempty(UALLOW)
    fprintf(fid,'%-7s ',' ');
else
    print_form_number(fid,UALLOW);
end
fprintf(fid,'\n');
end
    
