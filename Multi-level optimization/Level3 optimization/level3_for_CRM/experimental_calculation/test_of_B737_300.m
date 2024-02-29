clear;clc;
close all;
addpath(genpath('aeordynamic_functions'));
addpath(genpath('aero_derivative_functions'));


%Boeing737-300
Sref = 105.45;%�������
mass = 595*Sref;
Thrust = 0.317*mass;
Ma = 0.745;%Ѳ�������
height = 10000;
T = -50 + 273.15;
rho = 0.4127;
mu = 1.46 * 1e-5;%����ճ��(-50��)
a = sqrt(1.4*287.14*T);
V = Ma * a;

%% wing
A = 8.83;%չ�ұ�
lamda = 0.31;%�Ҹ���
B = sqrt(Sref*A);%չ��
ka_f = 25 * pi/180;%ǰԵ���ӽ�
ka_q = tan(ka_f) - 1/A*(1-lamda)/(1+lamda);%1/4���ӽ�
ka_q_deg = ka_q * 180/pi;
C_root = 2/(1+lamda) * sqrt(Sref/A);% ���ҳ�
C_tip = C_root*lamda;% ���ҳ�
ka_40 = get_ka_any_c(0.4, C_root, C_tip, B, ka_q);
ka_half = get_ka_any_c(0.5, C_root, C_tip, B, ka_q);
% ƽ�������ҳ�
C_A = (4/3)*sqrt(Sref/A)*(1-lamda/(1+lamda)^2);
y_CA = sqrt(A*Sref)/6 * (1+2*lamda)/(1+lamda);
% ƽ�������ҳ�
C_G = Sref/B;
y_CG = 1/(lamda-1) * 0.5*B * (C_G/C_root-1);
% �������ǰԵΪ��ʼ��
Xf_wing = y_CA * tan(ka_f) + 0.25*C_A;%������
gamma = 6 * pi/180;%�Ϸ���
t_root_bar = 0.1534;%������Ժ��
t_tip_bar = 0.1035;%�Ҳ���Ժ��
t_CG_bar = (t_root_bar*(0.5*B-y_CG) + t_tip_bar*y_CG) / (0.5*B);% ƽ�������ҳ�������Ժ��
tao_W = -3 * pi/180;%������Ťת��
%% htail
S_H = 30.66;
L_H_CA = 15.15;% ƽβ����(��������)
h_H = 0.75*3.76;% ƽβ�����Ĵ�ֱ����
S_e = 0.24*S_H;
% ����������ҳ�(����/�Ҳ�): 0.24/0.34
V_H_CA = (S_H*L_H_CA) / (Sref*C_A);
%
lamda_H = 0.3256;%�Ҹ���
B_H = 12.7;%չ��
A_H = B_H^2 / S_H;
C_root_H = 2/(1+lamda_H) * sqrt(S_H/A_H);% ���ҳ�
C_tip_H = C_root_H*lamda_H;% ���ҳ�
C_A_H = (4/3)*sqrt(S_H/A_H)*(1-lamda_H/(1+lamda_H)^2);
ka_f_H = 28.5 * pi/180;%ǰԵ���ӽ�
ka_q_H = tan(ka_f_H) - 1/A_H*(1-lamda_H)/(1+lamda_H);%1/4���ӽ�
ka_q_H_deg = ka_q_H * 180/pi;
ka_40_H = get_ka_any_c(0.4, C_root_H, C_tip_H, B_H, ka_q_H);
ka_half_H = get_ka_any_c(0.5, C_root_H, C_tip_H, B_H, ka_q_H);
t_root_H_bar = 0.09;%������Ժ��
t_tip_H_bar = 0.09;%�Ҳ���Ժ��
t_CG_H_bar = 0.5*(t_root_H_bar+t_tip_H_bar);% ƽ�������ҳ�������Ժ��
%
X_H = Xf_wing + L_H_CA - C_root;% XH: ������Һ�Ե��ƽβ1/4�ҵ㴦 ��β�������߷���ľ���
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
ka_f_V = 42 * pi/180;%ǰԵ���ӽ�
ka_q_V = tan(ka_f_V) - 1/A_V*(1-lamda_V)/(1+lamda_V);%1/4���ӽ�
ka_q_V_deg = ka_q_V * 180/pi;
ka_40_V = get_ka_any_c(0.4, C_root_V, C_tip_V, B_V, ka_q_V);
ka_half_V = get_ka_any_c(0.5, C_root_V, C_tip_V, B_V, ka_q_V);
L_V_CA = 13.93;
S_r = 0.31*S_V;
% ���������ҳ�(����/�Ҳ�): 0.26/0.5
t_root_V_bar = 0.12;%������Ժ��
t_tip_V_bar = 0.12;%�Ҳ���Ժ��
t_CG_V_bar = 0.5*(t_root_V_bar+t_tip_V_bar);% ƽ�������ҳ�������Ժ��
%
X_V = Xf_wing + L_V_CA - C_root;% XH: ������Һ�Ե����β1/4�ҵ㴦 ��β�������߷���ľ���
%%
L_F = 33.40;% ������
d_WF = 3.76;% ��������ֱ��
A_F = 0.25 * pi * d_WF^2;% �����������
d_b = 0;% ����ײ�ֱ��
Swet_F = (10/13.5) * L_F * (pi*d_WF);
S_WF_overlap = C_root * 0.5*(2-d_WF/B) * d_WF;% ����������غ����
d_HF = d_WF * 17/57.5;% ƽβ������ֱ��
S_HF_overlap = C_root_H * 0.5*(2-d_HF/B_H) * d_HF;% ƽβ������غ����
%% ��ά����,ƽβ������б��1:
CL_alpha_2d = 0.95*2*pi;
% wing
Sexp_W = Sref - S_WF_overlap;%������¶���
CL_alpha_W1 = CL_alpha_wing1(CL_alpha_2d, A, Ma, Sexp_W/Sref, d_WF, B, ka_40);
CL_alpha_W1_M0 = CL_alpha_wing1(CL_alpha_2d, A, 0, Sexp_W/Sref, d_WF, B, ka_40);
% htail
Sexp_H = S_H - S_HF_overlap;%ƽβ��¶���
CL_alpha_H1 = CL_alpha_wing1(CL_alpha_2d, A_H, Ma, Sexp_H/S_H, d_HF, B_H, ka_40_H);
CL_alpha_H1_M0 = CL_alpha_wing1(CL_alpha_2d, A_H, 0, Sexp_H/S_H, d_HF, B_H, ka_40_H);
% vtail
CL_alpha_V1 = CL_alpha_wing1(CL_alpha_2d, A_V, Ma, Sexp_V/S_V, d_HF, B_V, ka_40_V);
CL_alpha_V1_M0 = CL_alpha_wing1(CL_alpha_2d, A_V, 0, Sexp_V/S_V, d_HF, B_V, ka_40_V);
%% ��ά����������б��2:
CL_alpha_W2 = CL_alpha_wing2(CL_alpha_2d, A, Ma, ka_half);
CL_alpha_W2_M0 = CL_alpha_wing2(CL_alpha_2d, A, 0, ka_half);

