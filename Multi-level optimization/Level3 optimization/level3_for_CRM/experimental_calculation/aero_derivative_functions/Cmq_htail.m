function y = Cmq_htail(CL_q_H, X_FH, X_cg, C_A)
% formula(06, 10-6)
% ��������ϵ��(ƽβ)

% X_FH: ƽβ����λ��
% X_cg: ����λ��
% CL_q_H: ��CL_q_htail����õ�
% C_A: ƽ�������ҳ�
%
X_FH_bar = X_FH / C_A;
X_cg_bar = X_cg / C_A;
y = -(X_FH_bar - X_cg_bar) * CL_q_H;

end

