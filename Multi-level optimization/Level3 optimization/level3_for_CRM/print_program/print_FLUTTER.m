function y = print_FLUTTER(fid, SID, METH, DENS_id, MACH_id, PFREQ_id, IMETH, NVALUE)
% METH: K, PK, KE
% DENS_id: ����ָ���ܶȱȵ�FLFACT��ID
% MACH_id: ����ָ���������FLFACT��ID
% PFREQ_id: ����ָ������Ƶ��(K)�����ٶ�(PK)��FLFACT��ID
% IMETH: �����������ֵ������L������������ֵ��S������������ֵ
% NVALUE: ģ̬��Ŀ
y = 0;
fprintf(fid,'%-7s ', '$');
fprintf(fid,'%-7s ', 'SID');
fprintf(fid,'%-7s ', 'METH');
fprintf(fid,'%-7s ', 'DENS_id');
fprintf(fid,'%-7s ', 'MACH_id');
fprintf(fid,'%-7s ', 'FREQ_id');
fprintf(fid,'%-7s ', 'IMETH');
fprintf(fid,'%-7s\n', 'NVALUE');

fprintf(fid,'FLUTTER  ');
fprintf(fid,'%-7d ',SID);
fprintf(fid,'%-7s ',METH);
fprintf(fid,'%-7d ',DENS_id);
fprintf(fid,'%-7d ',MACH_id);
fprintf(fid,'%-7d ',PFREQ_id);
if IMETH~=0
    fprintf(fid,'%-7s ',IMETH);
else
    fprintf(fid,'%-7s ', ' ');
end
fprintf(fid,'%-7d\n',NVALUE);


end
    