%% ���͵�������ӭ��
alpha0 = -1.5 * pi/180;
%% ��������ӭ��ѹ��������
alpha0_Ma_fix = get_alpha0_Ma_fix(Ma, t_CG_bar);
%% ÿ��Ťת�����������ӭ������
d_alpha0_d_tao = get_d_alpha0_d_tao(ka_q, A, lamda);
%% �����٣���������ӭ�ǹ���
alpha0_W = alpha0_wing(alpha0, alpha0_Ma_fix, tao_W, ka_q, A, lamda);


%% ����β�������������б��
CL_alpha_WF1 = CL_alpha_WingFuse(CL_alpha_W1, d_WF, B);
CL_alpha_HF1 = CL_alpha_WingFuse(CL_alpha_H1, d_HF, B_H);




%% ����,ƽβ,��β,����Ħ��ϵ��
Re_W = rho*C_A*V / mu;
C_f_W = get_C_f(0.6, Re_W, 'T');
Re_H = rho*C_A_H*V / mu;
C_f_H = get_C_f(0.6, Re_H, 'T');
Re_V = rho*C_A_V*V / mu;
C_f_V = get_C_f(0.6, Re_V, 'T');
Re_F = rho*L_F*V / mu;
C_f_F = get_C_f(0.6, Re_F, 'T');
%% ������������ϵ��
R_LS_W = get_R_LS(0.6, ka_40);%��������������
Swet_W = get_Swet_wing(Sexp_W, t_CG_bar);
CD0_W = CD0_wing(1, Ma, ka_40, Re_W, 0.4, t_CG_bar, Swet_W, Sref);
%% ƽβ��������ϵ��
R_LS_H = get_R_LS(0.6, ka_40_H);%��������������
Swet_H = get_Swet_wing(Sexp_H, t_CG_H_bar);
CD0_H = CD0_wing(1, Ma, ka_40_H, Re_H, 0.4, t_CG_H_bar, Swet_H, S_H);
%% ��β��������ϵ��
R_LS_V = get_R_LS(0.6, ka_40_V);%��������������
Swet_V = get_Swet_wing(S_V, t_CG_V_bar);
CD0_V = CD0_wing(1, Ma, ka_40_V, Re_V, 0.4, t_CG_V_bar, Swet_V, S_V);
%% ������������ϵ������
CD0_F = CD0_fuselage(Ma, Re_F, 1, L_F, d_WF, d_b, Swet_F, A_F, Sref);
%% ���ӻ�����ϵ��
CDw_W = CDw_sweep(Ma, t_CG_bar, A, ka_q);



