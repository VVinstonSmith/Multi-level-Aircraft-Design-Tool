function y = get_Swet_wing(S_exp, t_bar)
% formula(06, 7-79)
% ��������������

% S_exp: ��������Ļ������
if t_bar<0.05
    y = 2.003 * S_exp;
else
    y = (1.977 + 0.52*t_bar) * S_exp;
end
end

