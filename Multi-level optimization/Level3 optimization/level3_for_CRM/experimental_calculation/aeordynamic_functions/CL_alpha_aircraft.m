function y = CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha)
% formula(06, 6-32)
% 全机升力线斜率

% CL_alpha_W: 机翼升力线斜率
% CL_alpha_H: 平尾升力线斜率
% d_F: 机身当量直径
% b: 机翼展长
% S_H_div_S: 平尾机翼面积比
% k_q: 动压比
% d_epslon_d_alpha: 平尾下洗

K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;% 翼身干扰因子
CL_alpha_WF = K_WF * CL_alpha_W;
%
y = CL_alpha_WF;
y = y + k_q * CL_alpha_H * (1-d_epslon_d_alpha) * S_H_div_S;

end

