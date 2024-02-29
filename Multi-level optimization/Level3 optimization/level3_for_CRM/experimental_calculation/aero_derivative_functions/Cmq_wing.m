function y = Cmq_wing(CL_alpha_2d, CL_alpha_W, X_F, X_cg, C_A, Ma, A, ka_q)
% formula(06, 10-10)
% ��������ϵ��(����)

% CL_alpha_2d: Ma=0ʱ����ֱ��1/4��������Ķ�ά������б����չ���ƽ��ֵ
% CL_alpha_W: ����������б��
% X_F: ����ƽ��������ǰԵ�������������ĵľ���(1/4*C_A)
% X_cg: ����ƽ��������ǰԵ���ɻ����ĵľ���(���Ϊ��)
% C_A: ����ƽ�������ҳ�
% Ma: �����
% A: չ�ұ�
% ka_q: 1/4�Һ��ӽ�
%
X_F_bar = X_F / C_A;
X_cg_bar = X_cg / C_A;
%
F = get_F_of_Cmq(Ma, A);
beta_pie = sqrt(1 - (Ma*cos(ka_q))^2);
%
Cm_q_quater = -2*CL_alpha_W * (0.25*(X_F_bar-0.25) + (X_F_bar-0.25)^2) +...
    -2*F * (CL_alpha_2d*cos(ka_q)/(48*beta_pie) * (beta_pie*A^3*tan(ka_q)^2)/(beta_pie*A+6*cos(ka_q)) + 3);
%
CL_q_quater = CL_alpha_W * (0.5 + 2*(X_F_bar-0.25));
%
y = Cm_q_quater + CL_q_quater * (X_cg_bar - 0.25)...
    -2*CL_alpha_W * (X_cg_bar-X_F_bar) * (X_cg_bar-0.25);

end