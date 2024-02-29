function Cd = CD_dp(delta_f_deg, Cf_div_C)
% picture(06, 7-44)
% 简单襟翼二维舵面型阻(ka_q=0)

% delta_f: 舵偏角(15-60)
% Cf_div_C: 相对弦长(0.1-0.3)

Cf_div_C_data = [0.1, 0.2, 0.3];
delta_f_deg_data = [0, 15, 60];
Cd_data = [
    0, 0, 0;
    7.13*1e-3, 0.0162, 0.0286;
    0.062, 0.136, 0.22];

Cd = interp2(Cf_div_C_data, delta_f_deg_data, Cd_data,...
    Cf_div_C, delta_f_deg, 'Linear');

end

