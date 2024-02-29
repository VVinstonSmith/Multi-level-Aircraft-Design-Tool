function CY_beta_WF = Cy_beta_WingFuse(gamma_deg, Z_W, d_F, A_F0, S)
% formula (06, 9-1)
% �ẽ�򾲵���Cy_beta����(������)

% gamma_deg:�Ϸ���(��)
% L_F: ������
% A_F0: ����վλx0���ĺ�����
% Z_W: �������ĵ���¶�����1/4�ҵ�ľ��룬1/4�ҵ�����������Ϊ��
% d_F: �������Ӵ���������߶�
% S: �ο����
Ki = get_Ki(Z_W, d_F);% Ki: �����������

CY_beta_W = -0.0001 * gamma_deg;
CY_beta_F = -2/57.3 * Ki * (A_F0/S);
CY_beta_WF = CY_beta_W + CY_beta_F;
end

