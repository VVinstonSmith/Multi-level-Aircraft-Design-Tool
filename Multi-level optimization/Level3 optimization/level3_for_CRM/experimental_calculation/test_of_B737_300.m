clear;clc;
close all;
addpath(genpath('aeordynamic_functions'));
addpath(genpath('aero_derivative_functions'));


%Boeing737-300
Sref = 105.45;%机翼面积
mass = 595*Sref;
Thrust = 0.317*mass;
Ma = 0.745;%巡航马赫数
height = 10000;
T = -50 + 273.15;
rho = 0.4127;
mu = 1.46 * 1e-5;%空气粘度(-50°)
a = sqrt(1.4*287.14*T);
V = Ma * a;

%% wing
A = 8.83;%展弦比
lamda = 0.31;%梢根比
B = sqrt(Sref*A);%展长
ka_f = 25 * pi/180;%前缘后掠角
ka_q = tan(ka_f) - 1/A*(1-lamda)/(1+lamda);%1/4后掠角
ka_q_deg = ka_q * 180/pi;
C_root = 2/(1+lamda) * sqrt(Sref/A);% 根弦长
C_tip = C_root*lamda;% 梢弦长
ka_40 = get_ka_any_c(0.4, C_root, C_tip, B, ka_q);
ka_half = get_ka_any_c(0.5, C_root, C_tip, B, ka_q);
% 平均气动弦长
C_A = (4/3)*sqrt(Sref/A)*(1-lamda/(1+lamda)^2);
y_CA = sqrt(A*Sref)/6 * (1+2*lamda)/(1+lamda);
% 平均几何弦长
C_G = Sref/B;
y_CG = 1/(lamda-1) * 0.5*B * (C_G/C_root-1);
% 机翼根部前缘为起始点
Xf_wing = y_CA * tan(ka_f) + 0.25*C_A;%机翼焦点
gamma = 6 * pi/180;%上反角
t_root_bar = 0.1534;%根部相对厚度
t_tip_bar = 0.1035;%梢部相对厚度
t_CG_bar = (t_root_bar*(0.5*B-y_CG) + t_tip_bar*y_CG) / (0.5*B);% 平均几何弦长处的相对厚度
tao_W = -3 * pi/180;%机翼几何扭转角
%% htail
S_H = 30.66;
L_H_CA = 15.15;% 平尾力臂(到机翼焦点)
h_H = 0.75*3.76;% 平尾与机翼的垂直距离
S_e = 0.24*S_H;
% 升降舵相对弦长(根部/梢部): 0.24/0.34
V_H_CA = (S_H*L_H_CA) / (Sref*C_A);
%
lamda_H = 0.3256;%梢根比
B_H = 12.7;%展长
A_H = B_H^2 / S_H;
C_root_H = 2/(1+lamda_H) * sqrt(S_H/A_H);% 根弦长
C_tip_H = C_root_H*lamda_H;% 梢弦长
C_A_H = (4/3)*sqrt(S_H/A_H)*(1-lamda_H/(1+lamda_H)^2);
ka_f_H = 28.5 * pi/180;%前缘后掠角
ka_q_H = tan(ka_f_H) - 1/A_H*(1-lamda_H)/(1+lamda_H);%1/4后掠角
ka_q_H_deg = ka_q_H * 180/pi;
ka_40_H = get_ka_any_c(0.4, C_root_H, C_tip_H, B_H, ka_q_H);
ka_half_H = get_ka_any_c(0.5, C_root_H, C_tip_H, B_H, ka_q_H);
t_root_H_bar = 0.09;%根部相对厚度
t_tip_H_bar = 0.09;%梢部相对厚度
t_CG_H_bar = 0.5*(t_root_H_bar+t_tip_H_bar);% 平均几何弦长处的相对厚度
%
X_H = Xf_wing + L_H_CA - C_root;% XH: 机翼根弦后缘到平尾1/4弦点处 沿尾迹中心线方向的距离
%% vtail
S_V = 22.2;
% Cr:Ct:B = 58:16:60
lamda_V = 16/58;
C_root_V = sqrt(S_V*58/60*2/(1+lamda_V));
C_tip_V = C_root_V * lamda_V;
B_V = 60/58 * C_root_V;
% 0.5*C_root_V*(1+lamda_V)*B_V
A_V = B_V^2 / S_V;
C_A_V = (4/3)*sqrt(S_V/A_V)*(1-lamda_V/(1+lamda_V)^2);
ka_f_V = 42 * pi/180;%前缘后掠角
ka_q_V = tan(ka_f_V) - 1/A_V*(1-lamda_V)/(1+lamda_V);%1/4后掠角
ka_q_V_deg = ka_q_V * 180/pi;
ka_40_V = get_ka_any_c(0.4, C_root_V, C_tip_V, B_V, ka_q_V);
ka_half_V = get_ka_any_c(0.5, C_root_V, C_tip_V, B_V, ka_q_V);
L_V_CA = 13.93;
S_r = 0.31*S_V;
% 方向舵相对弦长(根部/梢部): 0.26/0.5
t_root_V_bar = 0.12;%根部相对厚度
t_tip_V_bar = 0.12;%梢部相对厚度
t_CG_V_bar = 0.5*(t_root_V_bar+t_tip_V_bar);% 平均几何弦长处的相对厚度
%
X_V = Xf_wing + L_V_CA - C_root;% XH: 机翼根弦后缘到垂尾1/4弦点处 沿尾迹中心线方向的距离
%%
L_F = 33.40;% 机身长度
d_WF = 3.76;% 机翼处机身直径
A_F = 0.25 * pi * d_WF^2;% 机身最大截面积
d_b = 0;% 机身底部直径
Swet_F = (10/13.5) * L_F * (pi*d_WF);
S_WF_overlap = C_root * 0.5*(2-d_WF/B) * d_WF;% 机翼与机身重合面积
d_HF = d_WF * 17/57.5;% 平尾处机身直径
S_HF_overlap = C_root_H * 0.5*(2-d_HF/B_H) * d_HF;% 平尾与机身重合面积
%% 三维机翼,平尾升力线斜率1:
CL_alpha_2d = 0.95*2*pi;
% wing
Sexp_W = Sref - S_WF_overlap;%机翼外露面积
CL_alpha_W1 = CL_alpha_wing1(CL_alpha_2d, A, Ma, Sexp_W/Sref, d_WF, B, ka_40);
CL_alpha_W1_M0 = CL_alpha_wing1(CL_alpha_2d, A, 0, Sexp_W/Sref, d_WF, B, ka_40);
% htail
Sexp_H = S_H - S_HF_overlap;%平尾外露面积
CL_alpha_H1 = CL_alpha_wing1(CL_alpha_2d, A_H, Ma, Sexp_H/S_H, d_HF, B_H, ka_40_H);
CL_alpha_H1_M0 = CL_alpha_wing1(CL_alpha_2d, A_H, 0, Sexp_H/S_H, d_HF, B_H, ka_40_H);
% vtail
CL_alpha_V1 = CL_alpha_wing1(CL_alpha_2d, A_V, Ma, Sexp_V/S_V, d_HF, B_V, ka_40_V);
CL_alpha_V1_M0 = CL_alpha_wing1(CL_alpha_2d, A_V, 0, Sexp_V/S_V, d_HF, B_V, ka_40_V);
%% 三维机翼升力线斜率2:
CL_alpha_W2 = CL_alpha_wing2(CL_alpha_2d, A, Ma, ka_half);
CL_alpha_W2_M0 = CL_alpha_wing2(CL_alpha_2d, A, 0, ka_half);

