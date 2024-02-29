clear;clc;
close all;

%% settings
% add disp to DCONTR
contrain_disp = true;
% mass_added 1
with_nstr_mass = true;
% mass_added 2
with_fuel = true;
%
thick_monotonic = false;
%
use_opt_vars = false;
opt_problem = 'sol200b';
use_udf_vars = false;
var_values_udf = 1e-1*[
    1, 1, 1,...% a_fspar, b_fspar, c_fspar
    1, 1, 1,...% a_rspar, b_rspar, c_rspar
    1, 1, 1,...% a_str, b_str, c_str
    1, 1, 1,...% a_fweb, b_fweb, c_fweb
    1, 1, 1,...% a_rweb, b_rweb, c_rweb
    1, 1, 1];% a_skin, b_skin, c_skin
% pbar,pshell as a*exp(by)+c
use_span_function = false;
%
A_over_bt = 1.5;
hs_rate=0.01; % 计算应力的纤维距
var_mode = 3;% 6 or 5 or 3
%
OPTEXIT = 3;
% flight cases
flight_cases = containers.Map();
flight_cases('1g') = false;
flight_cases('2.5g') = true;
flight_cases('roll') = true;
flight_cases('flutter') = true;

%%
format long
addpath(genpath('classes'));
addpath(genpath('print_program'));
addpath(genpath('build_model_process2'));
addpath(genpath('structural_size'));
addpath(genpath('Spline_interp'));
addpath(genpath('data_from_OAS'));
collect_struct_data
if use_opt_vars
    load(['var_values_', opt_problem], 'var_values');
end
%% flight condition
RHO_air1 = 0.348;
RHO_air2 = 1.225;
Ma1 = 0.85;
Ma2 = 0.64;
speed_of_sound1 = 295.07;
speed_of_sound2 = 340.294;
fuel_mass = 92437+15000;
alpha_25g = 2.9356*pi/180;
%% 机翼几何参数
C_root_wing = 13.606;
taper_inner_wing = 0.5582;
taper_outer_wing = 0.3588;
span_eta = 0.3495;
half_span_wing = 29.38;
sweep_wing_inner = 31.148 * pi/180;
sweep_wing_outer = 34.839 * pi/180;
body_width_wing = 6.184;
X25_root_wing = 26.271;
height_wing = 0.;
dihedral_wing = 4.5 * pi/180;
n_str_wing = 7; %桁条数量
% root
Cf_root = 0.1;% 前梁相对弦长
Cr_root = 0.6;% 后梁相对弦长
% kink
Cf_kink = 0.1492;% 前梁相对弦长
Cr_kink = 0.7382;% 后梁相对弦长
% tip
Cf_tip = 0.35;% 前梁相对弦长
Cr_tip = 0.6;% 后梁相对弦长
%

%% 平尾几何参数
C_root_htail = 5.946;
taper_htail = 0.37975;
half_span_htail = 9.385;
sweep_htail = 37 * pi/180;
body_width_htail = 2.565;
X25_root_htail = 56.966;
height_htail = 2.636;
dihedral_htail = 7.5 * pi/180;
n_str_htail = 5; %桁条数量
% 根部
Cf_htail_root = 0.1;% 前梁相对弦长
Cr_htail_root = 0.6;% 后梁相对弦长
Cs_htail_root = linspace(Cf_htail_root, Cr_htail_root, 7);% 桁条相对弦长
% 翼梢
Cf_htail_tip = 0.1;% 前梁相对弦长
Cr_htail_tip = 0.6;% 后梁相对弦长
Cs_htail_tip = linspace(Cf_htail_tip, Cr_htail_tip, 7);% 桁条相对弦长

