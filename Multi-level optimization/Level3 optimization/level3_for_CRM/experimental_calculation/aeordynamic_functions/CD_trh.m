function y = CD_trh(CL_H, CL_E, A_H, e_H, S_H, S)
% formula(06, 7-71)
% 操纵面诱阻CD_trh

% CL_H:平尾升力系数(不算升降舵偏转)
% CL_E:升降舵升力系数
% CL_H，CL_E参考面积都是平尾面积
%
% CL_H = CL_H_alpha * (alpha+phi_H)
% CL_E = CL_delta_e * delta_e
% A_H: 平尾展弦比
% e_H: 平尾展向効率因子(机身平尾取0.5，T形尾取0.75)
% S_H: 平尾面积
% S: 飞机参考面积
y = (CL_H+CL_E)^2 / (pi*A_H*e_H) * S_H/S;

end

