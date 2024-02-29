function y = print_CORD2R(fid, CID, RID, A, B, C)
% RID:参考坐标系
% A:原点
% B:z轴
% C:xz平面

fprintf(fid,'CORD2R   ');
fprintf(fid,'%-7d ',CID);
fprintf(fid,'%-7d ',RID);
print_form_number(fid,A(1));
print_form_number(fid,A(2));
print_form_number(fid,A(3));
print_form_number(fid,B(1));
print_form_number(fid,B(2));
print_form_number(fid,B(3));
fprintf(fid,'\n');

fprintf(fid,'         ');
print_form_number(fid,C(1));
print_form_number(fid,C(2));
print_form_number(fid,C(3));
fprintf(fid,'\n');
end
    
