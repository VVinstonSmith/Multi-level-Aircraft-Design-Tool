function y = get_CL_delta_ail_2d(Cf_C, t_bar)
% formula(06, 6-49)
% ����λƫת�����Ķ�ά��������ϵ������
%
% ���Է�������������K
% ��ΪCl_alpha/Cl_alpha_the==1������Cl_delta/Cl_delta_the==1
%
Cl_delta_the = get_Cl_delta_the(Cf_C, t_bar);
y = Cl_delta_the;

end

