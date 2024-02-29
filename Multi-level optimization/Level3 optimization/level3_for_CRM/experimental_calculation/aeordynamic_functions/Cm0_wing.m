function y = Cm0_wing(A, lamda, ka_q, Cm0_r, Cm0_t, tao, Ma)
% formula(06, 8-11)
% 机翼零升力矩估算
% Cm0一部分来源于翼型，另一部分来源于机翼的扭转和平面形状。
% 当展弦比大于2.5，后掠角小于45度，线性扭转时，可用下式估算机翼低速时的零升力矩

% A: 展弦比
% lamda: 梢根比
% ka_q: 1/4弦后掠角
% Cm0_r: 根部翼型零升力矩
% Cm0_t: 梢部翼型零升力矩
% tao: 扭转角
% Ma: 马赫数

y = A*cos(ka_q)^2 / (A+2*cos(ka_q));
y = y * 0.5*(Cm0_r+Cm0_t);
y = y + tao * get_d_Cm0_d_tao(ka_q, A, lamda);
y = y * get_Cm0_M_div_M0(Ma);
end

