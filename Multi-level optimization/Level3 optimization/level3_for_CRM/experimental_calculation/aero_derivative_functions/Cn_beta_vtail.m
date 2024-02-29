function Cn_beta_V = Cn_beta_vtail(Cy_beta_V, L_V, Z_V, b, alpha)
% formula(06, 9-42)
% 偏航力矩对侧滑角的导数(垂尾贡献）

% Cy_beta_V: 垂尾侧力系数
% L_V: 垂尾焦点到重心水平距离
% Z_V: 垂尾焦点到重心垂直距离
% b: 机翼展长
% alpha: 配平迎角

Cn_beta_V = -Cy_beta_V * (L_V*cos(alpha)+Z_V*sin(alpha))/b;

end

