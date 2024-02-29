function y = Cm_htail(CL_alpha_H, kq, d_epslon_d_alpha, alpha, phi_W, alpha0_W, delta_H, S_H, L_H, S, C_A)
% formula(06, 1-30)
% 水平尾翼力矩系数(对机翼面积和机翼平均气动弦长无量纲化)

% CL_alpha_H: 平尾升力线斜率
% kq: 动压比
% d_epslon_d_alpha: 
% alpha: 全机迎角
% S_H: 平尾面积
% L_H: 平尾力臂
% S: 机翼面积
% C_A: 机翼平均气动弦长
y = kq * CL_alpha_H * (alpha - d_epslon_d_alpha*(alpha+phi_W-alpha0_W) + delta_H);

y = kq * CL_alpha_H * ((1-d_epslon_d_alpha)*alpha + delta_H);
y = -y * (S_H*L_H)/(S*C_A);


end

