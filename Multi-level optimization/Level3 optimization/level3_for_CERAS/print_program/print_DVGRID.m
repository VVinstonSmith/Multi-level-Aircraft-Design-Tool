function y = print_DVGRID(fid, DVID, GID, CID, CORFF, N)
% DVID: DVGRID ID��
% GID: Ҫ�������Ľ����
% CID: ����ϵ���
% CORFF: Ni�ĳ˻�ϵ��
% N: CID����ϵ�еķ���

y = 0;
fprintf(fid,'DVGRID   ');
fprintf(fid,'%-7d ',DVID);
fprintf(fid,'%-7d ',GID);
fprintf(fid,'%-7d ',CID);
fprintf(fid,'%-7.2f ',CORFF);
fprintf(fid,'%-7.2f ',N(1));
fprintf(fid,'%-7.2f ',N(2));
fprintf(fid,'%-7.2f\n',N(3));

end
    
