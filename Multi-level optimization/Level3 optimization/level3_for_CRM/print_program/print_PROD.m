function y = print_PROD(fid, PID, MID, A)
y = 0;

fprintf(fid,'PROD     ');
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',MID);
fprintf(fid,'%-7.2f\n',A);

end

