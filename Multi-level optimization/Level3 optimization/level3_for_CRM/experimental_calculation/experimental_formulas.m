%% 三维机翼升力线斜率1:
CL_alpha_wing1(CL_alpha_2d, A, Ma, S_exp_div_ref, d_F, b, ka)
%% 三维机翼升力线斜率2:
CL_alpha_wing2(CL_alpha_2d, A, Ma, ka_half)
%% 三维机翼诱导阻力系数1:
CDi_wing1(CL,A)
%% 三维机翼诱导阻力系数2:
CDi_wing2(CL_W, A, e)
%% 平尾动压比kq
get_kq(X_H, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W)
%% 平尾下洗迎角变化率
get_d_epslon_d_alpha(A, lamda, b, ka_q, h_H, L_H, CL_alpha, CL_alpha_M0)
%% 水平尾翼力矩系数
Cm_H(CL_alpha_H, kq, epslon_H, alpha, delta_H, S_H, L_H, S, C_A)
%% 水平尾翼力矩导数
Cm_delta_H(CL_alpha_H, kq, S_H, L_H, S, C_A)
%% 升降舵升力导数
CL_delta_e(CL_alpha_H, kq, S_H, S_e, S, ka_e)
%% 升降舵力矩导数
Cm_delta_e(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e)
%% 后缘简单襟翼理论升力效率
get_Cl_delta_the(Cf_C, t_bar)
%% 副翼单位偏转产生的二维翼型升力系数增量
get_CL_delta_a_2d(Cf_C, t_bar)
%% 展长修正因子
get_Kb(eta, lamda)
%% 副翼滚转力矩系数
Cl_delta_a(CL_delta_a_2d, CL_alpha_W, Cl_alpha, eta_in, eta_out, lamda, B, C_A)
%% 方向舵侧力系数
Cy_delta_r(CL_alpha_V_3d, CL_alpha_V_2d, CL_delta_r_2d,...
    eta_in, eta_out, lamda, S_V, S_W)
