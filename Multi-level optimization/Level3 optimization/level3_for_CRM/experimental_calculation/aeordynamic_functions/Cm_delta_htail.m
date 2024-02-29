function y = Cm_delta_htail(CL_alpha_H, kq, S_H, L_H, S, C_A)
% formula(06, 3-1)
% 水平尾翼力矩操纵系数
% CL_alpha_H 采用和机翼相同的计算方法

y = -kq * CL_alpha_H * (S_H*L_H)/(S*C_A);
end

