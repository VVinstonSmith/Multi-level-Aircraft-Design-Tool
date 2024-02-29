function y = Xac_aircraft(CL_alpha_WF, Xac_WF, S, CL_alpha_HF, Xac_HF, S_H, kq, d_epslon_d_alpha)
% formula(06, 8-55)
% 全机气动中心X_ac

% CL_alpha_WF: 翼身升力线斜率
% Xac_WF: 翼身焦点
% S: 机翼面积
% CL_alpha_HF: 尾身升力线斜率
% Xac_HF: 尾身焦点
% S_H: 平尾面积
% kq: 平尾动压比 
% d_epslon_d_alpha: 平尾下洗率

y = CL_alpha_WF*S*Xac_WF + kq*CL_alpha_HF*(1-d_epslon_d_alpha)*S_H*Xac_HF;
y = y / (CL_alpha_WF*S + kq*CL_alpha_HF*(1-d_epslon_d_alpha)*S_H);

end

