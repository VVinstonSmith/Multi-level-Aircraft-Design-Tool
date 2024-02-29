function y = print_EIGRL(fid, ID, ND, MSGLVL)
% ND£ºNumber of roots desired
% MSGLVL£ºDiagnostic level

y=0;
fprintf(fid,'EIGRL    ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',' ');
fprintf(fid,'%-7s ',' ');
fprintf(fid,'%-7d ',ND);
fprintf(fid,'%-7d ',MSGLVL);
fprintf(fid,'%-7s ',' ');
fprintf(fid,'%-7s ',' ');
fprintf(fid,'%-7s\n','MASS');

end

