%% ��ά����������б��1:
CL_alpha_wing1(CL_alpha_2d, A, Ma, S_exp_div_ref, d_F, b, ka)
%% ��ά����������б��2:
CL_alpha_wing2(CL_alpha_2d, A, Ma, ka_half)
%% ��ά�����յ�����ϵ��1:
CDi_wing1(CL,A)
%% ��ά�����յ�����ϵ��2:
CDi_wing2(CL_W, A, e)
%% ƽβ��ѹ��kq
get_kq(X_H, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W)
%% ƽβ��ϴӭ�Ǳ仯��
get_d_epslon_d_alpha(A, lamda, b, ka_q, h_H, L_H, CL_alpha, CL_alpha_M0)
%% ˮƽβ������ϵ��
Cm_H(CL_alpha_H, kq, epslon_H, alpha, delta_H, S_H, L_H, S, C_A)
%% ˮƽβ�����ص���
Cm_delta_H(CL_alpha_H, kq, S_H, L_H, S, C_A)
%% ��������������
CL_delta_e(CL_alpha_H, kq, S_H, S_e, S, ka_e)
%% ���������ص���
Cm_delta_e(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e)
%% ��Ե�򵥽�����������Ч��
get_Cl_delta_the(Cf_C, t_bar)
%% ����λƫת�����Ķ�ά��������ϵ������
get_CL_delta_a_2d(Cf_C, t_bar)
%% չ����������
get_Kb(eta, lamda)
%% �����ת����ϵ��
Cl_delta_a(CL_delta_a_2d, CL_alpha_W, Cl_alpha, eta_in, eta_out, lamda, B, C_A)
%% ��������ϵ��
Cy_delta_r(CL_alpha_V_3d, CL_alpha_V_2d, CL_delta_r_2d,...
    eta_in, eta_out, lamda, S_V, S_W)
