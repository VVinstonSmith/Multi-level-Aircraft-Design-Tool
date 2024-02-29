function [alpha, delta] = trim_Longitudinal_rigid(trim_way, mass, g,...
    Xg, Xf_W, Xf_H,...
    S, S_H, C,...
    CL_alpha_W, CL_alpha_H, CL_delta_e, Cm_delta_e, Cm0_W, alpha0_W,...
    phi_W,phi_H,...
    rho, V, kq, d_epslon_d_alpha)

% 配平手段 trim_way: 'htail', 'delta_e'
% 配平变量: alpha, delta_H
%
% 质量 mass
% g 重力加速度
% 质心位置 Xg;
% 机翼焦点位置 Xf_W
% 平尾焦点位置 Xf_H
% 翼面积 S, S_H
% 平均弦长 C, C_H
% 机翼升力线斜率 CL_alpha_W
% 平尾升力线斜率 CL_alpha_H
% 升降舵升力线斜率 CL_delta_e(对机翼面积无量纲之后)
% 升降舵力矩线斜率 Cm_delta_e(对机翼面积和机翼弦长无量纲之后,相对全机质心)
% 机翼零升力矩系数 Cm0_W
% 机翼零升迎角 alpha0_W
% 机翼安装角 phi_W
% 平尾安装角 phi_H
% ka: 平尾动压比
% d_eplson_d_alpha: 平尾下洗率

% 1, trim_way = 'htail'
% alpha_W = alpha + phi_W
% alpha_H = alpha + phi_H + delta_H
% CL_W = CL_alpha_W * (alpha_W - alpha0_W)
% CL_H = CL_alpha_H * alpha_H
% 
% CL = CL_W + kq*CL_H*(S_H/S)
%    = CL_alpha_W*(alpha+phi_W-alpha0_W) + kq*CL_alpha_H*(alpha+phi_H+delta_H-d_epslon_d_alpha*alpha)*(S_H/S)
%    = (mass*g)/(0.5*rho*V*V*S)
% Cm = CL_W*(Xg-Xf_W)/C + Cm0_W + kq*CL_H*(Xg-Xf_H)/C*(S_H/S)
%    = CL_alpha_W*(alpha+phi_W-alpha0_W)*(Xg-Xf_W)/C + Cm0_W + kq*CL_alpha_H*(alpha+phi_H+delta_H-d_epslon_d_alpha*alpha)*(Xg-Xf_H)/C*(S_H/S)
%    = 0 
% [CL_alpha_W+kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S), kq*CL_alpha_H*(S_H/S)] * [alpha; delta_H] =
% (mass*g)/(0.5*rho*V*V*S) - CL_alpha_W*(phi_W-alpha0_W) - kq*CL_alpha_H*(phi_H)*(S_H/S)
%
% [CL_alpha_W*(Xg-Xf_W)/C+kq*CL_alpha_H*(1-d_epslon_d_alpha)*(Xg-Xf_H)/C*(S_H/S), kq*CL_alpha_H*(Xg-Xf_H)/C*(S_H/S)] * [alpha; delta_H] = 
% -CL_alpha_W*(phi_W-alpha0_W)*(Xg-Xf_W)/C - Cm0_W - kq*CL_alpha_H*phi_H*(Xg-Xf_H)/C*(S_H/S)

