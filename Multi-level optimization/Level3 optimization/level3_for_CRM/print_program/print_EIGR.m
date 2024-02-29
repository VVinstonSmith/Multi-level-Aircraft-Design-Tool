function y = print_EIGR(fid, modes1, METHOD, modes2)
%modes1：计算模态阶数
%LMODES：颤振求解用的模态阶数

y=0;
fprintf(fid,'EIGR     ');
fprintf(fid,'%-7d ',modes1);
fprintf(fid,'%-7s ',METHOD);
fprintf(fid,'        ');
fprintf(fid,'        ');
fprintf(fid,'        ');
fprintf(fid,'%-7d\n',modes2);
fprintf(fid,'         ');
fprintf(fid,'%-7s \n','MAX');

fprintf(fid,'PARAM    ');
fprintf(fid,'OPPHIPA ');
fprintf(fid,'%-7d\n',1);

% fprintf(fid,'PARAM    ');
% fprintf(fid,'LMODES  ');
% fprintf(fid,'%-7d\n',LMODES);

end

