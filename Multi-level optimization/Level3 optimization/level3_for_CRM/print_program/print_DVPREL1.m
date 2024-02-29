function y = print_DVPREL1(fid, ID, TYPE, PID,  PNAME, PMIN, PMAX, C0, DVID, COEF)
% TYPE: 属性类型，如PBAR
% PID: 属性卡ID
% PNAME: 属性卡中字域的位置
% DVID: DESVAR的ID
% COEF: 加权系数
y = 0;

fprintf(fid,'DVPREL1  ');
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
print_form_number(fid,C0);
fprintf(fid,'\n');
fprintf(fid,'         ');

row_num = 2;
for ii= 1:length(DVID)
	fprintf(fid,'%-7d ',DVID(ii));
    print_form_number(fid,COEF(ii));
    row_num = row_num + 2;
    if row_num==10 && ii~=length(DVID)
        fprintf(fid,' \n');
        fprintf(fid,'         ');
        row_num = 2;
    end
end
fprintf(fid,'\n');

end
    
