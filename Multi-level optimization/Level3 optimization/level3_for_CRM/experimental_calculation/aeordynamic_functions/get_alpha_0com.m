function y = get_alpha_0com(alpha0, alpha0_Ma_fix)
% formula(06, 6-3)
% 翼型高亚声速零升迎角修正

% alpha0: 机翼低速零升迎角
% alpha0_Ma_fix: 根据相对厚度和Ma做压缩性修正
y = alpha0 * alpha0_Ma_fix;

end

