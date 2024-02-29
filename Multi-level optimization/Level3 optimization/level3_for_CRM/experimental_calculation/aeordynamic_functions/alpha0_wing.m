function y = alpha0_wing(alpha0, alpha0_Ma_fix, tao_w, ka_q, A, lamda)
% formula(06, 6-11)
% �����٣���������ӭ�ǹ���(�����ͣ�����Ťת�ֲ������ͣ�����Ťת�ֲ�)

% alpha0: ���͵�������ӭ��
% alpha0_Ma_fix: ������Ժ�Ⱥ�Ma��ѹ��������
% tao_w: ����Ťת��
% d_alpha0_d_tao: ÿ��Ťת�����������ӭ�ǵ�����
d_alpha0_d_tao = get_d_alpha0_d_tao(ka_q, A, lamda);

y = (alpha0 + d_alpha0_d_tao*tao_w) * alpha0_Ma_fix;

end

