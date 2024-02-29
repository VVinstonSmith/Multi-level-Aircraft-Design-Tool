function y = print_DVGRID(fid, DVID, GID, CID, CORFF, N)
% DVID: DVGRID ID号
% GID: 要参数化的结点编号
% CID: 坐标系编号
% CORFF: Ni的乘积系数
% N: CID坐标系中的分量

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
    
