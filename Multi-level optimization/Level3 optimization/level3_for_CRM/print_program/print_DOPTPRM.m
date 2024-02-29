function y = print_DOPTPRM(fid, PARAM, VAL, ISDOT)
% 优化过程控制参数设置 
% 'IPRINT' : 结果输出控制(0不输出，2输出迭代结果和寻查方向，5输出迭代过程目标函数和设计变量的值)
% 'DESMAX' : 最大迭代次数
% 'CONV2': 收敛准则
% 'DELP' : 两次迭代变量容许差值
% 'P1': 输出控制
% 'P2': 输出控制

fprintf(fid,'$\n');
fprintf(fid,'DOPTPRM  ');
y = 0;
for ii = 1:length(PARAM)
    fprintf(fid,'%-7s ',PARAM{ii});
    if ISDOT(ii)==1
        print_form_number(fid,VAL(ii));
    else
        fprintf(fid,'%-7d ',VAL(ii));
    end
    if mod(ii,4)==0 && ii~=length(PARAM)
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
