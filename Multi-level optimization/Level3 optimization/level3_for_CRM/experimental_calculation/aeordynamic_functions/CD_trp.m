function y = CD_trp(delta_e, Cf_div_C, ka_q, S_ef, S)
% formula(06, 7-70)
% ����������delta_D_trp

% delta_e: ��ƫ��
% Cf_div_C: ��������ҳ�
% ka_q: ������ӽ�
% S_ef: �ж������ƽβ���
% S: �������
delta_e_deg = delta_e * 180/pi;
y = CD_dp(delta_e_deg, Cf_div_C) * cos(ka_q) * (S_ef/S);

end

