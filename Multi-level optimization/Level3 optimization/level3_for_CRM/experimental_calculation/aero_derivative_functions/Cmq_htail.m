function y = Cmq_htail(CL_q_H, X_FH, X_cg, C_A)
% formula(06, 10-6)
% 俯仰阻尼系数(平尾)

% X_FH: 平尾焦点位置
% X_cg: 重心位置
% CL_q_H: 由CL_q_htail计算得到
% C_A: 平均气动弦长
%
X_FH_bar = X_FH / C_A;
X_cg_bar = X_cg / C_A;
y = -(X_FH_bar - X_cg_bar) * CL_q_H;

end

