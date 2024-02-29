function y = get_Swet_wing(S_exp, t_bar)
% formula(06, 7-79)
% 机翼浸润面积估算

% S_exp: 机身以外的机翼面积
if t_bar<0.05
    y = 2.003 * S_exp;
else
    y = (1.977 + 0.52*t_bar) * S_exp;
end
end

