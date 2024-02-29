function Cd_i = CDi_wing1(CL,A)
% formula(06,1-22)
% 机翼诱导阻力系数

% 梢根比0.33--0.5的梯形翼
delta = 0.318;

Cd_i = CL^2/(pi*A) * (1+delta);

end

