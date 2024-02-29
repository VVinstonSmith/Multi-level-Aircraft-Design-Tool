function x0 = get_fuselage_x0(x1, L_F)
% picture(06, 9-5)
% x0:机身粘性流起始点站位

% L_F: 机身长度
% x1: d(A_Fx)/dx达到最大负值的起始点站位

x0 = 0.378 + 0.527*x1/L_F;
x0 = x0 * L_F;

end

