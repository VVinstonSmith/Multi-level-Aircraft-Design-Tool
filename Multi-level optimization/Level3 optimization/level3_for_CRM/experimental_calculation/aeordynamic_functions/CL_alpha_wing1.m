function CL_alpha_3d = CL_alpha_wing1(CL_alpha_2d, A, Ma, S_exp_div_ref, d_F, b, ka)
% formula(06,1-21)

% CL_alpha_2d
% A: 展弦比
% Ma
% S_exp_div_ref: 外露面积比参考面积
% d_F: 机身直径
% b: 展长
% ka:最大厚度点弦线后掠角

beta = sqrt(1-Ma^2);
eta = CL_alpha_2d / (2*pi);
F = 1.07*(1+d_F/b)^2;

CL_alpha_3d = (2*pi*A) /...
    (2 + sqrt(4+(A*beta/eta)^2*(1+tan(ka)^2/beta^2)));
CL_alpha_3d = CL_alpha_3d * S_exp_div_ref * F;

% CL_alpha_3d: 机翼的升力线斜率

end

