function y = Cl_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha)
% formula(06, 11-12)
% �����ת����ϵ��

% Cy_delta_r: ��������ϵ��
% L_V: ��β����
% Z_V: ��β�����Ĵ�ֱ�߶Ȳ�
% B_W: ����չ��
% alpha: ӭ��

y = Cy_delta_r * (Z_V*cos(alpha) - L_V*sin(alpha)) / B_W;

end