% 2, trim_way = 'delta_e'
% alpha_W = alpha + phi_W
% alpha_H = alpha + phi_H
% CL_W = CL_alpha_W * (alpha_W - alpha0_W)
% CL_H = CL_alpha_H * alpha_H
% CL_E = CL_delta_e * delta_e
% Cm_E = Cm_delta_e * delta_e
% 
% CL = CL_W + CL_H*(S_H/S) + CL_E;
%    = CL_alpha_W*(alpha+phi_W-alpha0_W) + kq*CL_alpha_H*(alpha+phi_H-d_eplson_d_alpha*alpha)*(S_H/S) + kq*CL_delta_e*delta_e
%    = (mass*g)/(0.5*rho*V*V*S)
% Cm = CL_W*(Xg-Xf_W)/C + Cm0_W + CL_H*(Xg-Xf_H)/C*(S_H/S) + Cm_delta_e * delta_e
%    = CL_alpha_W*(alpha+phi_W-alpha0_W)*(Xg-Xf_W)/C + Cm0_W + kq*CL_alpha_H*(alpha + phi_H - d_epslon_d_alpha*alpha)*(Xg-Xf_H)/C*(S_H/S) + kq*Cm_delta_e*delta_e
%    = 0 
% [CL_alpha_W+kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S), kq*CL_delta_e] * [alpha; delta_e] =
% (mass*g)/(0.5*rho*V*V*S) - CL_alpha_W*(phi_W-alpha0_W) - kq*CL_alpha_H*phi_H*(S_H/S)
%
% [CL_alpha_W*(Xg-Xf_W)/C+kq*CL_alpha_H*(1-d_epslon_d_alpha)*(Xg-Xf_H)/C*(S_H/S), kq*Cm_delta_e] * [alpha; delta_e] =
% -CL_alpha_W*(phi_W-alpha0_W)*(Xg-Xf_W)/C - Cm0_W - kq*CL_alpha_H*phi_H*(Xg-Xf_H)/C*(S_H/S)

if strcmp(trim_way, 'htail')
    A = [CL_alpha_W + kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S), kq*CL_alpha_H*(S_H/S);
    CL_alpha_W*(Xg-Xf_W)/C + kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S)*(Xg-Xf_H)/C, kq*CL_alpha_H*(S_H/S)*(Xg-Xf_H)/C];
    b = [(mass*g)/(0.5*rho*V*V*S) - CL_alpha_W*(phi_W-alpha0_W) - kq*CL_alpha_H*(phi_H)*(S_H/S);
    -CL_alpha_W*(phi_W-alpha0_W)*(Xg-Xf_W)/C - Cm0_W - kq*CL_alpha_H*phi_H*(S_H/S)*(Xg-Xf_H)/C];
    x = A\b;
    alpha = x(1);
    delta_H = x(2);
    delta = delta_H;
    %
    CL = CL_alpha_W*(alpha+phi_W-alpha0_W) + kq*CL_alpha_H*(alpha+phi_H+delta_H-d_epslon_d_alpha*alpha)*(S_H/S);
    CL_target = (mass*g)/(0.5*rho*V*V*S);
    Cm = CL_alpha_W*(alpha+phi_W-alpha0_W)*(Xg-Xf_W)/C + Cm0_W + kq*CL_alpha_H*(alpha+phi_H+delta_H-d_epslon_d_alpha*alpha)*(Xg-Xf_H)/C*(S_H/S);
elseif strcmp(trim_way, 'delta_e')
    A = [CL_alpha_W + kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S), kq*CL_delta_e;
        CL_alpha_W*(Xg-Xf_W)/C + kq*CL_alpha_H*(1-d_epslon_d_alpha)*(S_H/S)*(Xg-Xf_H)/C, kq*Cm_delta_e];
    b = [(mass*g)/(0.5*rho*V*V*S) - CL_alpha_W*(phi_W-alpha0_W) - kq*CL_alpha_H*phi_H*(S_H/S);
        -CL_alpha_W*(phi_W-alpha0_W)*(Xg-Xf_W)/C - Cm0_W - kq*CL_alpha_H*phi_H*(Xg-Xf_H)/C*(S_H/S)];
    x = A\b;
    alpha = x(1);
    delta_e = x(2);
    delta = delta_e;
    %
    CL = CL_alpha_W*(alpha+phi_W-alpha0_W) + kq*CL_alpha_H*(alpha+phi_H-d_epslon_d_alpha*alpha)*(S_H/S) + kq*CL_delta_e*delta_e;
    CL_target = (mass*g)/(0.5*rho*V*V*S);
	Cm = CL_alpha_W*(alpha+phi_W-alpha0_W)*(Xg-Xf_W)/C + Cm0_W + kq*CL_alpha_H*(alpha+phi_H-d_epslon_d_alpha*alpha)*(Xg-Xf_H)/C*(S_H/S) + kq*Cm_delta_e*delta_e;
end

end

