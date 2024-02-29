function CY_beta_WF = Cy_beta_WingFuse(gamma_deg, Z_W, d_F, A_F0, S)
% formula (06, 9-1)
% 横航向静导数Cy_beta计算(翼身贡献)

% gamma_deg:上反角(度)
% L_F: 机身长度
% A_F0: 机身站位x0处的横截面积
% Z_W: 机身中心到外露翼根弦1/4弦点的距离，1/4弦点在中心以下为正
% d_F: 翼身连接处的最大机身高度
% S: 参考面积
Ki = get_Ki(Z_W, d_F);% Ki: 翼身干扰因子

CY_beta_W = -0.0001 * gamma_deg;
CY_beta_F = -2/57.3 * Ki * (A_F0/S);
CY_beta_WF = CY_beta_W + CY_beta_F;
end

