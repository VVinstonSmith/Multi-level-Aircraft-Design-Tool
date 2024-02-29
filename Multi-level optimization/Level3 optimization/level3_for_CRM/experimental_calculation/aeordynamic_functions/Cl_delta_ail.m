function y = Cl_delta_ail(CL_delta_a_2d, CL_alpha_W, Cl_alpha, eta_in, eta_out, lamda, B, C_A)
% formula(06, 6-63)
% ����λƫת��������ά��������ϵ������

% CL_delta_a_2d: ��λ����ƫ���£���������ϵ������
% CL_alpha_W: ����������б��
% Cl_alpha: ����������б��
% Kb: չ������,Kb = Kb_o - Kb_i;
% eta_in: �������չ��(�ڲ�)
% eta_out: �������չ��(���)
% B: ����չ��
% C_A: ƽ�������ҳ�
%
Kb_o = get_Kb(eta_out, lamda);
Kb_i = get_Kb(eta_in, lamda);
Kb = Kb_o - Kb_i;
%
% ��Ϊalpha_delta_CL/alpha_delta_C==1��
% ����Cf/C=0.2��A>4�������alpha_delta_CL/alpha_delta_C<1.1
CL_delta_a = CL_delta_a_2d * CL_alpha_W/Cl_alpha * Kb;% ������������ϵ��б��
%
L_ail = 0.5*(eta_out+eta_in)*(0.5*B);% ��������
y = 2 * CL_delta_a * L_ail/C_A;

end

