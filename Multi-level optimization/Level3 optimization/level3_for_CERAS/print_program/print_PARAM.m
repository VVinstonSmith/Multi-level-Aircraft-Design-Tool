function y = print_PARAM(fid, GRDPNT, AUNITS, SUPORT, LMODES, OPTEXIT)
% POST: 0:���XDB
% OGEOM:
% AUTOSPC:
% K6ROT: ���嵥Ԫ���նȣ�Ĭ��Ϊ100
% MAXRATIO: �նȾ��������ŷ�ֵ��Ĭ��Ϊ1.0E+7
% LMODES: ����ģ̬��
% OPTEXIT: �����������Ϣ��f06

% GRDPNT:���Ĳο���
% AUNITS:1/�������ٶ�
% SUPPORT: ��ƽ���ɶ�

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

