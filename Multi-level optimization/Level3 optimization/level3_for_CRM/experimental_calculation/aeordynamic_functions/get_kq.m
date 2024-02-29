function kq = get_kq(X_H, gamma_H, C_A, CD0_W, CL_W, A, alpha_W)
% formula(06, 6-36)
% ƽβ��ѹ��kq

% XH: ������Һ�Ե��ƽβ1/4�ҵ㴦 ��β�������߷���ľ���
% gamma_H: ������Һ�Ե��ƽβ1/4�ҵ����� �� �������߼н�
% C_A: ����ƽ�������ҳ�
% CD0_W: ������������ϵ��
% CL_W: ��������ϵ��
% alpha_W: ����ӭ��
% A: չ�ұ� 

Z_w = 0.68 * C_A * sqrt(CD0_W*(X_H/C_A+0.15));

epslon_CL = 92.83 * CL_W/(pi*A);
Z_H = X_H * tan(gamma_H + epslon_CL - alpha_W);

kq = cos(0.5*pi*Z_H/Z_w)^2 * 2.42 * sqrt(CD0_W);
kq = kq / (X_H/C_A+0.3);
kq = 1-kq;


end

