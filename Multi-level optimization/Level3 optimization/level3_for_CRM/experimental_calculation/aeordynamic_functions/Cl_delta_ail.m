function y = Cl_delta_ail(CL_delta_a_2d, CL_alpha_W, Cl_alpha, eta_in, eta_out, lamda, B, C_A)
% formula(06, 6-63)
% 副翼单位偏转产生的三维机翼升力系数增量

% CL_delta_a_2d: 单位襟翼偏角下，翼型升力系数增量
% CL_alpha_W: 机翼升力线斜率
% Cl_alpha: 翼型升力线斜率
% Kb: 展长因子,Kb = Kb_o - Kb_i;
% eta_in: 副翼相对展长(内侧)
% eta_out: 副翼相对展长(外侧)
% B: 机翼展长
% C_A: 平均气动弦长
%
Kb_o = get_Kb(eta_out, lamda);
Kb_i = get_Kb(eta_in, lamda);
Kb = Kb_o - Kb_i;
%
% 认为alpha_delta_CL/alpha_delta_C==1，
% 对于Cf/C=0.2，A>4的情况，alpha_delta_CL/alpha_delta_C<1.1
CL_delta_a = CL_delta_a_2d * CL_alpha_W/Cl_alpha * Kb;% 单个副翼升力系数斜率
%
L_ail = 0.5*(eta_out+eta_in)*(0.5*B);% 副翼力臂
y = 2 * CL_delta_a * L_ail/C_A;

end

