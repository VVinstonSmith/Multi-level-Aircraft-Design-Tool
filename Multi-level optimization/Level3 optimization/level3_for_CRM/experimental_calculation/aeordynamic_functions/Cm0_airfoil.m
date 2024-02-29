function Cm0 = Cm0_airfoil(x_seq, z_seq, c, Ma, t_bar)
% formula(06, 8-3)
% 翼型零升俯仰力矩估算

% z_m_seq: 中弧线垂直坐标 
% c: 弦长

Cm0 = 0;
position_seq = 0.01.*[0, 2.5, 5, 10, 20, 30, 40, 50,...
    60, 70, 80, 90, 95, 100];
K_seq = [0.238, 0.312, 0.208, 0.248, 0.148, 0.018, -0.09,...
    -0.202, -0.34, -0.546, -0.954, -1.572, -6.052, -9.578]; 
zbar = zeros(size(K_seq));
for ii = 1:length(K_seq)
    z_bar(ii) = interp1(x_seq./c, z_seq./c, position_seq(ii), 'linear');
    Cm0 = Cm0 + K_seq(ii)*z_bar(ii);
end
beta = sqrt(1-Ma^2);
Cm0 = (1/beta + 5.9*Ma^2*t_bar) * Cm0;

end

