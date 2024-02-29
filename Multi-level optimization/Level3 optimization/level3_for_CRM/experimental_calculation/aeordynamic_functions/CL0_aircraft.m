function y = CL0_aircraft(d_F, b, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, phi_H, epslon_H)
% formula(06, 6-30)
% ȫ����ӭ������ϵ��

% d_F: ������ֱ��
% b: ����չ��
% CL_alpha_W: ����������б��
% phi_W: ����װ��
% alpha0_W: ��������ӭ��
% CL_alpha_H: ƽβ������б��
% k_q: ��ѹ��
% S_H_div_S: ƽβ���������
% phi_H: ƽβ��װ��
% epslon_H: ƽβ��ϴ��(������������Ϊ��0)

K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;% �����������
CL_alpha_WF = K_WF * CL_alpha_W;
CL0_WF = (phi_W-alpha0_W) * CL_alpha_WF;
y = CL0_WF + CL_alpha_H * k_q * S_H_div_S * (phi_H-epslon_H);

end

