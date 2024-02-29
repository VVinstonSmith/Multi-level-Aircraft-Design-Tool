function y = get_Swet_fuselage(K, S_bis, S_sis)
% formula(06, 7-81)
% 机身浸润面积估算

% 椭圆形截面K=pi，矩形截面K=4，一般截面K=3.4
% S_bis: 俯视投影面积
% S_sis: 侧视投影面积
 y = K*(S_bis+S_sis)/2;

end

