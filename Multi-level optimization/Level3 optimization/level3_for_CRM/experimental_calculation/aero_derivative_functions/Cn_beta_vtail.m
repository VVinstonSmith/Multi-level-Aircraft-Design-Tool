function Cn_beta_V = Cn_beta_vtail(Cy_beta_V, L_V, Z_V, b, alpha)
% formula(06, 9-42)
% ƫ�����ضԲ໬�ǵĵ���(��β���ף�

% Cy_beta_V: ��β����ϵ��
% L_V: ��β���㵽����ˮƽ����
% Z_V: ��β���㵽���Ĵ�ֱ����
% b: ����չ��
% alpha: ��ƽӭ��

Cn_beta_V = -Cy_beta_V * (L_V*cos(alpha)+Z_V*sin(alpha))/b;

end