%% ��ά����,ƽβ�յ�����ϵ��1:
CDi_W1 = CDi_wing1(CL_W, A);
CDi_H1 = CDi_wing1(CL_H, A_H);
%% ��ά����,ƽβ�յ�����ϵ��2:
e_W = get_e(A, ka_f);
e_H = get_e(A_H, ka_f_H);
CDi_W2 = CDi_wing2(CL_W, A, e_W);
CDi_H2 = CDi_wing2(CL_H, A_H, e_H);
%% ƽβ,��β��ѹ��kq
kq_H = get_kq(X_H, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W+phi_W);
kq_V = get_kq(X_V, gamma_H, C_A, C_D0_W, CL_W, A, alpha_W+phi_W);
%% ƽβ��ϴӭ�Ǳ仯��
d_epslon_d_alpha = get_d_epslon_d_alpha(A, lamda, B, ka_q, h_H, L_H_CA, CL_alpha_W1, CL_alpha_W1_M0);

%% ȫ��������б��
CL_alpha = CL_alpha_aircraft(CL_alpha_W, d_F, b, S_H_div_S, k_q, d_epslon_d_alpha);
%% ȫ����ӭ������ϵ��
% ����ƽβ����ϵ��
epslon_H = d_epslon_d_alpha * (phi_W-alpha0);% �ɻ���ӭ�ǣ�����ĵ�Чӭ��
phi_H = 0;% ƽβ��װ��
CL0 = CL0_aircraft(d_WF, B, CL_alpha_W, phi_W, alpha0_W, CL_alpha_H, k_q, S_H_div_S, phi_H, epslon_H);
%% ˮƽβ������ϵ��
Cm_H = Cm_htail(CL_alpha_H, kq, d_epslon_d_alpha, alpha, phi_W, alpha0_W, delta_H, S_H, L_H, S, C_A);
%% ˮƽβ�����ص���
Cm_delta_H = Cm_delta_htail(CL_alpha_H, kq, S_H, L_H, S, C_A);
%% ��������������
ka_e = 16* pi/180;
CL_delta_e = CL_delta_elev(CL_alpha_H, kq, S_H, S_e, S, ka_e);
%% ���������ص���
Cm_delta_e = Cm_delta_elev(CL_alpha_H, kq, S_H, S_e, S, L_H, C_A, ka_e);
%% ����λƫת�����Ķ�ά��������ϵ������
t_bar_ail = 0.25*t_root_bar + 0.75*t_tip_bar;
CL_delta_a_2d = get_CL_delta_ail_2d(0.25, t_tip_bar);
%% �����ת����ϵ��
eta_in = 7.5/13.4;
eta_out = 12/13.4;
Kb = get_Kb(eta_out, lamda) - get_Kb(eta_in, lamda);% չ����������
Cl_delta_a = Cl_delta_ail(CL_delta_a_2d, CL_alpha_W, CL_alpha_2d, eta_in, eta_out, lamda, B, C_A);
%% ��������ϵ��
CL_delta_r_2d = get_Cl_delta_the((0.26+0.5)/2, (t_root_V_bar+t_tip_V_bar)/2);
Cy_delta_r = Cy_delta_rudder(CL_alpha_V1, CL_alpha_2d, CL_delta_r_2d,...
    0, 1, lamda_V, S_V, S_W);
