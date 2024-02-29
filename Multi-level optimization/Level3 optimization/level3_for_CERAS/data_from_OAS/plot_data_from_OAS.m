clear;
close all;
clc;
addpath(genpath('./data_from_OAS'));

%% test transformed mesh
load airforce_AS1.txt
load wing_AS1_mesh.txt
load wing_transformed_mesh.txt
load airforce_points_AS1.txt
load point_masses_wing.txt
load point_massCGs_wing.txt

wing_num_x = 7;
wing_num_y = 21;

force_hat = 0;
for ii = 1:size(airforce_AS1,1)
    force = airforce_AS1(ii,:);
    force_norm = norm(force);
    if force_norm>force_hat
        force_hat = force_norm;
    end
end
airforce_AS1_hat = airforce_AS1 ./ force_hat;

%% plot wing_mesh
%

wing_mesh = reshape(wing_transformed_mesh, wing_num_y, wing_num_x, 3);
wing_AS1_mesh = reshape(wing_AS1_mesh, wing_num_y, wing_num_x, 3);
pts_origin = 0.75 * wing_mesh(1:end-1,1:end-1,:) + ...
             0.25 * wing_mesh(1:end-1,2:end,:) + ...
             0.75 * wing_mesh(2:end,1:end-1,:) + ...
             0.25 * wing_mesh(2:end,2:end,:);
pts_origin = pts_origin*0.5;
pts_AS1 = 0.75 * wing_AS1_mesh(1:end-1,1:end-1,:) + ...
          0.25 * wing_AS1_mesh(1:end-1,2:end,:) + ...
          0.75 * wing_AS1_mesh(2:end,1:end-1,:) + ...
          0.25 * wing_AS1_mesh(2:end,2:end,:);
pts_AS1 = pts_AS1*0.5;

figure(5);
% title('transformed mesh');
axis equal;
hold on;
xlabel('x')
ylabel('y')
mesh(wing_mesh(:,:,1), wing_mesh(:,:,2), wing_mesh(:,:,3));hold on;
mesh(wing_AS1_mesh(:,:,1), wing_AS1_mesh(:,:,2), wing_AS1_mesh(:,:,3));hold on;
% plot3(pts_origin(:,:,1), pts_origin(:,:,2), pts_origin(:,:,3), 'ro'); hold on;
% plot3(pts_AS1(:,:,1), pts_AS1(:,:,2), pts_AS1(:,:,3), 'b*'); hold on;
plot3(point_massCGs_wing(:,1), point_massCGs_wing(:,2), point_massCGs_wing(:,3), 'r*'); hold on;


for ii=1:(wing_num_x-1)*(wing_num_y-1)
    point = airforce_points_AS1(ii,:);
    vector = 2*airforce_AS1_hat(ii,:);
    plot3([point(1),point(1)+vector(1)], [point(2),point(2)+vector(2)], [point(3),point(3)+vector(3)], 'Linewidth', 2);
    hold on;
end







