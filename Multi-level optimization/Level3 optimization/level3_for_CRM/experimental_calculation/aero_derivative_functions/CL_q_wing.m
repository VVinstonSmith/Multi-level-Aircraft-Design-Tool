function CL_q_wing = CL_q_wing(C_A, CL_alpha_W, X_F, X_cg)
% formula(0.6, 10-3)(忽略 delta_X_F_bar)
% 俯仰角速度升力动导数(机翼贡献)

% C_A: 机翼平均气动弦长
% CL_alpha_W: 机翼升力线斜率
% CL_q_quater(CL_alpha_W, X_F_bar): 机翼对平均气动弦1/4弦点的升力系数导数
% X_F: 机翼平均气动弦前缘到机翼气动中心的距离(1/4*C_A)
% X_cg: 机翼平均气动弦前缘到飞机重心的距离(向后为正)
X_F_bar = X_F / C_A;
X_cg_bar = X_cg / C_A;
%
CL_q_quater = 0.5 + 2*(X_F_bar-0.25);
CL_q_quater = CL_q_quater * CL_alpha_W;
%
CL_q_wing = CL_q_quater - 2*CL_alpha_W*(X_cg_bar - 0.25);

end

