function y = CD_trh(CL_H, CL_E, A_H, e_H, S_H, S)
% formula(06, 7-71)
% ����������CD_trh

% CL_H:ƽβ����ϵ��(����������ƫת)
% CL_E:����������ϵ��
% CL_H��CL_E�ο��������ƽβ���
%
% CL_H = CL_H_alpha * (alpha+phi_H)
% CL_E = CL_delta_e * delta_e
% A_H: ƽβչ�ұ�
% e_H: ƽβչ��������(����ƽβȡ0.5��T��βȡ0.75)
% S_H: ƽβ���
% S: �ɻ��ο����
y = (CL_H+CL_E)^2 / (pi*A_H*e_H) * S_H/S;

end

