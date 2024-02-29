function y = print_CONM2(fid, EID, GIRD, CID, M, X, I)
% GRID: 所在结点
% CID: 参考坐标系
% M:集中质量
% X:偏移位置
% I:转动惯量
I11 = I(1);
I21 = I(2);
I22 = I(3);
I31 = I(4);
I32 = I(5);
I33 = I(6);

y = 0;
fprintf(fid,'CONM2    ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',GIRD);
fprintf(fid,'%-7d ',CID);
print_form_number(fid,M);
fprintf(fid,'%-7.2f ',X(1));
fprintf(fid,'%-7.2f ',X(2));
fprintf(fid,'%-7.2f\n',X(3));

if I11==0 && I21==0 && I22==0 && I31==0 && I32==0 && I33==0
    return;
end

fprintf(fid,'         ');
fprintf(fid,'%-7.2f ',I11);
fprintf(fid,'%-7.2f ',I21);
fprintf(fid,'%-7.2f ',I22);
fprintf(fid,'%-7.2f ',I31);
fprintf(fid,'%-7.2f ',I32);
fprintf(fid,'%-7.2f\n',I33);

end
