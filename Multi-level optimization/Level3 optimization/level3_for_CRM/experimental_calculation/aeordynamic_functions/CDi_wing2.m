function y = CDi_wing2(CL_W, A, e)
% formula(06, 7-4)
% 机翼升致阻力系数(忽略扭转带来的零升和诱导阻力因子)

% CL_W: 单独机翼升力系数
% A: 展弦比
% e: 展向效率因子
% tao_w:扭转角(梢部相对根部)
y = CL_W^2 / (pi*A*e);


end

