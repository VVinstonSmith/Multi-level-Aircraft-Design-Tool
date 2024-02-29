function y = CD0_wing(R_WF, Ma, ka_thick, Re_W, C_thick_bar, t_bar, S_wetW, S)
% formula(06, 7-2)
% ������������ϵ��

% ka_thick: ��Ժ����󴦵ĺ��ӽ�
% C_thick_bar: ����ȴ�������ҳ�
% Re_W��������ŵ��
% R_WF: �����������(��������Ϊ1)
% R_LS(Ma, ka_thick): ��������������
% C_fW(Ma, Re_W): ��������Ħ��ϵ��
% t_bar: ƽ�������ҳ�������Ժ��
% L_pie(C_thick_bar): ���������λ��
% S_wetW: ����������
% S: �������
if Ma>0.6% �ڿ����ٷ�Χ��,��������������7-2ʽ����,��Ma��0.6
    Ma = 0.6;
end

if C_thick_bar>=0.3
    L_pie = 1.2;
else
    L_pie = 2.0;
end
y = R_WF * get_R_LS(Ma, ka_thick) * get_C_f(Ma, Re_W, 'T');
y = y * (1 + L_pie*t_bar + 100*t_bar^4);
y = y * S_wetW/S;

end

