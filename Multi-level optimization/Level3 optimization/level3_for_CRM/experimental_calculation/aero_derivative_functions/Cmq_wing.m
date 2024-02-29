function y = Cmq_wing(CL_alpha_2d, CL_alpha_W, X_F, X_cg, C_A, Ma, A, ka_q)
% formula(06, 10-10)
% 俯仰阻尼系数(机翼)

% CL_alpha_2d: Ma=0时，垂直于1/4弦线剖面的二维升力线斜率沿展向的平均值
% CL_alpha_W: 机翼升力线斜率
% X_F: 机翼平均气动弦前缘到机翼气动中心的距离(1/4*C_A)
% X_cg: 机翼平均气动弦前缘到飞机重心的距离(向后为正)
% C_A: 机翼平均气动弦长
% Ma: 马赫数
% A: 展弦比
% ka_q: 1/4弦后掠角
%
X_F_bar = X_F / C_A;
X_cg_bar = X_cg / C_A;
%
F = get_F_of_Cmq(Ma, A);
beta_pie = sqrt(1 - (Ma*cos(ka_q))^2);
%
Cm_q_quater = -2*CL_alpha_W * (0.25*(X_F_bar-0.25) + (X_F_bar-0.25)^2) +...
    -2*F * (CL_alpha_2d*cos(ka_q)/(48*beta_pie) * (beta_pie*A^3*tan(ka_q)^2)/(beta_pie*A+6*cos(ka_q)) + 3);
%
CL_q_quater = CL_alpha_W * (0.5 + 2*(X_F_bar-0.25));
%
y = Cm_q_quater + CL_q_quater * (X_cg_bar - 0.25)...
    -2*CL_alpha_W * (X_cg_bar-X_F_bar) * (X_cg_bar-0.25);

end