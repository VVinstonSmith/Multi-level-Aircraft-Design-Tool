function Cy_beta_V = Cy_beta_vtail(CL_alpha_V, b_V, r1_double, Z_W, Z_F, S_V, S, ka_q, A)
% formula(06, 9-9)
% 横航向静导数Cy_beta计算(垂尾贡献)

% CL_alpha_V: 垂尾升力线斜率
% b_V: 垂尾展长
% r1_double: 垂尾区域内的机身深度
% K_V(b_V/r1_double):经验因子，picture(06, 9-8)
% Z_W: 机身中心到外露翼根弦1/4弦点的距离，1/4弦点在中心以下为正
% Z_F: 机翼翼根处机身垂直高度
% S_V: 垂尾面积
% S: 机翼面积
% A: 机翼展弦比
% ka_q: 机翼1/4后掠角
%
% formula(06, 9-12)
eta = 0.724;
eta = eta + 3.06*((S_V/S)/(1+cos(ka_q)));
eta = eta + 0.4*Z_W/Z_F;
eta = eta + 0.009*A;
%
% picture(06, 9-8)
if b_V/r1_double < 2 
    K_V = 0.775;
elseif b_V/r1_double > 3.5
    K_V = 1.0;
else
    K_V = 0.775*(3.5-b_V/r1_double) + 1.0*(b_V/r1_double-2);
    K_V = K_V / (3.5-2);
end
Cy_beta_V = -K_V * CL_alpha_V * eta * (S_V/S);

end

