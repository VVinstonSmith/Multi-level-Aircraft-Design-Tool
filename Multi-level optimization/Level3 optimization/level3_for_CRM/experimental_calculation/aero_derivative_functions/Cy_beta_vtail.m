function Cy_beta_V = Cy_beta_vtail(CL_alpha_V, b_V, r1_double, Z_W, Z_F, S_V, S, ka_q, A)
% formula(06, 9-9)
% �ẽ�򾲵���Cy_beta����(��β����)

% CL_alpha_V: ��β������б��
% b_V: ��βչ��
% r1_double: ��β�����ڵĻ������
% K_V(b_V/r1_double):�������ӣ�picture(06, 9-8)
% Z_W: �������ĵ���¶�����1/4�ҵ�ľ��룬1/4�ҵ�����������Ϊ��
% Z_F: �������������ֱ�߶�
% S_V: ��β���
% S: �������
% A: ����չ�ұ�
% ka_q: ����1/4���ӽ�
%
% formula(06, 9-12)
eta = 0.724;
eta = eta + 3.06*((S_V/S)/(1+cos(ka_q)));
eta = eta + 0.4*Z_W/Z_F;
eta = eta + 0.009*A;
%
% picture(06, 9-8)
if b_V/r1_double < 2 
    K_V = 0.775;
elseif b_V/r1_double > 3.5
    K_V = 1.0;
else
    K_V = 0.775*(3.5-b_V/r1_double) + 1.0*(b_V/r1_double-2);
    K_V = K_V / (3.5-2);
end
Cy_beta_V = -K_V * CL_alpha_V * eta * (S_V/S);

end

