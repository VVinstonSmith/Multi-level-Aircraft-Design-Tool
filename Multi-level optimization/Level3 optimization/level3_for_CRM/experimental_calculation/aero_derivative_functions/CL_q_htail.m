function CL_q = CL_q_htail(CL_alpha_Hexp, kq, C_A, X_FHexp, X_cg, d_F, b_H, S_Hexp, S)
% formula(0.6, 10-6)
% 俯仰角速度升力动导数(平尾贡献)

% CL_alpha_H: 有翼身干扰时的平尾升力线斜率
% CL_alpha_Hexp: 外露平尾升力线斜率(近似为平尾升力线) 
% kq: 平尾动压比
% C_A: 机翼平均气动弦长
% X_FHexp: 平尾外露面积焦点的X位置
% X_cg: 重心的X位置
% d_F: 平尾处机身当量直径
% b_H: 平尾展长
% K_HF(d_F/b_H): 尾身干扰因子
% S_Hexp: 平尾外露面积
% S: 机翼面积
X_FHexp_bar = X_FHexp / C_A;
X_cg_bar = X_cg / C_A;
%
K_HF = 1 + 0.025*(d_F/b_H) - 0.25*(d_F/b_H)^2;
CL_alpha_H = CL_alpha_Hexp * K_HF * S_Hexp/S * kq;
CL_q = 2 * CL_alpha_H * (X_FHexp_bar - X_cg_bar);

end

