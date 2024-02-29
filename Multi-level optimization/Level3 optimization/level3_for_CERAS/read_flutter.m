clear;
close all;

n_modes = 15;
n_vel = 15;
% velocity = [160, 180, 200, 220, 240];
kfreq = zeros(n_modes, n_vel);
velocity = zeros(n_modes, n_vel);
frequency = zeros(n_modes, n_vel);
damping = zeros(n_modes, n_vel);

fid = fopen('SOL145.f06');

%% read results
while ~feof(fid)
    tline=fgetl(fid);
    if length(tline)>70
        if ~isempty(strfind(tline, 'FLUTTER  SUMMARY'))
            disp(tline);
            break;
        end
    end
end

%% read data
for ii=1:n_modes
    while ~feof(fid)
        tline=fgetl(fid);
        if ~isempty(strfind(tline, 'KFREQ            1./KFREQ         VELOCITY'))
            break;
        end
    end
    for jj=1:n_vel
        tline=fgetl(fid);
        kfreq(ii,jj) = str2double(tline(7:16));
        velocity(ii,jj) = str2double(tline(38:54));
        damping(ii,jj) = str2double(tline(55:72));
        frequency(ii,jj) = str2double(tline(73:91));
    end
end
fclose(fid);

figure(1);
h1 = plot(velocity(1,:), damping(1,:), 'o-'); hold on;
h2 = plot(velocity(2,:), damping(2,:), '+-'); hold on;
h3 = plot(velocity(3,:), damping(3,:), '*-'); hold on;
h4 = plot(velocity(4,:), damping(4,:), '.-'); hold on;
h5 = plot(velocity(5,:), damping(5,:), 'x-'); hold on;
h6 = plot(velocity(6,:), damping(6,:), 's-'); hold on;
h7 = plot(velocity(7,:), damping(7,:), 'd-'); hold on;
h8 = plot(velocity(8,:), damping(8,:), '^-'); hold on;
h9 = plot(velocity(9,:), damping(9,:), 'v-'); hold on;
h10 = plot(velocity(10,:), damping(10,:), '>-'); hold on;
h11 = plot(velocity(11,:), damping(11,:), '<-'); hold on;
h12 = plot(velocity(12,:), damping(12,:), 'p-'); hold on;
h13 = plot(velocity(13,:), damping(13,:), 'h-'); hold on;
h14 = plot(velocity(14,:), damping(14,:), '*:'); hold on;
h15 = plot(velocity(15,:), damping(15,:), 'o:'); hold on;
ylabel('g'); xlabel('V(m/s)')
legend([h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,h15], ...
    'mode1','mode2','mode3','mode4','mode5','mode6','mode7','mode8',...
    'mode9','mode10','mode11','mode12','mode13','mode14','mode15');
hold off;

figure(2);
h1 = plot(velocity(1,:), frequency(1,:), 'o-'); hold on;
h2 = plot(velocity(2,:), frequency(2,:), '+-'); hold on;
h3 = plot(velocity(3,:), frequency(3,:), '*-'); hold on;
h4 = plot(velocity(4,:), frequency(4,:), '.-'); hold on;
h5 = plot(velocity(5,:), frequency(5,:), 'x-'); hold on;
h6 = plot(velocity(6,:), frequency(6,:), 's-'); hold on;
h7 = plot(velocity(7,:), frequency(7,:), 'd-'); hold on;
h8 = plot(velocity(8,:), frequency(8,:), '^-'); hold on;
h9 = plot(velocity(9,:), frequency(9,:), 'v-'); hold on;
h10 = plot(velocity(10,:), frequency(10,:), '>-'); hold on;
h11 = plot(velocity(11,:), frequency(11,:), '<-'); hold on;
h12 = plot(velocity(12,:), frequency(12,:), 'p-'); hold on;
h13 = plot(velocity(13,:), frequency(13,:), 'h-'); hold on;
h14 = plot(velocity(14,:), frequency(14,:), '*:'); hold on;
h15 = plot(velocity(15,:), frequency(15,:), 'o:'); hold on;
ylabel('f(Hz)'); xlabel('V(m/s)')
legend([h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,h15], ...
    'mode1','mode2','mode3','mode4','mode5','mode6','mode7','mode8',...
    'mode9','mode10','mode11','mode12','mode13','mode14','mode15');