%% 垂尾几何参数
C_root_vtail = 6.451;
taper_vtail = 0.35;
half_span_vtail = 10.668;
sweep_vtail = 37 * pi/180;
X25_root_vtail = 56.966;
height_vtail = 2.636;
% 根部
Cf_vtail_root = 0.1;% 前梁相对弦长
Cr_vtail_root = 0.6;% 后梁相对弦长
Cs_vtail_root =  linspace(Cf_htail_root, Cr_htail_root, 7);% 桁条相对弦长
% 翼梢
Cf_vtail_tip = 0.1;% 前梁相对弦长
Cr_vtail_tip = 0.6;% 后梁相对弦长
Cs_vtail_tip = linspace(Cf_htail_tip, Cr_htail_tip, 7);% 桁条相对弦长

%% 操纵面位置
%aileron
aileron_x = [0.8, 0.8];% 内侧和外侧的相对弦长
aileron_y = [0.76, 1.];% 内侧和外侧的相对展长
elevator_x = [0.7, 0.7];% 内侧和外侧的相对弦长
rudder_x = [0.7, 0.7];% 内侧和外侧的相对弦长

%% struct element mesh divide
%% high fidelity
% nb_center = 2;% 中央翼段数
% nb_inner = 4;% 翼根段数
% nb_outer = 20;% 翼梢段数
% nb_connect = 2;% 转折处段数
% wing_box_num = nb_center + nb_inner + nb_outer + nb_connect;
% %
% nbb_center = 2;% 中央翼sub段数
% nbb_inner = 2;% 翼根sub段数
% nbb_outer = 1;% 翼梢sub段数
% nbb_connect = 2;% 转折处sub段数
% 
% nb_outer_htail = 4;% 平尾段数
% nb_center_htail = 1;% 平尾中央翼段数
% nbb_outer_htail = 3;
% nbb_center_htail = 3;
% nc = 1; % cut_number between 2 rods

%% low fidelity
nb_center = 1;% 中央翼段数
nb_inner = 2;% 翼根段数
nb_outer = 10;% 翼梢段数
nb_connect = 1;% 转折处段数
wing_box_num = nb_center + nb_inner + nb_outer + nb_connect;
%
nbb_center = 2;% 中央翼sub段数
nbb_inner = 2;% 翼根sub段数
nbb_outer = 1;% 翼梢sub段数
nbb_connect = 2;% 转折处sub段数

nb_outer_htail = 4;% 平尾段数
nb_center_htail = 1;% 平尾中央翼段数
nbb_outer_htail = 3;
nbb_center_htail = 3;
nc = 1; % cut_number between 2 rods

%% aero mesh divide
%机翼面元展向分段：
% part1: 翼根 到 机翼转折处
m1_wing = 5;
n1_wing = 8;
% part2: 机翼转折处 到 副翼翼根
m2_wing = 5;
n2_wing = 8;
% part31: 副翼翼根 到 副翼翼梢
m31_wing = 4;
n3_wing = 6;
% part32: 副翼
m32_wing = 2;
% part4: 副翼翼梢 到 翼梢
m4_wing = 4;
n4_wing = 2;
%平尾面元展向分段：
% part1: 
m11_htail = 4;
n1_htail = 8;
% part12: 
m12_htail = 2;
%% OpenAeroStruct divide
wing_num_x = 7;
wing_num_y = 21;
%% opt constraints
% 1g displacement constraint 
MAX_TWIST_DEG_1g = 2.4;
MAX_DISP_RATIO_1g = 0.1;
% 2.5g displacement constraint 
MAX_TWIST_DEG_25g = 6.0;
MAX_DISP_RATIO_25g = 0.13;
% 2.5g stress constraint
yield = 420.e6 / 1.5;
% roll_eff constraint
ROLLEFF_LOW = 0.2;
C_roll_stiff = 9.1664E-02;
%% 机身
mass_body = [103947.0];
cg_body = [35.7781, 0.,0.];
%
Xf_start = 0.0;% 机头位置
Xf_end = 65.097;% 机尾位置
Zf = 1.688;

Xf_seq = [Xf_start, 26.37, 32.27,...
    [33:0.1:35],...
    cg_body(1), 57.04, 60.01, Xf_end];