%% ����ƫ������ϵ��
Cn_delta_r = Cn_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha);
%% �����ת����ϵ��
Cl_delta_r = Cl_delta_rudder(Cy_delta_r, L_V, Z_V, B_W, alpha);

%% ӭ�Ǵ��Թ���(����ƽ)
alpha = mass_total*g / (0.5*rho*V^2 * Sref * CL_alpha_WF) - phi_W + alpha0;
alpha_deg = alpha * 180/pi;
delta_H = 0;% ƽβ��ƫ��
d_e_d_a = 0;
kq = 1;
% ��ƽ:
for ii = 1:2
    %% ���Էɻ�������ƽ
    [alpha, delta_H] = trim_Longitudinal_rigid('htail', mass_total, g,...
        Xcg, Xf_wing, Xf_htail,...
        S, S_H, C_A,...
        CL_alpha_WF, CL_alpha_H, 0, 0, Cm0_W, alpha0,...
        phi_W, 0,...
        rho_air, V, kq, d_e_d_a);
    %% ����ϵ��
    % ������������ϵ��
    CL_W = CL_alpha_W1 * (alpha + phi_W - alpha0_W);
    % �������������ϵ��
    CL_WF = CL_alpha_WF * (alpha + phi_W - alpha0_W);
    % ����ƽβ����ϵ��
    CL_H = CL_alpha_H * (alpha + delta_H - d_e_d_a*(alpha+phi_W-alpha0));
    %% ��������ϵ��
    % �����յ�����ϵ��
    CDi_W = CDi_wing1(CL_W,A, lamda);
    % ����ѹ������ϵ��
    CD1_W = CD1_wing(alpha+phi_W);
    % ƽβ��������ϵ��
    CDi_H = CDi_wing1(CL_H,A_H, lamda_H);
    %% ��ѹ�� �� ��ϴ��
    % ƽβ��ѹ��
    kq = get_kq(Xf_htail-C_root, 0, C_A, CD0_W, CL_W, A, alpha+phi_W);
    % ƽβ��ϴ��
    d_e_d_a = d_epslon_d_alpha(A, lamda, B, 0, 0, Xf_htail-Xf_wing, CL_alpha_W, CL_alpha_W);
    %% ȫ������
    Xac = Xac_aircraft(CL_alpha_WF, Xf_wing, S, CL_alpha_H, Xf_htail, S_H, kq, d_e_d_a);
end