%% ����ƫ������ϵ��
Cn_delta_r(Cy_delta_r, L_V, Z_V, B_W, alpha)
%% �����ת����ϵ��
Cl_delta_r(Cy_delta_r, L_V, Z_V, B_W, alpha)
%% ���͸�����������ӭ������
get_alpha_0com(alpha0, alpha0_Ma_fix)
%% NACA��������ӭ�ǹ���
get_alpha0_NACA(num, alpha_des, CL_des)
%% ����������б��
CL_alpha_airfoil(t_bar, tao, Ma)
%% �����٣���������ӭ�ǹ���
alpha0_wing(alpha0, alpha0_Ma_fix, tao_w, ka_q, A, lamda)
%% ��������ӭ��ѹ��������
get_alpha0_Ma_fix(Ma, t_bar)
%% ÿ��Ťת�����������ӭ������
get_d_alpha0_d_tao(ka_q, A, lamda)
%% ���������������б��
CL_alpha_WingFuse(CL_alpha_W, d_F, b)
%% ȫ��������б��
CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha)
%% ȫ����ӭ������ϵ��
CL0_aircraft(d_F, b, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, epslon_H)
%% ��������������
get_R_LS(Ma, ka_thick)
%% ��֪���ҳ�Cr�����ҳ�Ct��չ��B��1/4�Һ��ӽ�ka��������ҳ�k�ĺ��ӽ�
get_ka_any_c(k, Cr, Ct, B, ka_q)
%% ��������,����Ħ��ϵ��
get_C_f(Ma, Re_c, type)
%% ������������ϵ��
CD0_wing(R_WF, Ma, ka_thick, Re_W, C_thick_bar, t_bar, S_wet, S)
%% ƽֱ������ϵ��
C_Dw_straight(Ma, t_bar, A)
%% ���ӻ�����ϵ��
C_Dw_sweep(Ma, t_bar, A, ka_q)
%% ������������ϵ������
CD0_fuselage(Ma, Re_F, R_WF, L_F, d_F, d_b, S_wetF, S_F, S)
%% ������ϵ��(δ���)
C_DwF(Ma, A_F, S_F_div_S)
%% ��������
CD_dp(delta_f_deg, Cf_div_C)
%% ����������delta_D_trp, ����������delta_D_trH
CD_trp(delta_e, Cf_div_C, ka_q, S_ef, S)
CD_trh(CL_H, CL_E, A_H, e_H, S_H, S)
%% ��˹�߶�������e����
get_e(A, ka_LE)
% get_e(CL_alpha_W, Ma, A, ka_LE, Re_rLE)
%% �����������
get_Swet_wing(S_exp, t_bar)
get_Swet_fuselage(K, S_bis, S_sis)
%% ���͸������ع���
Cm0_airfoil(x_seq, z_seq, c, Ma, t_bar)
%% �����ٽ����������
get_Mcr_airfoil(airfoil_type, C_L, t_bar)
%% ��λŤת�ǲ�����������������
get_d_Cm0_d_tao(ka_q, A, lamda)
%% ������������ѹ��������
get_Cm0_M_div_M0(Ma)
%% �����������ع���
Cm0_wing(A, lamda, ka_q, Cm0_r, Cm0_t, tao, Ma)
%% ȫ������ӭ��
alpha0_aircraft(CL_alpha_WF, alpha0_WF, CL_alpha_HF, S, S_H, phi_W, phi_H, kq, d_epslon_d_alpha, epslon0)
%% ȫ����������Xac_aircraft
Xac_aircraft(CL_alpha_WF, Xac_WF, S, CL_alpha_HF, Xac_HF, S_H, kq, d_epslon_d_alpha)
%
%
%% ����ճ������ʼ��վλ
get_fuselage_x0(x1, L_F)
%% �����������Ki
get_Ki(Z_W, d_F)
%% �ẽ�򾲵���Cy_beta����
Cy_beta_WingFuse(gamma_deg, Z_W, d_F, A_F0, S)% ������
Cy_beta_vtail(r1, CL_alpha_V, Sv_div_S, Zw_div_Zf, lamda_V, ka_q)% ��β����
%% ƫ�����ضԲ໬�ǵĵ���
get_K_WF(L_F, S_FS, h1, h2)% Cn_beta��ʽ�е������������
get_K_RF(Re_F)% Cn_beta��ʽ�е���ŵ��Ӱ����������
Cn_beta_WingFuse(K_WF, Re_F, S_FS, L_F, S, b)% ƫ�����ضԲ໬�ǵĵ���(������)
Cn_beta_vtail(Cy_beta_V, L_V, Z_V, b, alpha)% ƫ�����ضԲ໬�ǵĵ���(��β����)
%% ��ת����ϵ��Cl_beta����(δ���, ����ͼ̫��)
Cl_beta_WingFuse(C_LWF, ka_half, ka_q, lamda, b, tao_w, gamma, Ma, d_Fav, Zw)
Cl_beta_vtail(Cy_beta_vtail, lv, Zv, alpha, b)
Cl_beta_htail(C_LWH, ka_half_h, ka_q_h, lamda_h, b_h, tao_h, gamma, Ma_h, d_Fav, Zh, SH_div_S, bH_div_b)
%% �������ٶ�����������
CLq_wing(CL_alpha_wing, Xcg_bar)
CLq_htail(CL_alpha_htail, X_FH_exp_bar, Xcg_bar)
%% ����չ�ұ�Ӱ��ϵ��
get_F_of_Cmq(Ma, A)
%% �������ٶ����ض�����
Cmq_wing(CL_alpha_W, X_F_bar, Cl_alpha, ka_q, Ma, lamda, Xcg_bar, CL_q_W)
Cmq_htail(CLq_H, X_FH_bar, Xcg_bar)
%% ĳһMa��CL = 0ʱ�����ת����ϵ������������ϲ���
get_betaC_K(Ma, Cl_alpha_M, ka_q, A, lamda)
%% ���������Ĺ�ת�������
get_Clp_CLW2(A,ka_q)
%% ��ת���ᵼ��
Clp_wing(Cl_alpha_M, CL_alpha_W_CL, CL_alpha_W_CL0, CL_W, CD0_W,...
    Z, Ma, ka_q, A, lamda, gamma, b)


