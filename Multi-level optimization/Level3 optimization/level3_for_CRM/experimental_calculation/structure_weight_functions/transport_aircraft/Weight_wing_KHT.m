function W_W = Weight_wing_KHT(W_mTO, S_W, ka_q, A, t_bar_r, V_mD, K_lge, W_ep, a, b)
% 机翼重量估算（KHT方法)
% formula(08, 2-51)

% W_W: 机翼重量,单位kg
% W_mTO: 最大起飞重量,单位t 
% S_W: 机翼面积,m^2
% ka_q: 1/4弦线后掠角
% A: 展弦比
% t_bar_r: 机翼根部相对厚度
% V_mD: 最大俯冲速度
% K_lge: 
%     机翼上无起落架无发动机:0
%     机翼上无起落架有发动机:0.2
%     机翼上有起落架无发动机:0.4
%     机翼上有起落架有发动机:0.6
% W_ep: 法定及及挂架组件的重量,单位t 
% a: 发动机挂架距飞机中心线距离
% b: 机翼展长
K_rl = 0; %卸载系数
for ii = 1:length(W_ep)
    K_rl = K_rl + (W_ep(ii)*2*a(ii)/b) / (0.3*W_mTO);
end
%
W_W = 19.938 * W_mTO^0.389 * S_W^0.843 / (1+cos(ka_q))^1.017;
W_W = W_W * A^0.192 * t_bar_r^(-0.098) * (0.01*V_mD)^0.232;
W_W = W_W * (1+K_lge)^0.407 / (1+K_rl)^1.159;

end

