function y = Clp_wing(Cl_alpha_M, CL_alpha_W_CL, CL_alpha_W_CL0, CL_W, CD0_W,...
    Z, Ma, ka_q, A, lamda, gamma, b)
% formula(06, 10-43)
% ��ת���ᵼ��(����)

% Cl_alpha_M: ĳһMaʱ���������������б��
% CL_alpha_W_CL: ʧ��ǰĳһCL�µ�������б��
% CL_alpha_W_CL0: CL=0ʱ��ĳһ������б��
% CL_W: ��������ϵ��
% CD0_W: ������������ϵ��
% Z: ���زο����ĸ��ڻ����������ߵĴ�ֱ����
% Ma
% ka_q
% A: չ�ұ�
% lamda: �Ҹ���
% gamma: �Ϸ���
% b: չ��

beta = sqrt(1-Ma^2);
K = beta * Cl_alpha_M / (2*pi);
ksi = Z/(0.5*b);
betaC_K = get_betaC_K(Ma, Cl_alpha_M, ka_q, A, lamda);
Clp_CLW2 = get_Clp_CLW2(A, ka_q);
%
ClpW_gamma = -4*ksi*sin(gamma)/(1+3*lamda) *...
    (2 + 4*lamda - 3*ksi*(1+lamda)*sin(gamma)) * (betaC_K * K/beta);
delta_Clp_drag = Clp_CLW2 * (CL_W^2 - 0.125*CD0_W);
%
y = betaC_K * K/beta * CL_alpha_W_CL/CL_alpha_W_CL0 +...
    ClpW_gamma + delta_Clp_drag;

end

