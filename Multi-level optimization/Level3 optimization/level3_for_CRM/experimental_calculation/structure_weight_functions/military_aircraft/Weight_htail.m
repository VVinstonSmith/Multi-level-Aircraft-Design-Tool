function W_H = Weight_htail(K_m, K_H, n_dz, S_H, L_H, b_H, A_H)
% ƽβ��������
% formula(08, 2-45)

% K_m: ����0.9, ����1.0
% K_H: Ѽ��0.9, ƽβ1.0
% n_dz: ��ƹ���
% S_H: ƽβ���
% L_H: ���ҵ��ɻ��Գ���ľ���
% b_H: ƽβ��Ѽ��չ��
% A_H: ƽβ��Ѽ��չ�ұ�

W_H = 12.549 * K_m * K_H * (WTO*n_dz/1000)^0.26 * S_H^0.806;
W_H = W_H / (1 + L_H/(b_H*A_H^0.7))^2;

end

