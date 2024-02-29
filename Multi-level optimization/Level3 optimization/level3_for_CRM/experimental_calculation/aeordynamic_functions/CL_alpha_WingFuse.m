function y = CL_alpha_WingFuse(CL_alpha_W, d_F, b)
% formula(06, 6-33)
% 翼身组合体升力线斜率

% CL_alpha_W: 单独机翼升力线斜率
% d_F: 机身当量直径
% b: 机翼展长
K_WF = 1 + 0.025*(d_F/b) - 0.25*(d_F/b)^2;
y = K_WF * CL_alpha_W;


end

