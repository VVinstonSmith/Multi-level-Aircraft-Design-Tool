function y = CD_trp(delta_e, Cf_div_C, ka_q, S_ef, S)
% formula(06, 7-70)
% 操纵面形阻delta_D_trp

% delta_e: 舵偏角
% Cf_div_C: 舵面相对弦长
% ka_q: 舵轴后掠角
% S_ef: 有舵区域的平尾面积
% S: 机翼面积
delta_e_deg = delta_e * 180/pi;
y = CD_dp(delta_e_deg, Cf_div_C) * cos(ka_q) * (S_ef/S);

end

