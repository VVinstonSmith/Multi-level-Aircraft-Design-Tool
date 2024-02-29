function y = CL_delta_H(kq, CL_alpha_H, S_H, S)
% 水平尾翼升力操纵系数

y = kq * CL_alpha_H * S_H/S;

end