%% 翼型低速零升迎角
alpha0 = -1.5 * pi/180;
%% 翼型零升迎角压缩性修正
alpha0_Ma_fix = get_alpha0_Ma_fix(Ma, t_CG_bar);
%% 每度扭转角引起的零升迎角增量
d_alpha0_d_tao = get_d_alpha0_d_tao(ka_q, A, lamda);
%% 亚声速，机翼零升迎角估算
alpha0_W = alpha0_wing(alpha0, alpha0_Ma_fix, tao_W, ka_q, A, lamda);


%% 翼身，尾身组合体升力线斜率
CL_alpha_WF1 = CL_alpha_WingFuse(CL_alpha_W1, d_WF, B);
CL_alpha_HF1 = CL_alpha_WingFuse(CL_alpha_H1, d_HF, B_H);




%% 机翼,平尾,垂尾,机身摩擦系数
Re_W = rho*C_A*V / mu;
C_f_W = get_C_f(0.6, Re_W, 'T');
Re_H = rho*C_A_H*V / mu;
C_f_H = get_C_f(0.6, Re_H, 'T');
Re_V = rho*C_A_V*V / mu;
C_f_V = get_C_f(0.6, Re_V, 'T');
Re_F = rho*L_F*V / mu;
C_f_F = get_C_f(0.6, Re_F, 'T');
%% 机翼零升阻力系数
R_LS_W = get_R_LS(0.6, ka_40);%升力面修正因子
Swet_W = get_Swet_wing(Sexp_W, t_CG_bar);
CD0_W = CD0_wing(1, Ma, ka_40, Re_W, 0.4, t_CG_bar, Swet_W, Sref);
%% 平尾零升阻力系数
R_LS_H = get_R_LS(0.6, ka_40_H);%升力面修正因子
Swet_H = get_Swet_wing(Sexp_H, t_CG_H_bar);
CD0_H = CD0_wing(1, Ma, ka_40_H, Re_H, 0.4, t_CG_H_bar, Swet_H, S_H);
%% 垂尾零升阻力系数
R_LS_V = get_R_LS(0.6, ka_40_V);%升力面修正因子
Swet_V = get_Swet_wing(S_V, t_CG_V_bar);
CD0_V = CD0_wing(1, Ma, ka_40_V, Re_V, 0.4, t_CG_V_bar, Swet_V, S_V);
%% 机身零升阻力系数计算
CD0_F = CD0_fuselage(Ma, Re_F, 1, L_F, d_WF, d_b, Swet_F, A_F, Sref);
%% 后掠机翼波阻系数
CDw_W = CDw_sweep(Ma, t_CG_bar, A, ka_q);



