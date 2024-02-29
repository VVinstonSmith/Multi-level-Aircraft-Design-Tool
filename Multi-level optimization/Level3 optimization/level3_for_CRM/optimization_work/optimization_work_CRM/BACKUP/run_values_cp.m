fclose all;
use_saved_data = true;
%% global params
global span_num_cp
global wing_box_num 
global eta_y_seq
global var_mode
global opt_problem
%% plot
if var_mode==3
    i_fweb=1; i_rweb=2; i_skin=3;
elseif var_mode==5
    i_fspar=1; i_rspar=2; i_fweb=3; i_rweb=4; i_skin=5;
elseif var_mode==6
    i_fspar=1; i_rspar=2; i_str=3; i_fweb=4; i_rweb=5; i_skin=6;
else
    disp('error');
end
if use_saved_data
    load(['values_cp_', opt_problem], 'values_cp');
end

x_cp = linspace(0, 1., span_num_cp);
values = zeros(var_mode, wing_box_num);
for ii=1:var_mode
    bsp = BSpline([x_cp', values_cp(ii,:)'], 4);
    [xs,values(ii,:)] = bsp.evaluate_batch(eta_y_seq(ii,:));
end

figure(21);
title('fweb'); hold on;
plot(x_cp, values_cp(i_fweb,:), '-o'); hold on;
plot(eta_y_seq(i_fweb,:), values(i_fweb,:), '-*'); hold on;
grid on; hold off;
figure(22);
title('rweb'); hold on;
plot(x_cp, values_cp(i_rweb,:), '-o');
plot(eta_y_seq(i_rweb,:), values(i_rweb,:), '-*');
grid on; hold off;
figure(24);
title('fweb and rweb'); hold on;
plot(eta_y_seq(i_fweb,:), values(i_fweb,:), '-o'); hold on;
plot(eta_y_seq(i_rweb,:), values(i_rweb,:), '-v'); hold on;
plot(0.5*eta_y_seq(i_fweb,:)+0.5*eta_y_seq(i_rweb,:), values(i_fweb,:)+values(i_rweb,:), '-r*'); hold on;
grid on; hold off;
figure(23);
title('skin'); hold on;
plot(x_cp, values_cp(i_skin,:), '-o');
plot(eta_y_seq(i_skin,:), values(i_skin,:), '-*');
grid on; hold off;
if var_mode==5 || var_mode==6
    figure(24);
    title('fspar'); hold on;
    plot(x_cp, values_cp(i_fspar,:), '-o');
    plot(eta_y_seq(i_fspar,:), values(i_fspar,:), '-*');
    gird on; hold off;
    figure(25);
    title('rspar'); hold on;
    plot(x_cp, values_cp(i_rspar,:), '-o');
    plot(eta_y_seq(i_rspar,:), values(i_rspar,:), '-*');
    grid on; hold off;
end
if var_mode==6
    figure(26);
    title('str'); hold on;
    plot(x_cp, values_cp(i_str,:), '-o');
    plot(eta_y_seq(i_str,:), values(i_str,:), '-*');
    grid on; hold off;
end
%%
write_desvars(values_cp);
%% delete old files
% path_head = 'D:\aircraft_rodShell_model\GA_method\bdf_files\';
file_name = opt_problem;
if exist([file_name, '.f06'], 'file')
    delete ([file_name, '.f06'])
end
if exist([file_name, '.f04'], 'file')
    delete ([file_name, '.f04'])
end
if exist([file_name, '.DBALL'], 'file')
    delete ([file_name, '.DBALL'])
end
if exist([file_name, '.IFPDAT'], 'file')
    delete ([file_name, '.IFPDAT'])
end
if exist([file_name, '.log'], 'file')
    delete ([file_name, '.log'])
end
if exist([file_name, '.MASTER'], 'file')
    delete ([file_name, '.MASTER'])
end
if exist([file_name, '.xdb'], 'file')
    delete ([file_name, '.xdb'])
end

%% run Nastran
nastran = 'nastranw.exe';
bdf_file = ['bdf_files\', file_name, '.bdf'];
system([nastran, ' ', bdf_file]);

while ~exist([file_name, '.f06'],'file')
end
fsize = 0;
while fsize<1e6
    fid = fopen([file_name, '.f06']);
    fseek(fid,0,'eof');
    fsize = ftell(fid);
    fclose(fid);
end
pause(5);
%%
[WEIGHT, stress_vio_max,...
    disp_vio_max, twist_vio_max, roll_eff_vio, flutter_vio] = ...
    read_obj_paras([file_name, '.f06']);

global c_disp c_twist c_stress c_roll_eff c_flutter
c_disp = 20;
c_twist = 20;
c_stress = 10;
c_roll_eff = 5;
c_flutter = 5;
cost = WEIGHT / 1e5 +...
        c_disp * abs(disp_vio_max) / 1e-1 +...
        c_twist * abs(twist_vio_max) / 1e-3+...
        c_stress * abs(stress_vio_max) / 1e8+...
        c_roll_eff * abs(roll_eff_vio) / 1e-1+...
        c_flutter *  abs(flutter_vio) / 1e-3;
fitness = 1/cost;