%% 方向偏航力矩系数
Cn_delta_r(Cy_delta_r, L_V, Z_V, B_W, alpha)
%% 方向滚转力矩系数
Cl_delta_r(Cy_delta_r, L_V, Z_V, B_W, alpha)
%% 翼型高亚声速零升迎角修正
get_alpha_0com(alpha0, alpha0_Ma_fix)
%% NACA翼型零升迎角估算
get_alpha0_NACA(num, alpha_des, CL_des)
%% 翼型升力线斜率
CL_alpha_airfoil(t_bar, tao, Ma)
%% 亚声速，机翼零升迎角估算
alpha0_wing(alpha0, alpha0_Ma_fix, tao_w, ka_q, A, lamda)
%% 翼型零升迎角压缩性修正
get_alpha0_Ma_fix(Ma, t_bar)
%% 每度扭转角引起的零升迎角增量
get_d_alpha0_d_tao(ka_q, A, lamda)
%% 翼身组合体升力线斜率
CL_alpha_WingFuse(CL_alpha_W, d_F, b)
%% 全机升力线斜率
CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha)
%% 全机零迎角升力系数
CL0_aircraft(d_F, b, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, epslon_H)
%% 升力面修正因子
get_R_LS(Ma, ka_thick)
%% 已知根弦长Cr，梢弦长Ct，展长B，1/4弦后掠角ka，求相对弦长k的后掠角
get_ka_any_c(k, Cr, Ct, B, ka_q)
%% 机翼湍流,层流摩擦系数
get_C_f(Ma, Re_c, type)
%% 机翼零升阻力系数
CD0_wing(R_WF, Ma, ka_thick, Re_W, C_thick_bar, t_bar, S_wet, S)
%% 平直机翼波阻系数
C_Dw_straight(Ma, t_bar, A)
%% 后掠机翼波阻系数
C_Dw_sweep(Ma, t_bar, A, ka_q)
%% 机身零升阻力系数计算
CD0_fuselage(Ma, Re_F, R_WF, L_F, d_F, d_b, S_wetF, S_F, S)
%% 机身波阻系数(未完成)
C_DwF(Ma, A_F, S_F_div_S)
%% 舵面型阻
CD_dp(delta_f_deg, Cf_div_C)
%% 操纵面形阻delta_D_trp, 操纵面诱阻delta_D_trH
CD_trp(delta_e, Cf_div_C, ka_q, S_ef, S)
CD_trh(CL_H, CL_E, A_H, e_H, S_H, S)
%% 奥斯瓦尔德因子e估算
get_e(A, ka_LE)
% get_e(CL_alpha_W, Ma, A, ka_LE, Re_rLE)
%% 浸润面积估算
get_Swet_wing(S_exp, t_bar)
get_Swet_fuselage(K, S_bis, S_sis)
%% 翼型俯仰力矩估算
Cm0_airfoil(x_seq, z_seq, c, Ma, t_bar)
%% 翼型临界马赫数估算
get_Mcr_airfoil(airfoil_type, C_L, t_bar)
%% 单位扭转角产生的零升力矩增量
get_d_Cm0_d_tao(ka_q, A, lamda)
%% 机翼零升力矩压缩性修正
get_Cm0_M_div_M0(Ma)
%% 机翼零升力矩估算
Cm0_wing(A, lamda, ka_q, Cm0_r, Cm0_t, tao, Ma)
%% 全机零升迎角
alpha0_aircraft(CL_alpha_WF, alpha0_WF, CL_alpha_HF, S, S_H, phi_W, phi_H, kq, d_epslon_d_alpha, epslon0)
%% 全机气动中心Xac_aircraft
Xac_aircraft(CL_alpha_WF, Xac_WF, S, CL_alpha_HF, Xac_HF, S_H, kq, d_epslon_d_alpha)
%
%
%% 机身粘性流起始点站位
get_fuselage_x0(x1, L_F)
%% 翼身干扰因子Ki
get_Ki(Z_W, d_F)
%% 横航向静导数Cy_beta计算
Cy_beta_WingFuse(gamma_deg, Z_W, d_F, A_F0, S)% 翼身贡献
Cy_beta_vtail(r1, CL_alpha_V, Sv_div_S, Zw_div_Zf, lamda_V, ka_q)% 垂尾贡献
%% 偏航力矩对侧滑角的导数
get_K_WF(L_F, S_FS, h1, h2)% Cn_beta公式中的翼身干扰因子
get_K_RF(Re_F)% Cn_beta公式中的雷诺数影响修正因子
Cn_beta_WingFuse(K_WF, Re_F, S_FS, L_F, S, b)% 偏航力矩对侧滑角的导数(翼身贡献)
Cn_beta_vtail(Cy_beta_V, L_V, Z_V, b, alpha)% 偏航力矩对侧滑角的导数(垂尾贡献)
%% 滚转力矩系数Cl_beta计算(未完成, 经验图太多)
Cl_beta_WingFuse(C_LWF, ka_half, ka_q, lamda, b, tao_w, gamma, Ma, d_Fav, Zw)
Cl_beta_vtail(Cy_beta_vtail, lv, Zv, alpha, b)
Cl_beta_htail(C_LWH, ka_half_h, ka_q_h, lamda_h, b_h, tao_h, gamma, Ma_h, d_Fav, Zh, SH_div_S, bH_div_b)
%% 俯仰角速度升力动导数
CLq_wing(CL_alpha_wing, Xcg_bar)
CLq_htail(CL_alpha_htail, X_FH_exp_bar, Xcg_bar)
%% 机翼展弦比影响系数
get_F_of_Cmq(Ma, A)
%% 俯仰角速度力矩动导数
Cmq_wing(CL_alpha_W, X_F_bar, Cl_alpha, ka_q, Ma, lamda, Xcg_bar, CL_q_W)
Cmq_htail(CLq_H, X_FH_bar, Xcg_bar)
%% 某一Ma下CL = 0时机翼滚转力矩系数动导数的组合参数
get_betaC_K(Ma, Cl_alpha_M, ka_q, A, lamda)
%% 升致阻力的滚转阻尼参数
get_Clp_CLW2(A,ka_q)
%% 滚转阻尼导数
Clp_wing(Cl_alpha_M, CL_alpha_W_CL, CL_alpha_W_CL0, CL_W, CD0_W,...
    Z, Ma, ka_q, A, lamda, gamma, b)


