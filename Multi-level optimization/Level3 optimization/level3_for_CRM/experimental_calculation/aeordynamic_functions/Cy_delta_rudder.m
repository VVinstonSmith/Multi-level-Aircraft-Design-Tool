function y = Cy_delta_rudder(CL_alpha_V_3d, CL_alpha_V_2d, CL_delta_r_2d,...
    eta_in, eta_out, lamda, S_V, S_W)
% formula(06, 11-11)
% ��������ϵ��

% eta: ���չ��
% lamda: �Ҹ���
% Kb = Kb_o-Kb_i = Kb(eta_out, lamda)-Kb(eta_in, lamda): ����չ����������
% CL_alpha_V_3d: ��β������б�� 
% CL_alpha_V_2d:  ��β����������б��
% CL_delta_r_2d: ��ƫ�ǵĶ�ά����ϵ��
% S_V: ��β���
% S_W: �������

Kb_i = get_Kb(eta_in, lamda);
Kb_o = get_Kb(eta_out, lamda);
Kb = Kb_o - Kb_i;
y = Kb * CL_alpha_V_3d * (CL_delta_r_2d/CL_alpha_V_2d) * (S_V/S_W);

end

