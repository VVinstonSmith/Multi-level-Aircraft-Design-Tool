function fitness = fit_func(vars)

global opt_problem
global c_disp c_twist c_stress c_roll_eff c_flutter

%%
write_desvars(vars);

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
pause(5.5);
%%
[WEIGHT, stress_vio_max,...
    disp_vio_max, twist_vio_max, roll_eff_vio, flutter_vio] = ...
    read_obj_paras([file_name, '.f06']);
%%
cost = WEIGHT / 1e5 +...
        c_disp * abs(disp_vio_max) / 1e-1 +...
        c_twist * abs(twist_vio_max) / 1e-3+...
        c_stress * abs(stress_vio_max) / 1e8+...
        c_roll_eff * abs(roll_eff_vio) / 1e-1+...
        c_flutter *  abs(flutter_vio);

fitness = 1/cost;

if(roll_eff_vio~=0)
    disp('roll_eff_violate');
end
if(flutter_vio~=0)
    disp('flutter_violate');
end

end

