function y = print_SOL200(fid, DESOBJ, DESGLB, SPC)
% DESOBJ: Ŀ�꺯������Ӧid
% ANALYSIS: �Ż�����(STATICS, MODES, DFREQ, MFREQ, MTRAN, SAERO, FLUTTER)
% DESGLB: ȫ��Լ��id

fprintf(fid,'$\n');
y = 0;
fprintf(fid,'SOL 200\n');
fprintf(fid,'CEND\n');
TITLE = 'AEROELASTIC OPTIMIZATION';
fprintf(fid,'TITLE = %s\n',TITLE);
fprintf(fid,'ECHO = %s\n','SORT');
if SPC~=0
    fprintf(fid,'SPC = %d\n',SPC);
end
fprintf(fid,'DESOBJ(MIN) = %d\n',DESOBJ);
if DESGLB~=0
    fprintf(fid,'DESGLB = %d\n',DESGLB);
end
% fprintf(fid,'DISP = ALL\n');
% fprintf(fid,'STRESS = ALL\n');
% fprintf(fid,'FORCE = ALL\n');
% fprintf(fid,'AEROF = ALL\n');
% fprintf(fid,'APRES = ALL\n');

end
    
