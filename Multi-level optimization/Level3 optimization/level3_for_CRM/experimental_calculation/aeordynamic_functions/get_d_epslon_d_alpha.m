function y = get_d_epslon_d_alpha(A, lamda, b, ka_q, h_H, L_H, CL_alpha_W, CL_alpha_W_M0)
% formula(06,6-42)
% 平尾下洗迎角变化率

% A: 展弦比
% lamda: 梢根比
% b: 展长
% ka_q: 四分之一弦线后掠角
% h_H: 平尾与机翼的垂直高度差
% L_H: 平尾焦点与机翼焦点的水平距离
% CL_alpha_W: 考虑压缩性的机翼升力线斜率
% CL_alpha_W_M0: Ma=0时的机翼升力线斜率

K_A = 1/A - 1/(1+A^1.7);
K_lamda = (10-3*lamda)/7;
K_H = (1-h_H/b) / (2*L_H/b)^(1/3);
y = 4.44 * (K_A*K_lamda*K_H*sqrt(cos(ka_q)))^1.19;
y = y * CL_alpha_W/CL_alpha_W_M0;

end

