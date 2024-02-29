function y = Cm_delta_elev(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e)
% formula(06, 3-2)
% 升降舵效率

% kq: 动压比
% CL_alpha_H: 平尾升力系数
% S_H: 平尾面积
% L_H: 平尾力臂
% C_A: 平均气动弦长
% S_e: 升降舵面积 
% ka_e: 升降舵前缘后掠角

ne = sqrt(S_e/S_H) * cos(ka_e);
y = -kq * CL_alpha_H * (S_H/S) * (L_H/C_A) * ne;

end

