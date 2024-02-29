function y = Clp_wing(Cl_alpha_M, CL_alpha_W_CL, CL_alpha_W_CL0, CL_W, CD0_W,...
    Z, Ma, ka_q, A, lamda, gamma, b)
% formula(06, 10-43)
% 滚转阻尼导数(机翼)

% Cl_alpha_M: 某一Ma时机翼剖面的升力线斜率
% CL_alpha_W_CL: 失速前某一CL下的升力线斜率
% CL_alpha_W_CL0: CL=0时的某一升力线斜率
% CL_W: 机翼升力系数
% CD0_W: 机翼零升阻力系数
% Z: 力矩参考中心高于机翼中央弦线的垂直距离
% Ma
% ka_q
% A: 展弦比
% lamda: 梢根比
% gamma: 上反角
% b: 展长

beta = sqrt(1-Ma^2);
K = beta * Cl_alpha_M / (2*pi);
ksi = Z/(0.5*b);
betaC_K = get_betaC_K(Ma, Cl_alpha_M, ka_q, A, lamda);
Clp_CLW2 = get_Clp_CLW2(A, ka_q);
%
ClpW_gamma = -4*ksi*sin(gamma)/(1+3*lamda) *...
    (2 + 4*lamda - 3*ksi*(1+lamda)*sin(gamma)) * (betaC_K * K/beta);
delta_Clp_drag = Clp_CLW2 * (CL_W^2 - 0.125*CD0_W);
%
y = betaC_K * K/beta * CL_alpha_W_CL/CL_alpha_W_CL0 +...
    ClpW_gamma + delta_Clp_drag;

end

