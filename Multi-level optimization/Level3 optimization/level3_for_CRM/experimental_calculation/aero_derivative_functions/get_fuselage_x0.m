function x0 = get_fuselage_x0(x1, L_F)
% picture(06, 9-5)
% x0:����ճ������ʼ��վλ

% L_F: ������
% x1: d(A_Fx)/dx�ﵽ���ֵ����ʼ��վλ

x0 = 0.378 + 0.527*x1/L_F;
x0 = x0 * L_F;

end

