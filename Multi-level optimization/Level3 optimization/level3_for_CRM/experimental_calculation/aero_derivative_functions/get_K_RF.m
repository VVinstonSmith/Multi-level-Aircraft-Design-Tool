function y = get_K_RF(Re_F)
% picture(06, 9-31)
% Cn_beta公式中的雷诺数影响修正因子

x = Re_F * 1e-6;
x = log10(x);

x_data = [log10(1), log10(350)];
y_data = [1.0, 2.2];

y = interp1(x_data, y_data, x, 'Linear');

end

