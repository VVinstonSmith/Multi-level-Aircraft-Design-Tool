function y = print_CBAR(fid, EID, PID, GRID_A, GRID_B, V)
y = 0;
fprintf(fid,'CBAR     ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',GRID_A);
fprintf(fid,'%-7d ',GRID_B);
fprintf(fid,'%-7.2f ',V(1));
fprintf(fid,'%-7.2f ',V(2));
fprintf(fid,'%-7.2f\n',V(3));
end
