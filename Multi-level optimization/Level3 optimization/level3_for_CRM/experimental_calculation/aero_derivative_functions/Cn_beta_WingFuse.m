function Cn_beta = Cn_beta_WingFuse(K_WF, Re_F, S_FS, L_F, S, b)
% formula(06, 9-35)
% ƫ�����ضԲ໬�ǵĵ���(������,��λ����)

% K_WF: ����������� 
% Re_F: ������ŵ��
% S_FS: ��������
% L_F: ������
% S: �������
% b: ����չ��
Cn_beta = -K_WF * get_K_RF(Re_F) * (S_FS*L_F)/(S*b);

end

