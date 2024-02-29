function y = CD0_fuselage(Ma, Re_F, R_WF, L_F, d_F, d_b, S_wetF, S_F, S)
% formula(06, 7-23)
% 机身零升阻力系数计算

% L_F: 机身长度
% d_F: 机身最大直径(非圆截面d_F = sqrt(4*A_F/pi))
% d_b: 机身底部直径
% A_F: 机身最大横截面积
% S_F: 机身参考面积(一般S_F=A_F)
% S_wetF: 机身浸润面积
% S: 飞机参考面积
% R_WF: 翼身干扰因子
% Re_F: 机身雷诺数
% C_fF(Ma, Re_F): 湍流摩擦系数

if Ma>0.6
    Ma = 0.6;
end
C_fF = get_C_f(Ma, Re_F, 'T');

% 摩擦阻力
C_DfF = R_WF * C_fF * S_wetF/S;
% 压差阻力
C_DpF = R_WF * C_fF * S_wetF/S;
C_DpF = C_DpF * (60/(L_F/d_F)^3 + 0.0025*(L_F/d_F));
% 底部阻力
C_DbF = 0.029*(d_b/d_F)^3 / ((C_DfF+C_DpF)*sqrt(S/S_F));
C_DbF = C_DbF * (S_F/S);

y = C_DfF + C_DpF + C_DbF;

end

