function y = print_SUBCASE_AERO_STATIC(fid, ID, LABEL, ANALYSIS, DESSUB, TRIM, SPC, SUPORT, disp, force, stress)
y=0;

fprintf(fid,'SUBCASE %d\n',ID);
fprintf(fid,'   LABEL = %s\n',LABEL);
fprintf(fid,'   ANALYSIS = %s\n',ANALYSIS);
if DESSUB~=0
    fprintf(fid,'   DESSUB = %d\n',DESSUB);
end
if TRIM~=0
    fprintf(fid,'   TRIM = %d\n',TRIM);
end
if SPC~=0
    fprintf(fid,'   SPC = %d\n',SPC);
end
if SUPORT~=0
    fprintf(fid,'   SUPORT1 = %d\n',SUPORT);
end
fprintf(fid,'   DISPLACEMENT(SORT1,REAL)=%s\n',disp);
fprintf(fid,'   SPCFORCES(SORT1,REAL)=%s\n',force);
fprintf(fid,'   STRESS(SORT1,REAL,VONMISES,BILIN)=%s\n',stress);

fprintf(fid,'   AEROF = ALL\n');
fprintf(fid,'   APRES = ALL\n');
end