clear;clc;close all;
fclose all;
%% add function paths
addpath(genpath('GA_algorithm'));
addpath(genpath('BSpline'));
addpath(genpath('print_program'));
addpath(genpath('bdf_files'));
%% define global params
global span_num_cp
global wing_box_num 
global eta_y_seq
global var_mode
global filename_desvar
global opt_problem
global XLB_skin XUB_skin XLB_web XUB_web
global XLB_spar XUB_spar XLB_str XUB_str
global c_disp c_twist c_stress c_roll_eff c_flutter
%% settings input
reset_tip_limit = true;
run_past = true;
new_pop_num = 4;
%% params input
span_num_cp = 5;
filename_desvar = 'bdf_files\desvar.dat';
opt_problem = 'sol200b';
%% var_scope:
XLB_spar = 2.000E-5;
XUB_spar = 1.000E-3;
XLB_str = 1.000E-5;
XUB_str = 1.000E-3;
XLB_skin = 1.500E-3;
XUB_skin = 2.000E-2;
XLB_web = 1.500E-3;
XUB_web = 2.000E-2;
min_tip_value = [1.500E-3; 1.500E-3; 1.500E-3];
max_tip_value = [2.000E-3; 2.000E-3; 2.000E-3];
%% cost coeffs:
c_disp = 20;
c_twist = 20;
c_stress = 10;
c_roll_eff = 5;
c_flutter = 5;
% c_disp = 0;
% c_twist = 0;
% c_roll_eff =0;
% c_flutter = 0;
%% GA params:
NUMPOP=60;
LENGTH=32;
ITERATION=30;
cross_rate=0.6;
sub_cross_rate=0.8;
variation_rate=0.01;
%% loading area distribution
load eta_y_seq
var_mode = size(eta_y_seq, 1);
wing_box_num = size(eta_y_seq, 2);
%% set opt range 
if var_mode==3
    range_L = repmat([XLB_web; XLB_web; XLB_skin], [span_num_cp,1]);
    range_R = repmat([XUB_web; XUB_web; XUB_skin], [span_num_cp,1]);
elseif var_mode==5
    range_L = repmat([XLB_spar; XLB_spar; XLB_web; XLB_web; XLB_skin], [span_num_cp,1]);
    range_R = repmat([XUB_spar; XUB_spar; XUB_web; XUB_web; XUB_skin], [span_num_cp,1]);
elseif var_mode==6
    range_L = repmat([XLB_spar; XLB_spar; XLB_str; XLB_web; XLB_web; XLB_skin], [span_num_cp,1]);
    range_R = repmat([XUB_spar; XUB_spar; XUB_str; XUB_web; XUB_web; XUB_skin], [span_num_cp,1]);
else
    disp('error');
end
if reset_tip_limit
    range_L(1:length(min_tip_value)) = min_tip_value;
    range_R(1:length(max_tip_value)) = max_tip_value;
end
%% run optimization
pop=[]; 
if run_past == true
    load(['pop_', opt_problem], 'pop');
end
[pop, pop_result] = GA_method(...
    @fit_func, range_L, range_R,...
    NUMPOP, LENGTH, ITERATION,...
    cross_rate, sub_cross_rate, variation_rate,...
    run_past, pop, new_pop_num);

save(['pop_', opt_problem], 'pop');
save(['pop_result_', opt_problem], 'pop_result');

%% restore vars to desvars
vars = pop(:,1);
% fspar, rspar, str, fweb, rweb, skin
if var_mode==3
    var_Lallow = [XLB_web; XLB_web; XLB_skin];
elseif var_mode==5
    var_Lallow = [XLB_spar; XLB_spar; XLB_web; XLB_web; XLB_skin];
elseif var_mode==6
    var_Lallow = [XLB_spar; XLB_spar; XLB_str; XLB_web; XLB_web; XLB_skin];
else
    disp('error');
end
%
values_cp = reshape(vars,[var_mode, span_num_cp]);
save(['values_cp_', opt_problem], 'values_cp');




