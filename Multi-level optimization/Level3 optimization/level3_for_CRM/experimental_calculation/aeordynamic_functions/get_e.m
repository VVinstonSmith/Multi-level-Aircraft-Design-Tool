function e = get_e(A, ka_LE)
% formula(06, 7-78)
% ��˹�߶�������e����

% ka_LE:  ǰԵ���ӽ�
e = 4.61 * (1-0.045*A^0.68) * cos(ka_LE)^0.15 - 3.1;

end

