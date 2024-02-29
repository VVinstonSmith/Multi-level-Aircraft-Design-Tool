function kq = get_kq(X_H, gamma_H, C_A, CD0_W, CL_W, A, alpha_W)
% formula(06, 6-36)
% 平尾动压比kq

% XH: 机翼根弦后缘到平尾1/4弦点处 沿尾迹中心线方向的距离
% gamma_H: 机翼根弦后缘到平尾1/4弦点连线 与 机翼弦线夹角
% C_A: 机翼平均气动弦长
% CD0_W: 机翼零升阻力系数
% CL_W: 机翼升力系数
% alpha_W: 机翼迎角
% A: 展弦比 

Z_w = 0.68 * C_A * sqrt(CD0_W*(X_H/C_A+0.15));

epslon_CL = 92.83 * CL_W/(pi*A);
Z_H = X_H * tan(gamma_H + epslon_CL - alpha_W);

kq = cos(0.5*pi*Z_H/Z_w)^2 * 2.42 * sqrt(CD0_W);
kq = kq / (X_H/C_A+0.3);
kq = 1-kq;


end

