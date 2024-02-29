function y = print_CAERO1(fid, EID,PID, NSPAN, NCHORD, X_root,L_root, X_tip, L_tip)
% NSPAN:展向段数
% NCHORD:弦向段数
% X_root:根部前缘点
% L_root:根部弦长
% X_tip:梢部前缘点
% L_tip:梢部弦长
y=0;

fprintf(fid,'CAERO1   ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',PID);
% fprintf(fid,'%-7d ',0);
fprintf(fid,'        ');
fprintf(fid,'%-7d ',NSPAN);
fprintf(fid,'%-7d ',NCHORD);
fprintf(fid,'        ');
fprintf(fid,'        ');
fprintf(fid,'%-7d\n',1);

fprintf(fid,'         ');
print_form_number(fid,X_root(1));
print_form_number(fid,X_root(2));
print_form_number(fid,X_root(3));
print_form_number(fid,L_root);
print_form_number(fid,X_tip(1));
print_form_number(fid,X_tip(2));
print_form_number(fid,X_tip(3));
print_form_number(fid,L_tip);

fprintf(fid,'\n');

end

