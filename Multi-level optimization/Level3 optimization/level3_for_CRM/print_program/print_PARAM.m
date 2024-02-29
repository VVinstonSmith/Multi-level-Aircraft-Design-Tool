function y = print_PARAM(fid, GRDPNT, AUNITS, SUPORT, LMODES, OPTEXIT)
% POST: 0:输出XDB
% OGEOM:
% AUTOSPC:
% K6ROT: 定义单元罚刚度，默认为100
% MAXRATIO: 刚度矩阵奇异门阀值，默认为1.0E+7
% LMODES: 颤振模态数
% OPTEXIT: 输出灵敏度信息到f06

% GRDPNT:质心参考点
% AUNITS:1/重力加速度
% SUPPORT: 配平自由度

y=0;
fprintf(fid,'PARAM    ');
fprintf(fid,'POST    ');
fprintf(fid,'%-7d\n',0);

fprintf(fid,'PARAM    ');
fprintf(fid,'OPTEXIT ');
fprintf(fid,'%-7d\n',OPTEXIT);

if isempty(LMODES)==0
    fprintf(fid,'PARAM    ');
    fprintf(fid,'LMODES  ');
    fprintf(fid,'%-7d\n',LMODES);
end

fprintf(fid,'PARAM    ');
fprintf(fid,'GRDPNT  ');
fprintf(fid,'%-7d\n',GRDPNT);

% fprintf(fid,'PARAM    ');
% fprintf(fid,'WTMASS  ');
% fprintf(fid,'%-7.3f\n',WTMASS);

fprintf(fid,'PARAM    ');
fprintf(fid,'AUNITS  ');
fprintf(fid,'%-7.3f\n',AUNITS);

if SUPORT~=0
    fprintf(fid,'SUPORT1  ');
    fprintf(fid,'%-7d ',1);
    fprintf(fid,'%-7d ',GRDPNT);
    fprintf(fid,'%-7d\n',SUPORT);
end

end

