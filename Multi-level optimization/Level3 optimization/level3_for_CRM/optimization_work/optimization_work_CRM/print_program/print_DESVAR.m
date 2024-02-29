function y = print_DESVAR(fid,ID, LABEL, XINT, XLB, XUB, DELXV)
% LABEL:变量名
% XINT:初值
% XLB,XUB:下限，上限
% DELXV:单步最大改变量

y = 0;

fprintf(fid,'DESVAR   ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',LABEL);
print_form_number(fid,XINT);
print_form_number(fid,XLB);
print_form_number(fid,XUB);
fprintf(fid,'%-7.2f\n',DELXV);

end
    
