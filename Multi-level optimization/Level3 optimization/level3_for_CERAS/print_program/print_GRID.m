function y = print_GRID(fid, ID, X,Y,Z)
y = 0;

fprintf(fid,'GRID     ');
fprintf(fid,'%-16d',ID);
print_form_number(fid,X);
print_form_number(fid,Y);
print_form_number(fid,Z);
fprintf(fid,'\n');

end

