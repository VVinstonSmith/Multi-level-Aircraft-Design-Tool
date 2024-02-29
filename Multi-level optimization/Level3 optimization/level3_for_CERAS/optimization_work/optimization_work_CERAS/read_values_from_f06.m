global wing_box_num 
global var_mode
global opt_problem

fid = fopen([opt_problem, '.f06']);
n_vars = var_mode*wing_box_num;
weight = 0;
values = zeros(n_vars, 1);
% constr_ids = zeros(100,1);
% constr_vals = zeros(100,1);

%% read results
while ~feof(fid)
    tline=fgetl(fid);
    if length(tline)>80
        if ~isempty(strfind(tline, 'S U M M A R Y   O F   D E S I G N    C Y C L E    H I S T O R Y'))
            %disp(tline);
            break;
        end
    end
end

%% read vars
while ~feof(fid)
    tline=fgetl(fid);
    if ~isempty(strfind(tline, 'DESIGN VARIABLE HISTORY'))
        break;
    end
end
while ~feof(fid)
    tline=fgetl(fid);
    if length(tline)>50
        var_id = str2num(tline(17:25));
        if var_id<1000
            values(var_id) = str2double(tline(end-13:end-2));
        end
    end
end
fclose(fid);
% save values values
%%
for ii=1:n_vars
    desvar(ii).XFIN = values(ii);
end
if var_mode==5 || var_mode==6
    figure(20);
    title('fspar'); hold on;
    for ii=1:length(desvar)
        if strcmp(desvar(ii).component,'fspar')
            plot(desvar(ii).y, desvar(ii).XFIN, '*');
            hold on;
        end
    end
    grid on;
    hold off;
    %
    figure(21);
    title('rspar'); hold on;
    for ii=1:length(desvar)
        if strcmp(desvar(ii).component,'rspar')
            plot(desvar(ii).y, desvar(ii).XFIN, '*');
            hold on;
        end
    end
    grid on;
    hold off;
end
%
if var_mode==6
    figure(22);
    title('str'); hold on;
    for ii=1:length(desvar)
        if strcmp(desvar(ii).component,'str')
            plot(desvar(ii).y, desvar(ii).XFIN, '*');
            hold on;
        end
    end
    grid on;
    hold off;
end
%
figure(33);
title('skin'); hold on;
for ii=1:length(desvar)
    if strcmp(desvar(ii).component,'skin')
        plot(desvar(ii).y, desvar(ii).XFIN, '*');
        hold on;
    end
end
grid on;
hold off;
%
figure(34);
title('fweb'); hold on;
for ii=1:length(desvar)
    if strcmp(desvar(ii).component,'fweb')
        plot(desvar(ii).y, desvar(ii).XFIN, '*');
        hold on;
    end
end
grid on;
hold off;
%
figure(35);
title('rweb'); hold on;
for ii=1:length(desvar)
    if strcmp(desvar(ii).component,'rweb')
        plot(desvar(ii).y, desvar(ii).XFIN, '*');
        hold on;
    end
end
grid on;
hold off;

