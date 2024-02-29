function y = CD0_wing(R_WF, Ma, ka_thick, Re_W, C_thick_bar, t_bar, S_wetW, S)
% formula(06, 7-2)
% 机翼零升阻力系数

% ka_thick: 相对厚度最大处的后掠角
% C_thick_bar: 最大厚度处的相对弦长
% Re_W：机翼雷诺数
% R_WF: 翼身干扰因子(单独机翼为1)
% R_LS(Ma, ka_thick): 升力面修正因子
% C_fW(Ma, Re_W): 机翼湍流摩擦系数
% t_bar: 平均几何弦长处的相对厚度
% L_pie(C_thick_bar): 翼型最大厚度位置
% S_wetW: 机翼浸润面积
% S: 机翼面积
if Ma>0.6% 在跨声速范围内,机翼零升阻力按7-2式计算,但Ma用0.6
    Ma = 0.6;
end

if C_thick_bar>=0.3
    L_pie = 1.2;
else
    L_pie = 2.0;
end
y = R_WF * get_R_LS(Ma, ka_thick) * get_C_f(Ma, Re_W, 'T');
y = y * (1 + L_pie*t_bar + 100*t_bar^4);
y = y * S_wetW/S;

end

