function y = Cy_delta_rudder(CL_alpha_V_3d, CL_alpha_V_2d, CL_delta_r_2d,...
    eta_in, eta_out, lamda, S_V, S_W)
% formula(06, 11-11)
% 方向舵侧力系数

% eta: 相对展长
% lamda: 梢根比
% Kb = Kb_o-Kb_i = Kb(eta_out, lamda)-Kb(eta_in, lamda): 舵面展长修正因子
% CL_alpha_V_3d: 垂尾升力线斜率 
% CL_alpha_V_2d:  垂尾剖面升力线斜率
% CL_delta_r_2d: 舵偏角的二维升力系数
% S_V: 垂尾面积
% S_W: 机翼面积

Kb_i = get_Kb(eta_in, lamda);
Kb_o = get_Kb(eta_out, lamda);
Kb = Kb_o - Kb_i;
y = Kb * CL_alpha_V_3d * (CL_delta_r_2d/CL_alpha_V_2d) * (S_V/S_W);

end

