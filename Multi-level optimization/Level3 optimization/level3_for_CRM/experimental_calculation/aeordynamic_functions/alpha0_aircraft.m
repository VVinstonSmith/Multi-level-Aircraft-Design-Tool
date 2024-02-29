function alpha = alpha0_aircraft(CL_alpha_WF, alpha0_WF, CL_alpha_HF, S, S_H, phi_W, phi_H, kq, d_epslon_d_alpha, epslon0)
% formula(06, 8-53)
% ȫ������ӭ��

% CL_alpha_WF: ����������б��
% alpha0_WF: ��������ӭ��
% CL_alpha_HF: β��������б��
% S: �������
% S_H: ƽβ���
% phi_W: ����װ��
% phi_H: ƽβ��װ��
% kq: ƽβ��ѹ��
% d_epslon_d_alpha: ƽβ��ϴ��
% epslon0: alpha=0ʱƽβ������ϴ��

% S*CL_alpha_WF*(alpha+phi_W-alpha0_WF) +
% kq*S_H*CL_alpha_HF*(alpha+phi_H-(epslon0+d_epslon_d_alpha*alpha)) = 0
%
% (S*CL_alpha_WF + kq*S_H*CL_alpha_HF*(1-d_epslon_d_alpha)) * alpha +
% S*CL_alpha_WF*(phi_W-alpha0_WF) + kq*S_H*CL_alpha_H*(phi_H-epslon0) = 0
alpha = -(S*CL_alpha_WF*(phi_W-alpha0_WF) + kq*S_H*CL_alpha_HF*(phi_H-epslon0)) /...
    (S*CL_alpha_WF + kq*S_H*CL_alpha_HF*(1-d_epslon_d_alpha));

end

