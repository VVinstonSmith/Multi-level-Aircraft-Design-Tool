function y = CL_alpha_airfoil(t_bar, tao, Ma)
% formula(06, 6-5)
% ����������б��
% t_bar: ��Ժ��
% tao: ��Ե��(��λΪ��)

y = 2*pi + 4.7*t_bar*(1+0.00375*tao);
beta = sqrt(1-Ma^2);
y = y/beta;

end

