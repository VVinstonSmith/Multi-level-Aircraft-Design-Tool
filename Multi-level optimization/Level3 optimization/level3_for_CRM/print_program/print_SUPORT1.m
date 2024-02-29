function y = print_SUPORT1(fid, id, GRDPNT, SUPORT)
y=0;

if SUPORT~=0
    fprintf(fid,'SUPORT1  ');
    fprintf(fid,'%-7d ',id);
    fprintf(fid,'%-7d ',GRDPNT);
    fprintf(fid,'%-7d\n',SUPORT);
end

end

