function y = print_SUBCASE_STATICS(fid, ID, LABEL, ANALYSIS, DESSUB, LOAD, SPC, disp, force, stress)
y=0;

fprintf(fid,'SUBCASE %d\n',ID);
fprintf(fid,'   LABEL = %s\n',LABEL);
if ANALYSIS~=0
	fprintf(fid,'   ANALYSIS = %s\n',ANALYSIS);
end
if DESSUB~=0
    fprintf(fid,'   DESSUB = %d\n',DESSUB);
end
if LOAD~=0
    fprintf(fid,'   LOAD = %d\n',LOAD);
end
if SPC~=0
    fprintf(fid,'   SPC = %d\n',SPC);
end
fprintf(fid,'   DISPLACEMENT(SORT1,REAL)=%s\n',disp);
fprintf(fid,'   SPCFORCES(SORT1,REAL)=%s\n',force);
fprintf(fid,'   STRESS(SORT1,REAL,VONMISES,BILIN)=%s\n',stress);
end