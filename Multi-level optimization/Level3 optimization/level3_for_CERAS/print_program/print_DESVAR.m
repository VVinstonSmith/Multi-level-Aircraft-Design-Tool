function y = print_DESVAR(fid,ID, LABEL, XINT, XLB, XUB, DELXV)
% LABEL:������
% XINT:��ֵ
% XLB,XUB:���ޣ�����
% DELXV:�������ı���

y = 0;

fprintf(fid,'DESVAR   ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',LABEL);
print_form_number(fid,XINT);
print_form_number(fid,XLB);
print_form_number(fid,XUB);
fprintf(fid,'%-7.2f\n',DELXV);

end
    
