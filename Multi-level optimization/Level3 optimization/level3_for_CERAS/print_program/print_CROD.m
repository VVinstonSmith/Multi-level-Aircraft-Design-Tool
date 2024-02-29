function y = print_CROD(fid, EID, PID, GRID_1, GRID_2)
y = 0;
fprintf(fid,'CROD     ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',GRID_1);
fprintf(fid,'%-7d\n',GRID_2);
end
