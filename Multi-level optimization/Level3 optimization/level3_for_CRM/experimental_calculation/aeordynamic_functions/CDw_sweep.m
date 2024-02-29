function CDw_swe= CDw_sweep(Ma, t_bar, A, ka_q)
% formula(06, picture7-13)
% 后掠机翼波阻系数

Ma_equal_str = Ma * sqrt(cos(ka_q));
CDw_str = CDw_straight(Ma_equal_str, t_bar, A);
CDw_swe = CDw_str * cos(ka_q)^2.5;

end

