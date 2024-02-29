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


%%  part_initial_id 
GRID_id = 100;
CBAR_id = 1000;
CQUAD_id = 2000;

%% build area
GRID1 = [0,0,0];
GRID2 = [1,0,0];
GRID3 = [0,1,0];
GRID4 = [1,1,0];
% CBAR_area(GRID1_loc, GRID2_loc, PBAR_num)
cbar_area(1) = CBAR_area(GRID1, GRID3, 1);
cbar_area(2) = CBAR_area(GRID2, GRID4, 1);

% [obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =
% create_CBAR(obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, n, region)
[cbar_area(1), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
    cbar_area(1).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, 10, 'wing');
[cbar_area(2), cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
    cbar_area(2).create_CBAR(cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id, 10, 'wing');

% CQUAD_area(GRID1_loc,GRID2_loc,GRID3_loc,GRID4_loc, PSHELL_num)
cquad_area = CQUAD_area(GRID1,GRID2,GRID3,GRID4, 5);

% [obj, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] =...
%     create_CQUAD(obj, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, m, CBAR_area1, CBAR_area2, region)
[cquad_area, cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id] =...
    cquad_area.create_CQUAD(cquad,CQUAD_count,CQUAD_id, grids,GRID_count,GRID_id, 3, cbar_area(1), cbar_area(2), 'wing');


%% plot
figure(10);
axis equal; hold on;
cbar_area(1).plot_cbar(grids, 'ro-', 3);
cbar_area(2).plot_cbar(grids, 'ro-', 3);

cquad_area.plot_quad(grids, 'b*-', 2);