Zf_seq = [Zf, Zf, Zf,...
    Zf*ones(1,21),...
    Zf,height_htail, height_htail, height_htail];

%% 非结构集中质量点
%机身非结构集中质量点
MASS_fuse_nstr_mass = mass_body;
MASS_fuse_nstr_loc = cg_body;
%机翼非结构集中质量点
collect_nstr_mass
%% 全局计数器初始化
COORD_count = 0;
GRID_count=0;
MASS_count = 0;
RBAR_count = 0;
PBAR_count = 0;
CBAR_count = 0;
PSHELL_count = 0;
CQUAD_count = 0;
RBE2_count = 0;
AIRFOIL_count = 0;
CQUAD_area_count = 0;
CBAR_area_count = 0;
WING_PART_count = 0;
WING_BOX_count = 0;
WING_BOX_w_count = 0;
WING_BOX_h_count = 0;
WING_BOX_v_count = 0;
RIB_count = 0;
GRIDs_SET_count = 0;
CAERO_count = 0;
%
DESVAR_count = 0;
DVPREL1_count = 0;
DVPREL2_count = 0;
DRESP1_count = 0;
DRESP2_count = 0;
DCONSTR_count = 0;
DCONADD_count = 0;
DLINK_count = 0;
DEQATN_count = 0;
%% 单元id初始化
% GRID
GRID_w_id = 10000;
GRID_h_id = 30000;
GRID_v_id = 50000;
GRID_f_id = 60000;
% PBAR
PBAR_f_id = 100;
PBAR_rib_id = 101;
PBAR_w_id = 102;
PBAR_h_id = 200;
% PSHELL
PSHELL_w_id = 400;
PSHELL_h_id = 500;
PSHELL_v_id = 600;
% CBAR
CBAR_f_id = 10000;
CBAR_rib_id = 11000;
CBAR_w_id = 14000;
CBAR_h_id = 17000;
CBAR_v_id = 18000;
% CQUAD
CQUAD_w_id = 20000;
CQUAD_h_id = 23000;
CQUAD_v_id = 25000;
% RBAR
RBAR_f_id = 28000;
RBAR_w_id = 30000;
RBAR_h_id = 32000;
RBAR_v_id = 34000;
% CONM2
MASS_w_id = 40000;
MASS_h_id = 43000;
MASS_v_id = 44000;
MASS_f_id = 44500;% CONM2
% aero_id
GRIDs_SET_Rw_id = 1;
GRIDs_SET_Lw_id = 2;
GRIDs_SET_Rh_id = 3;
GRIDs_SET_Lh_id = 4;
GRIDs_SET_v_id = 5;
FLUTTER_mode_SET_id = 6;
PAERO_id = 100000;
CAERO_id_Rwing = 100000;
CAERO_id_Lwing = 200000;
CAERO_id_Rhtail = 300000;
CAERO_id_Lhtail = 400000;
CAERO_id_vtail = 500000;
FLFACT_rho_id = 1;
FLFACT_Ma_id = 2;
FLFACT_V_id = 3;
FLFACT_V_dresp_id = 4;
% DESVAR_id
DESVAR_id = 0;
DVPREL1_id = 100;
DVPREL2_id = 200;
DRESP_id = 300;
DEQATN_id = 0;
DCONSTR_id = 400;
DCONADD_1g_id = 1;
DCONADD_25g_id = 2;
DCONADD_roll_id = 3;
DCONADD_flutter_id = 4;
DCONADD_monotonic_id = 5;
SPC_long_id = 1;
SPC_lat_id = 2;
SPC_elas_id = 3;
% 
LOAD_id = 1;
FORCE_GRAV_id = 101;
FORCE_air_id = 102;
%% 对象初始化
grids = GRID(0, 0, [0,0,0]);
mass = MASS(0, 0, 0, 0, 0, 0, zeros(1,6));
pbar = PBAR(0, 1, 0, 0, 0, 0, 0,0, 0);
pshell = PSHELL(0, 1, 1, 0);
cbar = CBAR(0, 0, 0, [0,0,0], grids, 1,1);
cquad = CQUAD(0,0, 0,0,0,0, 0);
cbar_area = CBAR_area([0,0,0], [1,0,0], 1);
cquad_area = CQUAD_area([0,0,0],[0,0,0],[0,0,0],[0,0,0], 0);
wing_box = WING_BOX(0,0,0);
rbar = RBAR(0, 0, 0);
rib = RIB();
rbe2 = RBE2(0, 0, 0, 0, 0, 0);
desvar = DESVAR(0, 0, 0, 0, 0, 0, 0,0,0,0);
deqatn = DEQATN(0, []);
dvprel1 = DVPREL1(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
dvprel2 = DVPREL2(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
dconstr = DCONSTR(0, 0, 0, 0, 0, 0);
%% material
% MAT(id, E, NU, RHO)
mat(1) = MAT(1, 7.31e+10, 0.333, 2.78e3);
mat(2) = MAT(2, 7.31e+10, 0.333, 0);
MAT_bar_wing_num = 1;
MAT_str_wing_num = 1;
MAT_board_wing_num = 1;
MAT_bar_htail_num = 2;
MAT_str_htail_num = 2;
MAT_board_htail_num = 2;
MAT_rib_num = 2;
MAT_body_num = 2;

%% airfoil
get_airfoil_shape
%
AIRFOIL_count  = AIRFOIL_count+1;
airfoil(AIRFOIL_count) = AIRFOIL('toc12', 1, 0:0.1:1, 0.12*ones(11,1), 0.12);
AIRFOIL_count  = AIRFOIL_count+1;
airfoil(AIRFOIL_count) = AIRFOIL('NASA_SC2_06', 2, Xseq_NASA_SC2_06, Ybar_NASA_SC2_06, 0.12);
AIRFOIL_count  = AIRFOIL_count+1;
airfoil(AIRFOIL_count) = AIRFOIL('NACA0012', 3, Xseq_NACA0012, Ybar_NACA0012, 0.12);
% figure(30);
% airfoil(2).plot_airfoil();
airfoil_wing = 'NASA_SC2_06';
airfoil_htail = 'NACA0012';
%% build fuselage
build_fuselage

%%
build_aero

%%
build_wing_part

%% 
build_wing_box

%% print structure
fid=fopen('structure.dat','wt');
print_structure
fclose(fid);

%% print support
fid=fopen('constrain.dat','wt');
print_support
fclose(fid);

%% GRIDs_set
grids_to_delete = [
    61.94, -1.112, 2.782;
    61.94, 1.112, 2.782];
grids_to_delete_tol = 1e-2;
get_grids_SET

%% 气动面元
fid=fopen('aero.dat','wt');
print_aero2
fclose(fid);

%% 配平工况
fid=fopen('trim.dat','wt');
print_trim
fclose(fid);

%% static loads
fid=fopen('static_loads.dat','wt');
add_air_load
fclose(fid);

%% 颤振
fid=fopen('flutter.dat','wt');
print_flutter
fclose(fid);


%% 定义响应和约束
define_response_constrain

%% print_OPT_part
fid=fopen('opt_parameter.dat','wt');
print_OPT_part
fclose(fid);

%% 创建分析算例
build_analysis_cases


%% plot_everything
% plot_everything

%%
eta_y_seq = zeros(3, wing_box_num);
for ii=1:wing_box_num
    P_fspar = wing_box_w(ii).center_point_fspar();
    P_rspar = wing_box_w(ii).center_point_rspar();
    P_skin = wing_box_w(ii).center_point();
    eta_y_seq(1,ii) = 1 + P_fspar(2) / half_span_wing;
    eta_y_seq(2,ii) = 1 + P_rspar(2) / half_span_wing;
    eta_y_seq(3,ii) = 1 + P_skin(2) / half_span_wing;
end
save eta_y_seq eta_y_seq
