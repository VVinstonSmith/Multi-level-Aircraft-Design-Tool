clear;clc;
close all;

addpath(genpath('classes'));
addpath(genpath('print_program'));
addpath(genpath('build_model_process2'));

%% 全局计数器
GRID_count=0;
MASS_count = 0;
PBAR_count = 0;
CBAR_count = 0;
PSHELL_count = 0;
CQUAD_count = 0;
RBE2_count = 0;
CQUAD_area_count = 0;
CBAR_area_count = 0;


mat(1) = MAT(1, 2.6e+11, 0.333, 0);
%% 格式初始化
pbar = PBAR(0, 1, 0, 0, 0, 0, 0,0);
pshell = PSHELL(0, 1, 1);
cbar = CBAR();
cquad = CQUAD(0,0, 0,0,0,0, 0);
grids = GRID(0, 0, [0,0,0]);
cbar_area = CBAR_area([0,0,0], [0,0,0], 0);
cquad_area = CQUAD_area([0,0,0],[0,0,0],[0,0,0],[0,0,0], 0);


%%  part_initial_id 
PBAR_id = 1000;
PSHELL_id = 2000;
GRID_id = 100;
CBAR_id = 1000;
CQUAD_id = 2000;

%% build area

nc= 1;
nb = 2;
wing_box(1) =  WING_BOX('wing',nb,nc);
POINT1_f = [0, 0, 0.1];
POINT2_f = [0, 0, -0.1];
POINT3_f = [0, 0.5, 0.1];   POINT3_f(:,3) = POINT3_f(:,3) + 0.05;
POINT4_f = [0, 0.5, -0.1];  POINT4_f(:,3) = POINT4_f(:,3) + 0.05;
POINT1_r = [1, 0, 0.1];
POINT2_r = [1, 0, -0.1];
POINT3_r = [1, 0.5, 0.1];   POINT3_r(:,3) = POINT3_r(:,3) + 0.05;
POINT4_r = [1, 0.5, -0.1];  POINT4_r(:,3) = POINT4_r(:,3) + 0.05;
POINT1_s = [(0.1:0.1:0.9)', zeros(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
POINT2_s = [(0.1:0.1:0.9)', zeros(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
POINT3_s = [(0.1:0.1:0.9)', 0.5*ones(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT3_s(:,3) = POINT3_s(:,3) + 0.05;
POINT4_s = [(0.1:0.1:0.9)', 0.5*ones(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT4_s(:,3) = POINT4_s(:,3) + 0.05;
% create wingBox
wing_box(1) = wing_box(1).get_POINT_f(POINT1_f, POINT2_f, POINT3_f, POINT4_f);
wing_box(1) = wing_box(1).get_POINT_r(POINT1_r, POINT2_r, POINT3_r, POINT4_r);
wing_box(1) = wing_box(1).get_POINT_s(POINT1_s, POINT2_s, POINT3_s, POINT4_s);
%
[wing_box(1),pbar, PBAR_count,PBAR_id] = wing_box(1).create_PBAR_f(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 50, 20, 10);
[wing_box(1),pbar, PBAR_count,PBAR_id] = wing_box(1).create_PBAR_r(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 60, 20, 10);
[wing_box(1),pbar, PBAR_count,PBAR_id] = wing_box(1).create_PBAR_s(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 10, 20, 10);
%
[wing_box(1),pshell, PSHELL_count,PSHELL_id] = wing_box(1).create_PSHELL_f(PSHELL_count, PSHELL_id, pshell, 1, 0.15);
[wing_box(1),pshell, PSHELL_count,PSHELL_id] = wing_box(1).create_PSHELL_r(PSHELL_count, PSHELL_id, pshell, 1, 0.15);
[wing_box(1),pshell, PSHELL_count,PSHELL_id] = wing_box(1).create_PSHELL_b(PSHELL_count, PSHELL_id, pshell, 1, 1.5);
% cbar_area
[wing_box(1), cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
    wing_box(1).create_CBAR(cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id);
% cquad_area
[wing_box(1), cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] =...
    wing_box(1).create_CQUAD(cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id);


wing_box(2) =  WING_BOX('wing',nb,nc);
% POINT1_f = [0, 0, 0.1];
% POINT2_f = [0, 0, -0.1];
% POINT3_f = [0, -0.5, 0.1];   POINT3_f(:,3) = POINT3_f(:,3) + 0.05;
% POINT4_f = [0, -0.5, -0.1];  POINT4_f(:,3) = POINT4_f(:,3) + 0.05;
% POINT1_r = [1, 0, 0.1];
% POINT2_r = [1, 0, -0.1];
% POINT3_r = [1, -0.5, 0.1];   POINT3_r(:,3) = POINT3_r(:,3) + 0.05;
% POINT4_r = [1, -0.5, -0.1];  POINT4_r(:,3) = POINT4_r(:,3) + 0.05;
% POINT1_s = [(0.1:0.1:0.9)', zeros(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
% POINT2_s = [(0.1:0.1:0.9)', zeros(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
% POINT3_s = [(0.1:0.1:0.9)', -0.5*ones(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT3_s(:,3) = POINT3_s(:,3) + 0.05;
% POINT4_s = [(0.1:0.1:0.9)', -0.5*ones(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT4_s(:,3) = POINT4_s(:,3) + 0.05;
POINT3_f = [0, 0, 0.1];
POINT4_f = [0, 0, -0.1];
POINT1_f = [0, -0.5, 0.1];   POINT1_f(:,3) = POINT1_f(:,3) + 0.05;
POINT2_f = [0, -0.5, -0.1];  POINT2_f(:,3) = POINT2_f(:,3) + 0.05;
POINT3_r = [1, 0, 0.1];
POINT4_r = [1, 0, -0.1];
POINT1_r = [1, -0.5, 0.1];   POINT1_r(:,3) = POINT1_r(:,3) + 0.05;
POINT2_r = [1, -0.5, -0.1];  POINT2_r(:,3) = POINT2_r(:,3) + 0.05;
POINT3_s = [(0.1:0.1:0.9)', zeros(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
POINT4_s = [(0.1:0.1:0.9)', zeros(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];
POINT1_s = [(0.1:0.1:0.9)', -0.5*ones(9,1), [0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT1_s(:,3) = POINT3_s(:,3) + 0.05;
POINT2_s = [(0.1:0.1:0.9)', -0.5*ones(9,1), -[0.12;0.14;0.16;0.18;0.2;0.18;0.16;0.14;0.12]];  POINT2_s(:,3) = POINT4_s(:,3) + 0.05;

% create wingBox
wing_box(2) = wing_box(2).get_POINT_f(POINT1_f, POINT2_f, POINT3_f, POINT4_f);
wing_box(2) = wing_box(2).get_POINT_r(POINT1_r, POINT2_r, POINT3_r, POINT4_r);
wing_box(2) = wing_box(2).get_POINT_s(POINT1_s, POINT2_s, POINT3_s, POINT4_s);
%
[wing_box(2),pbar, PBAR_count,PBAR_id] = wing_box(2).create_PBAR_f(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 50, 20, 10);
[wing_box(2),pbar, PBAR_count,PBAR_id] = wing_box(2).create_PBAR_r(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 60, 20, 10);
[wing_box(2),pbar, PBAR_count,PBAR_id] = wing_box(2).create_PBAR_s(PBAR_count, PBAR_id, pbar, 1, 0.1, 0.1, 10, 20, 10);
%
[wing_box(2),pshell, PSHELL_count,PSHELL_id] = wing_box(2).create_PSHELL_f(PSHELL_count, PSHELL_id, pshell, 1, 0.15);
[wing_box(2),pshell, PSHELL_count,PSHELL_id] = wing_box(2).create_PSHELL_r(PSHELL_count, PSHELL_id, pshell, 1, 0.15);
[wing_box(2),pshell, PSHELL_count,PSHELL_id] = wing_box(2).create_PSHELL_b(PSHELL_count, PSHELL_id, pshell, 1, 1.5);
% cbar_area
[wing_box(2), cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
    wing_box(2).create_CBAR(cbar_area,CBAR_area_count, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id);
% cquad_area
[wing_box(2), cquad_area,CQUAD_area_count, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] =...
    wing_box(2).create_CQUAD(cquad_area,CQUAD_area_count, cbar_area, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id);

%% connect
[wing_box(2), wing_box(1), cbar_area, cquad_area, cbar, cquad] =...
    connect_wing_box_th(wing_box(2), wing_box(1), cbar_area, cquad_area, cbar, cquad);

%% plot
figure(10);
axis equal; hold on;
for ii = 1:length(wing_box)
    wing_box(ii).plot_rods(cbar_area, grids, 'ro-', 'bo-', 2);
end

figure(11);
axis equal; hold on;
for ii = 1:length(wing_box)
    wing_box(ii).plot_boards(cquad_area, grids, 'b', 2);
end





