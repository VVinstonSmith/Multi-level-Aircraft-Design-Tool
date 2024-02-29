function y = print_FLUTTER(fid, SID, METH, DENS_id, MACH_id, PFREQ_id, IMETH, NVALUE)
% METH: K, PK, KE
% DENS_id: 用来指定密度比的FLFACT卡ID
% MACH_id: 用来指定马赫数的FLFACT卡ID
% PFREQ_id: 用来指定减缩频率(K)或者速度(PK)的FLFACT卡ID
% IMETH: 气动力矩阵插值方法：L：线性样条插值，S：表面样条插值
% NVALUE: 模态数目
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
    
