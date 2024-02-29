function CL_alpha_3d = CL_alpha_wing1(CL_alpha_2d, A, Ma, S_exp_div_ref, d_F, b, ka)
% formula(06,1-21)

% CL_alpha_2d
% A: չ�ұ�
% Ma
% S_exp_div_ref: ��¶����Ȳο����
% d_F: ����ֱ��
% b: չ��
% ka:����ȵ����ߺ��ӽ�

beta = sqrt(1-Ma^2);
eta = CL_alpha_2d / (2*pi);
F = 1.07*(1+d_F/b)^2;

CL_alpha_3d = (2*pi*A) /...
    (2 + sqrt(4+(A*beta/eta)^2*(1+tan(ka)^2/beta^2)));
CL_alpha_3d = CL_alpha_3d * S_exp_div_ref * F;

% CL_alpha_3d: �����������б��

end

