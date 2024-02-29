function y = Cl_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha)
% formula(06, 11-12)
% 方向滚转力矩系数

% Cy_delta_r: 方向舵侧力系数
% L_V: 垂尾力臂
% Z_V: 垂尾与机翼的垂直高度差
% B_W: 机翼展长
% alpha: 迎角

y = Cy_delta_r * (Z_V*cos(alpha) - L_V*sin(alpha)) / B_W;

end

