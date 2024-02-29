function y = alpha0_wing(alpha0, alpha0_Ma_fix, tao_w, ka_q, A, lamda)
% formula(06, 6-11)
% 亚声速，机翼零升迎角估算(等翼型，线性扭转分布等翼型，线性扭转分布)

% alpha0: 翼型低速零升迎角
% alpha0_Ma_fix: 根据相对厚度和Ma做压缩性修正
% tao_w: 线性扭转角
% d_alpha0_d_tao: 每度扭转角引起的零升迎角的增量
d_alpha0_d_tao = get_d_alpha0_d_tao(ka_q, A, lamda);

y = (alpha0 + d_alpha0_d_tao*tao_w) * alpha0_Ma_fix;

end

