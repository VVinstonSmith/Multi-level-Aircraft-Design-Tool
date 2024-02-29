function alpha = alpha0_aircraft(CL_alpha_WF, alpha0_WF, CL_alpha_HF, S, S_H, phi_W, phi_H, kq, d_epslon_d_alpha, epslon0)
% formula(06, 8-53)
% 全机零升迎角

% CL_alpha_WF: 翼身升力线斜率
% alpha0_WF: 机翼零升迎角
% CL_alpha_HF: 尾身升力线斜率
% S: 机翼面积
% S_H: 平尾面积
% phi_W: 机翼安装角
% phi_H: 平尾安装角
% kq: 平尾动压比
% d_epslon_d_alpha: 平尾下洗率
% epslon0: alpha=0时平尾处的下洗角

% S*CL_alpha_WF*(alpha+phi_W-alpha0_WF) +
% kq*S_H*CL_alpha_HF*(alpha+phi_H-(epslon0+d_epslon_d_alpha*alpha)) = 0
%
% (S*CL_alpha_WF + kq*S_H*CL_alpha_HF*(1-d_epslon_d_alpha)) * alpha +
% S*CL_alpha_WF*(phi_W-alpha0_WF) + kq*S_H*CL_alpha_H*(phi_H-epslon0) = 0
alpha = -(S*CL_alpha_WF*(phi_W-alpha0_WF) + kq*S_H*CL_alpha_HF*(phi_H-epslon0)) /...
    (S*CL_alpha_WF + kq*S_H*CL_alpha_HF*(1-d_epslon_d_alpha));

end

