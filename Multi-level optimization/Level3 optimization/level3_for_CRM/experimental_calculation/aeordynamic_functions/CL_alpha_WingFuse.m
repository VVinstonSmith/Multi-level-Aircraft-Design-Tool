function y = CL_alpha_WingFuse(CL_alpha_W, d_F, b)
% formula(06, 6-33)
% ���������������б��

% CL_alpha_W: ��������������б��
% d_F: ������ֱ��
% b: ����չ��
K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;
y = K_WF * CL_alpha_W;


end

