function y = get_Swet_fuselage(K, S_bis, S_sis)
% formula(06, 7-81)
% ��������������

% ��Բ�ν���K=pi�����ν���K=4��һ�����K=3.4
% S_bis: ����ͶӰ���
% S_sis: ����ͶӰ���
 y = K*(S_bis+S_sis)/2;

end

