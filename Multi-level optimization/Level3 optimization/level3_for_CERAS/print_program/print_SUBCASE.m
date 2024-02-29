function y = print_SUBCASE(fid, ID, NAME, SPC, TRIM, AESYMXZ, AESYMXY, SUPORT1)

fprintf(fid,'SUBCASE %d\n',ID);
fprintf(fid,'$ Subcase name : %s\n',NAME);
fprintf(fid,'   SUBTITLE=constraints\n');
fprintf(fid,'   SPC = %d\n',SPC);
fprintf(fid,'   DISPLACEMENT(SORT1,REAL)=ALL\n');
fprintf(fid,'   SPCFORCES(SORT1,REAL)=ALL\n');
fprintf(fid,'   STRESS(SORT1,REAL,VONMISES,BILIN)=ALL\n');
fprintf(fid,'TRIM = %d\n',TRIM);
fprintf(fid,'AESYMXZ = %s\n',AESYMXZ);
fprintf(fid,'AESYMXY = %s\n',AESYMXY);
fprintf(fid,'SUPORT1 = %d\n',SUPORT1);
fprintf(fid,'AEROF = ALL\n');
fprintf(fid,'APRES = ALL\n');

fprintf(fid,'$ Direct Text Input for this Subcase\n');


y=0;

end

