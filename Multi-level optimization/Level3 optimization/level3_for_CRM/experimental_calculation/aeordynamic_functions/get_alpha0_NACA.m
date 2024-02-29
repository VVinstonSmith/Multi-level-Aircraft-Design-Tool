function alpha0_deg = get_alpha0_NACA(num, alpha_des, CL_des)
% formula(06, 6-4)
% NACA翼型零升迎角估算

% num: 位数
% CL_des: 设计升力系数
% alpha_des: 设计迎角
if num==4
    K=0.93;
elseif num==5
    K=1.08;
elseif num==6
    K=0.74;
end

alpha0_deg = K*(alpha_des - 57.3/(2*pi)*CL_des);

end

