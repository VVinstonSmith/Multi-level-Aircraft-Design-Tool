% clear;close all;fclose all;
use_saved_data = true;

addpath(genpath('GA_algorithm'));
addpath(genpath('BSpline'));
addpath(genpath('print_program'));
addpath(genpath('bdf_files'));

global span_num_cp
global wing_box_num 
global eta_y_seq
global var_mode
global opt_problem
global filename_desvar

load eta_y_seq
var_mode = size(eta_y_seq, 1);
wing_box_num = size(eta_y_seq, 2);
span_num_cp = 5;
opt_problem = 'sol200b';
filename_desvar = 'bdf_files\desvar.dat';

if use_saved_data
    load(['values_cp_', opt_problem], 'values_cp');
else
%     t_fweb_cp = 1e-3*[1.50000, 1.50000, 8.91411, 9.00040, 6.94606];
%     t_fweb_cp = 1e-3*[1.5, 9.6, 1.7, 2.1, 2.9];
%     t_rweb_cp = 1e-3*[1.5, 2.7, 2.4, 18, 20];
%     t_skin_cp = 1e-3*[1.5, 1.9, 2.4, 11.3, 10.7];
    t_fweb_cp = 1e-3*[1.5, 7, 2.1, 15, 15];
    t_rweb_cp = 1e-3*[1.5, 7, 2.1, 15, 15];
    t_skin_cp = 1e-3*[1.5, 1.9, 2.4, 11.3, 10.7];
%     t_fweb_cp = t_fweb_cp - 1e-4;
%     t_rweb_cp = t_rweb_cp - 1e-4;
%     t_skin_cp = t_skin_cp - 1e-4;
    values_cp = [t_fweb_cp; t_rweb_cp; t_skin_cp];
end

%% compute values from values_cp via bspline
x_cp = linspace(0, 1., span_num_cp);
values = zeros(var_mode, wing_box_num);
for ii=1:var_mode
    bsp = BSpline([x_cp', values_cp(ii,:)'], 4);
    [xs,values(ii,:)] = bsp.evaluate_batch(eta_y_seq(ii,:));
end
var_values = reshape(values, var_mode, wing_box_num);
save(['../var_values_', opt_problem, '.mat'], 'var_values');
% for ii=1:var_mode
%     figure(ii);
%     plot(x_cp, values_cp(ii,:), 'o'); hold on;
%     plot(eta_y_seq(ii,:), values(ii,:), '*-'); hold on;
% end

global XLB_skin XUB_skin XLB_web XUB_web
global XLB_spar XUB_spar XLB_str XUB_str
XLB_spar = 1.000E-5;
XUB_spar = 1.000E-2;
XLB_str = 1.000E-2;
XUB_str = 1.000E-4;
XLB_skin = 1.000E-3;
XUB_skin = 1.000E-1;
XLB_web = 1.000E-3;
XUB_web = 1.000E-1;
% fspar, rspar, str, fweb, rweb, skin
    
var_id = 1;
pbar_id = 1;
pshell_id = 1;
for ii=1:wing_box_num
    if var_mode==6 || var_mode==5
        % fspar
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_spar, XUB_spar, [],...
                'wing', ii, 'fspar', ii);
        var_id = var_id + 1;
        % rspar
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_spar, XUB_spar, [],...
                'wing', ii, 'rspar', ii);
        var_id = var_id + 1;
    end
    if var_mode==6
        % str
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_str, XUB_str, [],...
                'wing', ii, 'str', ii);
        var_id = var_id + 1;
    end
    % fweb
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_web, XUB_web, [],...
            'wing', ii, 'fweb', ii);
    var_id = var_id + 1;
    % fweb
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_web, XUB_web, [],...
            'wing', ii, 'rweb', ii);
    var_id = var_id + 1;
    % skin
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_skin, XUB_skin, [],...
            'wing', ii, 'skin', ii);
    var_id = var_id + 1;
end
%%  print card
fid=fopen(filename_desvar,'wt');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DESVAR  ID      LABEL   XINIT   XLB     XUB     DELXV\n');

for ii=1:length(desvar)
    desvar(ii).print_XINT(fid);
end
fclose(fid);


