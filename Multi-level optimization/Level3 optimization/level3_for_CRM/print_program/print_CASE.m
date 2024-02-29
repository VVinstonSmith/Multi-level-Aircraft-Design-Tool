function y = print_CASE(fid, SOL, TIME, TITLE, ECHO)

fprintf(fid,'SOL %d\n',SOL);
if TIME~=0
    fprintf(fid,'TIME %d\n',TIME);
end
fprintf(fid,'CEND\n');
fprintf(fid,'TITLE = %s\n',TITLE);
fprintf(fid,'ECHO = %s\n',ECHO);

y=0;

end

