function y = CL0_aircraft(d_F, b, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, phi_H, epslon_H)
% formula(06, 6-30)
% 全机零迎角升力系数

% d_F: 机身当量直径
% b: 机翼展长
% CL_alpha_W: 机翼升力线斜率
% phi_W: 机翼安装角
% alpha0_W: 机翼零升迎角
% CL_alpha_H: 平尾升力线斜率
% k_q: 动压比
% S_H_div_S: 平尾机翼面积比
% phi_H: 平尾安装角
% epslon_H: 平尾下洗角(襟翼收起后可认为是0)

K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;% 翼身干扰因子
CL_alpha_WF = K_WF * CL_alpha_W;
CL0_WF = (phi_W-alpha0_W) * CL_alpha_WF;
y = CL0_WF + CL_alpha_H * k_q * S_H_div_S * (phi_H-epslon_H);

end

