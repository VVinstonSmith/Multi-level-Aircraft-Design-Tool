function y = print_DLINK(fid, ID, DDVID, C0, CMULT, IDVi, Ci)
% DDVID = C0 + CMULT*sigma(Ci*IDVi)

% DDVID: 变量编号
% C0: 常数项
% CMULT: 常数
% IDVi: 设计变量编号
% Ci: 系数

fprintf(fid,'$\n');
y = 0;

fprintf(fid,'DLINK    ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7d ',DDVID);
fprintf(fid,'%-7.2f ',C0);
fprintf(fid,'%-7.2f ',CMULT);

row_num = 6;
for ii = 1:length(IDVi)
    fprintf(fid,'%-7d ',IDVi(ii));
    fprintf(fid,'%-7.2f ',Ci(ii));
    row_num = row_num+2;
    if row_num==10 && ii~=length(IDVi)
        fprintf(fid,' \n');
        fprintf(fid,'         ');
        row_num = 2;
    end
end
fprintf(fid,'\n'); 

end
    
