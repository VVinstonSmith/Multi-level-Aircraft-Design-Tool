function y = print_CQUAD4(fid, EID, PID, GRID_1, GRID_2, GRID_3, GRID_4, THETA, ZOFFS)
y = 0;
fprintf(fid,'CQUAD4   ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',GRID_1);
fprintf(fid,'%-7d ',GRID_2);
fprintf(fid,'%-7d ',GRID_3);
fprintf(fid,'%-7d ',GRID_4);
fprintf(fid,'%-7.2f ',THETA);
fprintf(fid,'%-7.2f\n',ZOFFS);

end