%% 三维机翼,平尾诱导阻力系数1:
CDi_W1 = CDi_wing1(CL_W, A);
CDi_H1 = CDi_wing1(CL_H, A_H);
%% 三维机翼,平尾诱导阻力系数2:
e_W = get_e(A, ka_f);
e_H = get_e(A_H, ka_f_H);
CDi_W2 = CDi_wing2(CL_W, A, e_W);
CDi_H2 = CDi_wing2(CL_H, A_H, e_H);
%% 平尾,垂尾动压比kq
kq_H = get_kq(X_H, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W+phi_W);
kq_V = get_kq(X_V, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W+phi_W);
%% 平尾下洗迎角变化率
d_epslon_d_alpha = get_d_epslon_d_alpha(A, lamda, B, ka_q, h_H, L_H_CA, CL_alpha_W1, CL_alpha_W1_M0);

%% 全机升力线斜率
CL_alpha = CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha);
%% 全机零迎角升力系数
% 单独平尾升力系数
epslon_H = d_epslon_d_alpha * (phi_W-alpha0);% 飞机零迎角，机翼的等效迎角
phi_H = 0;% 平尾安装角
CL0 = CL0_aircraft(d_WF, B, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, phi_H, epslon_H);
%% 水平尾翼力矩系数
Cm_H = Cm_htail(CL_alpha_H, kq, d_epslon_d_alpha, alpha, phi_W, alpha0_W, delta_H, S_H, L_H, S, C_A);
%% 水平尾翼力矩导数
Cm_delta_H = Cm_delta_htail(CL_alpha_H, kq, S_H, L_H, S, C_A);
%% 升降舵升力导数
ka_e = 16* pi/180;
CL_delta_e = CL_delta_elev(CL_alpha_H, kq, S_H, S_e, S, ka_e);
%% 升降舵力矩导数
Cm_delta_e = Cm_delta_elev(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e);
%% 副翼单位偏转产生的二维翼型升力系数增量
t_bar_ail = 0.25*t_root_bar + 0.75*t_tip_bar;
CL_delta_a_2d = get_CL_delta_ail_2d(0.25, t_tip_bar);
%% 副翼滚转力矩系数
eta_in = 7.5/13.4;
eta_out = 12/13.4;
Kb = get_Kb(eta_out, lamda) - get_Kb(eta_in, lamda);% 展长修正因子
Cl_delta_a = Cl_delta_ail(CL_delta_a_2d, CL_alpha_W, CL_alpha_2d, eta_in, eta_out, lamda, B, C_A);
%% 方向舵侧力系数
CL_delta_r_2d = get_Cl_delta_the((0.26+0.5)/2, (t_root_V_bar+t_tip_V_bar)/2);
Cy_delta_r = Cy_delta_rudder(CL_alpha_V1, CL_alpha_2d, CL_delta_r_2d,...
    0, 1, lamda_V, S_V, S_W);
%% 方向偏航力矩系数
Cn_delta_r = Cn_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha);
%% 方向滚转力矩系数
Cl_delta_r = Cl_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha);

%% 迎角粗略估计(无配平)
alpha = mass_total*g / (0.5*rho*V^2 * Sref * CL_alpha_WF) - phi_W + alpha0;
alpha_deg = alpha * 180/pi;
delta_H = 0;% 平尾舵偏角
d_e_d_a = 0;
kq = 1;
% 配平:
for ii = 1:2
    %% 刚性飞机纵向配平
    [alpha, delta_H] = trim_Longitudinal_rigid('htail', mass_total, g,...
        Xcg, Xf_wing, Xf_htail,...
        S, S_H, C_A,...
        CL_alpha_WF, CL_alpha_H, 0, 0, Cm0_W, alpha0,...
        phi_W, 0,...
        rho_air, V, kq, d_e_d_a);
    %% 升力系数
    % 单独机翼升力系数
    CL_W = CL_alpha_W1 * (alpha + phi_W - alpha0_W);
    % 翼身组合体升力系数
    CL_WF = CL_alpha_WF * (alpha + phi_W - alpha0_W);
    % 单独平尾升力系数
    CL_H = CL_alpha_H * (alpha + delta_H - d_e_d_a*(alpha+phi_W-alpha0));
    %% 升致阻力系数
    % 机翼诱导阻力系数
    CDi_W = CDi_wing1(CL_W,A, lamda);
    % 机翼压差阻力系数
    CD1_W = CD1_wing(alpha+phi_W);
    % 平尾升致阻力系数
    CDi_H = CDi_wing1(CL_H,A_H, lamda_H);
    %% 动压比 和 下洗率
    % 平尾动压比
    kq = get_kq(Xf_htail-C_root, 0, C_A, CD0_W, CL_W, A, alpha+phi_W);
    % 平尾下洗率
    d_e_d_a = d_epslon_d_alpha(A, lamda, B, 0, 0, Xf_htail-Xf_wing, CL_alpha_W, CL_alpha_W);
    %% 全机焦点
    Xac = Xac_aircraft(CL_alpha_WF, Xf_wing, S, CL_alpha_H, Xf_htail, S_H, kq, d_e_d_a);
end




