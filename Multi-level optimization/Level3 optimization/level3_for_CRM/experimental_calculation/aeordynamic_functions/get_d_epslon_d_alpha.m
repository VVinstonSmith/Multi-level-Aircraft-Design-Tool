function y = get_d_epslon_d_alpha(A, lamda, b, ka_q, h_H, L_H, CL_alpha_W, CL_alpha_W_M0)
% formula(06,6-42)
% ƽβ��ϴӭ�Ǳ仯��

% A: չ�ұ�
% lamda: �Ҹ���
% b: չ��
% ka_q: �ķ�֮һ���ߺ��ӽ�
% h_H: ƽβ�����Ĵ�ֱ�߶Ȳ�
% L_H: ƽβ������������ˮƽ����
% CL_alpha_W: ����ѹ���ԵĻ���������б��
% CL_alpha_W_M0: Ma=0ʱ�Ļ���������б��

K_A = 1/A - 1/(1+A^1.7);
K_lamda = (10-3*lamda)/7;
K_H = (1-h_H/b) / (2*L_H/b)^(1/3);
y = 4.44 * (K_A*K_lamda*K_H*sqrt(cos(ka_q)))^1.19;
y = y * CL_alpha_W/CL_alpha_W_M0;

end

