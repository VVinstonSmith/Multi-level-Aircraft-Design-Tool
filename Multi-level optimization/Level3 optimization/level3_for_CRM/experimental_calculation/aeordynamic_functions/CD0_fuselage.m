function y = CD0_fuselage(Ma, Re_F, R_WF, L_F, d_F, d_b, S_wetF, S_F, S)
% formula(06, 7-23)
% ������������ϵ������

% L_F: ������
% d_F: �������ֱ��(��Բ����d_F = sqrt(4*A_F/pi))
% d_b: ����ײ�ֱ��
% A_F: ������������
% S_F: ����ο����(һ��S_F=A_F)
% S_wetF: ����������
% S: �ɻ��ο����
% R_WF: �����������
% Re_F: ������ŵ��
% C_fF(Ma, Re_F): ����Ħ��ϵ��

if Ma>0.6
    Ma = 0.6;
end
C_fF = get_C_f(Ma, Re_F, 'T');

% Ħ������
C_DfF = R_WF * C_fF * S_wetF/S;
% ѹ������
C_DpF = R_WF * C_fF * S_wetF/S;
C_DpF = C_DpF * (60/(L_F/d_F)^3 + 0.0025*(L_F/d_F));
% �ײ�����
C_DbF = 0.029*(d_b/d_F)^3 / ((C_DfF+C_DpF)*sqrt(S/S_F));
C_DbF = C_DbF * (S_F/S);

y = C_DfF + C_DpF + C_DbF;

end

