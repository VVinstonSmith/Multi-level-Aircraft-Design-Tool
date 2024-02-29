function y = print_AEROS(fid, not_half, ACSID, RCSID, CREF, BREF, SREF)
% RCSID:�����˶��ο�����ϵ

y=0;

if not_half == 0
    fprintf(fid,'$ A half-span model is defined\n');
else
    fprintf(fid,'$ A whole-span model is defined\n');
end


fprintf(fid,'AEROS    ');
fprintf(fid,'%-7d ',ACSID);
fprintf(fid,'%-7d ',RCSID);
print_form_number(fid,CREF);
print_form_number(fid,BREF);
print_form_number(fid,SREF);
fprintf(fid,'\n');

end

