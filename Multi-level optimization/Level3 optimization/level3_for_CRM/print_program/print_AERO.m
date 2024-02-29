function y = print_AERO(fid, not_half, RHO, ACSID, CREF)
% RCSID:刚体运动参考坐标系

y=0;

if not_half == 0
    fprintf(fid,'$ A half-span model is defined\n');
else
    fprintf(fid,'$ A whole-span model is defined\n');
end

fprintf(fid,'AERO     ');
fprintf(fid,'%-7d ',ACSID);
fprintf(fid,'        ');
print_form_number(fid,CREF);
print_form_number(fid,RHO);
fprintf(fid,'\n');

end