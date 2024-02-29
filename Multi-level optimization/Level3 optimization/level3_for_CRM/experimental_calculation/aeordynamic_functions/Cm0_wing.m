function y = Cm0_wing(A, lamda, ka_q, Cm0_r, Cm0_t, tao, Ma)
% formula(06, 8-11)
% �����������ع���
% Cm0һ������Դ�����ͣ���һ������Դ�ڻ����Ťת��ƽ����״��
% ��չ�ұȴ���2.5�����ӽ�С��45�ȣ�����Ťתʱ��������ʽ����������ʱ����������

% A: չ�ұ�
% lamda: �Ҹ���
% ka_q: 1/4�Һ��ӽ�
% Cm0_r: ����������������
% Cm0_t: �Ҳ�������������
% tao: Ťת��
% Ma: �����

y = A*cos(ka_q)^2 / (A+2*cos(ka_q));
y = y * 0.5*(Cm0_r+Cm0_t);
y = y + tao * get_d_Cm0_d_tao(ka_q, A, lamda);
y = y * get_Cm0_M_div_M0(Ma);
end

