function y = Cm_htail(CL_alpha_H, kq, d_epslon_d_alpha, alpha, phi_W, alpha0_W, delta_H, S_H, L_H, S, C_A)
% formula(06, 1-30)
% ˮƽβ������ϵ��(�Ի�������ͻ���ƽ�������ҳ������ٻ�)

% CL_alpha_H: ƽβ������б��
% kq: ��ѹ��
% d_epslon_d_alpha: 
% alpha: ȫ��ӭ��
% S_H: ƽβ���
% L_H: ƽβ����
% S: �������
% C_A: ����ƽ�������ҳ�
y = kq * CL_alpha_H * (alpha - d_epslon_d_alpha*(alpha+phi_W-alpha0_W) + delta_H);

y = kq * CL_alpha_H * ((1-d_epslon_d_alpha)*alpha + delta_H);
y = -y * (S_H*L_H)/(S*C_A);


end

