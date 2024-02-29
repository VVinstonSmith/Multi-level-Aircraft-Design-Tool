function W_V = Weight_vtail(Ke, Kin, q_max, WTO, L_D)
% ������������
% formula(08, 2-43)

% Ke: (������˫��:Ke=1.24, �����ڵ���:Ke=1.0)
% Kin: (����ʽ������:Kin=1.25, ����:Kin=1.0)
% q_max: ���ѹ(N/m^2)
% WTO: �ɻ������������
% L_D: ����ϸ��
W_F = 6.3995 * Ke * Kin^1.42 * (q_max/1000)^0.283;
W_F = W_F * (WTO/1000)^0.95 * L_D^0.71;

end

