function y = print_SUBCASE_FLUTTER(fid, ID, LABEL, ANALYSIS, DESSUB, METHOD, FMETHOD, SPC)
y=0;

fprintf(fid,'SUBCASE %d\n',ID);
fprintf(fid,'   LABEL = %s\n',LABEL);
if ANALYSIS~=0
    fprintf(fid,'   ANALYSIS = %s\n',ANALYSIS);
end
fprintf(fid,'   DISP = NONE\n');
fprintf(fid,'   STRESS = NONE\n');
fprintf(fid,'   FORCE = NONE\n');
fprintf(fid,'   AEROF = NONE\n');
fprintf(fid,'   APRES = NONE\n');
if DESSUB~=0
    fprintf(fid,'   DESSUB = %d\n',DESSUB);
end

fprintf(fid,'   METHOD = %d\n',METHOD);
fprintf(fid,'   FMETHOD = %d\n',FMETHOD);
if SPC~=0
    fprintf(fid,'   SPC = %d\n',SPC);
end
end