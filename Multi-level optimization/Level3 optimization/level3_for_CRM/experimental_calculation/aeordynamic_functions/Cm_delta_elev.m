function y = Cm_delta_elev(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e)
% formula(06, 3-2)
% ������Ч��

% kq: ��ѹ��
% CL_alpha_H: ƽβ����ϵ��
% S_H: ƽβ���
% L_H: ƽβ����
% C_A: ƽ�������ҳ�
% S_e: ��������� 
% ka_e: ������ǰԵ���ӽ�

ne = sqrt(S_e/S_H) * cos(ka_e);
y = -kq * CL_alpha_H * (S_H/S) * (L_H/C_A) * ne;

end

