function CL_q_wing = CL_q_wing(C_A, CL_alpha_W, X_F, X_cg)
% formula(0.6, 10-3)(���� delta_X_F_bar)
% �������ٶ�����������(������)

% C_A: ����ƽ�������ҳ�
% CL_alpha_W: ����������б��
% CL_q_quater(CL_alpha_W, X_F_bar): �����ƽ��������1/4�ҵ������ϵ������
% X_F: ����ƽ��������ǰԵ�������������ĵľ���(1/4*C_A)
% X_cg: ����ƽ��������ǰԵ���ɻ����ĵľ���(���Ϊ��)
X_F_bar = X_F / C_A;
X_cg_bar = X_cg / C_A;
%
CL_q_quater = 0.5 + 2*(X_F_bar-0.25);
CL_q_quater = CL_q_quater * CL_alpha_W;
%
CL_q_wing = CL_q_quater - 2*CL_alpha_W*(X_cg_bar - 0.25);

end

