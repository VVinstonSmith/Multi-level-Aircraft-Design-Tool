function y = print_SUBCASE_MODES(fid, ID, LABEL, ANALYSIS, DESSUB, METHOD, SPC)
y=0;

fprintf(fid,'SUBCASE %d\n',ID);
fprintf(fid,'   LABEL = %s\n',LABEL);
fprintf(fid,'   ANALYSIS = %s\n',ANALYSIS);
if DESSUB~=0
    fprintf(fid,'   DESSUB = %d\n',DESSUB);
end
if METHOD~=0
    fprintf(fid,'   METHOD = %d\n',METHOD);
end
if SPC~=0
    fprintf(fid,'   SPC = %d\n',SPC);
end


end