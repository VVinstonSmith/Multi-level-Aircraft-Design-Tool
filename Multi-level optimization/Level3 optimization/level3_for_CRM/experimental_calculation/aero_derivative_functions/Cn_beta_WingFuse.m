function Cn_beta = Cn_beta_WingFuse(K_WF, Re_F, S_FS, L_F, S, b)
% formula(06, 9-35)
% 偏航力矩对侧滑角的导数(翼身贡献,单位：度)

% K_WF: 翼身干扰因子 
% Re_F: 机身雷诺数
% S_FS: 机身侧面积
% L_F: 机身长度
% S: 机翼面积
% b: 机翼展长
Cn_beta = -K_WF * get_K_RF(Re_F) * (S_FS*L_F)/(S*b);

end

