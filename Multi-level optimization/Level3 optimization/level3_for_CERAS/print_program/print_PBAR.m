function y = print_PBAR(fid, PID, MID, A, Izz, Iyy, J, h, b)
y = 0;

fprintf(fid,'PBAR     ');
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',MID);
print_form_number(fid,A);
print_form_number(fid,Izz);
print_form_number(fid,Iyy);
print_form_number(fid,J);
fprintf(fid,'\n');
fprintf(fid,'         ');

print_form_number(fid,b/2);
print_form_number(fid,h/2);
print_form_number(fid,b/2);
print_form_number(fid,-h/2);
print_form_number(fid,-b/2);
print_form_number(fid,h/2);
print_form_number(fid,-b/2);
print_form_number(fid,-h/2);
fprintf(fid,'\n');

end

