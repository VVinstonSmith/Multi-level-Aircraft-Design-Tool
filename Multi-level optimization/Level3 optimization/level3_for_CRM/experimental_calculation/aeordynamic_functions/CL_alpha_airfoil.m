function y = CL_alpha_airfoil(t_bar, tao, Ma)
% formula(06, 6-5)
% 翼型升力线斜率
% t_bar: 相对厚度
% tao: 后缘角(单位为度)

y = 2*pi + 4.7*t_bar*(1+0.00375*tao);
beta = sqrt(1-Ma^2);
y = y/beta;

end

