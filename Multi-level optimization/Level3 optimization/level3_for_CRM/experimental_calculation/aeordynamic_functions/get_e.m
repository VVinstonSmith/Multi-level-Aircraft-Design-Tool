function e = get_e(A, ka_LE)
% formula(06, 7-78)
% 奥斯瓦尔德因子e估算

% ka_LE:  前缘后掠角
e = 4.61 * (1-0.045*A^0.68) * cos(ka_LE)^0.15 - 3.1;

end

