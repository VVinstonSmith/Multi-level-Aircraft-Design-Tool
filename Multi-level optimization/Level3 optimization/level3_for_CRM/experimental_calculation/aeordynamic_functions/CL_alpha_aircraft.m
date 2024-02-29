function y = CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha)
% formula(06, 6-32)
% ȫ��������б��

% CL_alpha_W: ����������б��
% CL_alpha_H: ƽβ������б��
% d_F: ������ֱ��
% b: ����չ��
% S_H_div_S: ƽβ���������
% k_q: ��ѹ��
% d_epslon_d_alpha: ƽβ��ϴ

K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;% �����������
CL_alpha_WF = K_WF * CL_alpha_W;
%
y = CL_alpha_WF;
y = y + k_q * CL_alpha_H * (1-d_epslon_d_alpha) * S_H_div_S;

end

