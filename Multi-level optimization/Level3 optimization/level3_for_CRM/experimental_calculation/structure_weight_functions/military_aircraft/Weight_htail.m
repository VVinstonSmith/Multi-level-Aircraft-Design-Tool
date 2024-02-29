function W_H = Weight_htail(K_m, K_H, n_dz, S_H, L_H, b_H, A_H)
% 平尾重量估算
% formula(08, 2-45)

% K_m: 复材0.9, 金属1.0
% K_H: 鸭翼0.9, 平尾1.0
% n_dz: 设计过载
% S_H: 平尾面积
% L_H: 根弦到飞机对称面的距离
% b_H: 平尾或鸭翼展长
% A_H: 平尾或鸭翼展弦比

W_H = 12.549 * K_m * K_H * (WTO*n_dz/1000)^0.26 * S_H^0.806;
W_H = W_H / (1 + L_H/(b_H*A_H^0.7))^2;

end

