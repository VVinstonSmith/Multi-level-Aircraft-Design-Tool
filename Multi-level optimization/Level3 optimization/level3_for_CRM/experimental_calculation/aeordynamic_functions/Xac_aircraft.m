function y = Xac_aircraft(CL_alpha_WF, Xac_WF, S, CL_alpha_HF, Xac_HF, S_H, kq, d_epslon_d_alpha)
% formula(06, 8-55)
% ȫ����������X_ac

% CL_alpha_WF: ����������б��
% Xac_WF: ������
% S: �������
% CL_alpha_HF: β��������б��
% Xac_HF: β����
% S_H: ƽβ���
% kq: ƽβ��ѹ�� 
% d_epslon_d_alpha: ƽβ��ϴ��

y = CL_alpha_WF*S*Xac_WF + kq*CL_alpha_HF*(1-d_epslon_d_alpha)*S_H*Xac_HF;
y = y / (CL_alpha_WF*S + kq*CL_alpha_HF*(1-d_epslon_d_alpha)*S_H);

end

