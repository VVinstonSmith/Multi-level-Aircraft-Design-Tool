function y = print_DEQATN(fid, EQID, EQATN)
y = 0;

fprintf(fid,'DEQATN   ');
fprintf(fid,'%-7d ',EQID);
fprintf(fid,'% s\n',EQATN);
fprintf(fid,'$\n');

end
    
