function CL_q = CL_q_htail(CL_alpha_Hexp, kq, C_A, X_FHexp, X_cg, d_F, b_H, S_Hexp, S)
% formula(0.6, 10-6)
% �������ٶ�����������(ƽβ����)

% CL_alpha_H: ���������ʱ��ƽβ������б��
% CL_alpha_Hexp: ��¶ƽβ������б��(����Ϊƽβ������) 
% kq: ƽβ��ѹ��
% C_A: ����ƽ�������ҳ�
% X_FHexp: ƽβ��¶��������Xλ��
% X_cg: ���ĵ�Xλ��
% d_F: ƽβ��������ֱ��
% b_H: ƽβչ��
% K_HF(d_F/b_H): β���������
% S_Hexp: ƽβ��¶���
% S: �������
X_FHexp_bar = X_FHexp / C_A;
X_cg_bar = X_cg / C_A;
%
K_HF = 1 + 0.025*(d_F/b_H) - 0.25*(d_F/b_H)^2;
CL_alpha_H = CL_alpha_Hexp * K_HF * S_Hexp/S * kq;
CL_q = 2 * CL_alpha_H * (X_FHexp_bar - X_cg_bar);

end

