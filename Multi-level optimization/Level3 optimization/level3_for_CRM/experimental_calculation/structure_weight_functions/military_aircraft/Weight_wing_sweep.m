function [Wsf, Wwe, Wri, Wot, W_W] = Weight_wing_sweep(n_mz, p, S_exp, b_exp, ka_half, lamda_exp, A_exp, H_exp)
% 用于跨声速后掠翼 Mig-15 Mig-19 F-86
% formula(08, 2-38)
% formula(08, 2-39)
% formula(08, 2-40)
% formula(08, 2-41)
% Wsf：后掠机翼蒙皮+长桁+梁缘条的重量
% Wwe：翼梁腹板重量
% Wri: 翼肋重量
% Wot: 机翼上其他结构重量
% W_W: 总重

% n_mz: 最大过载
% p: 翼载荷(kg/m^2)
% S_exp: 外露翼面积(m^2)
% b_exp: 外露展长(m)
% ka_half: 1/2: 弦线后掠角
% lamda_exp: 外露机翼梢根比
% A_exp: 外露翼展弦比
% H_exp: 外露翼根弦最大高度(m)
Wsf = 0.51*1e-4 * n_mz * p * S_exp * (0.5*b_exp)^2;
Wsf = Wsf / cos(ka_half)^2;
Wsf = Wsf * (1 + 1/(1/lamda_exp+1)) / H_exp;
%
Wwe = 1.6*1e-4 * n_mz * p * S_exp * (0.5*b_exp);
Wwe = Wwe * (1 + 1/(1/lamda_exp+1)) / cos(ka_half);
%
Wri = 6.8*1e-4 * n_mz * p * S_exp *(0.5*b_exp);
Wri = Wri * cos(ka_half) / A_exp;
%
Wot = 9.973 * S_exp;
%
W_W = 1.1 * (Wsf+Wwe+Wri+Wot);

end

