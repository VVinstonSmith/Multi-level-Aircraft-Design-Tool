function y = Cm_delta_htail(CL_alpha_H, kq, S_H, L_H, S, C_A)
% formula(06, 3-1)
% ˮƽβ�����ز���ϵ��
% CL_alpha_H ���úͻ�����ͬ�ļ��㷽��

y = -kq * CL_alpha_H * (S_H*L_H)/(S*C_A);
end

