
addpath(genpath('../data_from_OAS'));
addpath(genpath('../Spline_interp'));

load airforce_AS1.txt
load wing_transformed_mesh.txt
Fa = airforce_AS1;% (n_mesh,3)
set_Lwing = 2;
set_Rwing = 1;

% wing_mesh
n_mesh = (wing_num_x-1) * (wing_num_y-1);
wing_mesh = reshape(wing_transformed_mesh, wing_num_y, wing_num_x, 3);
% aero nodes
pts_origin = 0.75 * wing_mesh(1:end-1,1:end-1,:) + ...
             0.25 * wing_mesh(1:end-1,2:end,:) + ...
             0.75 * wing_mesh(2:end,1:end-1,:) + ...
             0.25 * wing_mesh(2:end,2:end,:);
pts_origin = pts_origin*0.5;
xya = reshape(pts_origin, [n_mesh,3]);
% struct nodes
n_struct = length(grids_set(set_Lwing).GRIDs_num);
xys = zeros(n_struct, 3);
for ii=1:n_struct
    xys(ii,:) = grids(grids_set(set_Lwing).GRIDs_num(ii)).loc;
end
[As, Aa, Aas] = spline2(xys(:,1:2), xya(:,1:2));
Fs = Aas' * Fa;
%% symmetry
xya_sym = xya;
xya_sym(:,2) = -xya_sym(:,2);
n_struct_sym = length(grids_set(set_Rwing).GRIDs_num);
xys_sym = zeros(n_struct_sym, 3);
for ii=1:n_struct_sym
    xys_sym(ii,:) = grids(grids_set(set_Rwing).GRIDs_num(ii)).loc;
end
[As_sym, Aa_sym, Aas_sym] = spline2(xys_sym(:,1:2), xya_sym(:,1:2));
%Fs_sym = Aas_sym' * Fa;
Fs_sym = Fs;

%% print
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
% LOAD
print_LOAD(fid, LOAD_id, 1, [1,1], [FORCE_GRAV_id,FORCE_air_id]);
% gravity
print_GRAV(fid, FORCE_GRAV_id, 0, 9.8*2.5, [0,0,-1]);
% air_loads
for ii=1:n_struct
    GID = grids_set(set_Lwing).GRIDs_id(ii);
    Fs_norm = norm(Fs(ii,:));
    print_FORCE(fid, FORCE_air_id, GID, 0, Fs_norm, Fs(ii,:)/Fs_norm);
end
for ii=1:n_struct_sym
    GID = grids_set(set_Rwing).GRIDs_id(ii);
    Fs_norm = norm(Fs_sym(ii,:));
    print_FORCE(fid, FORCE_air_id, GID, 0, Fs_norm, Fs_sym(ii,:)/Fs_norm);
end

%% Lift of wing
Lift = 2*sum(Fa)*[-sin(alpha_25g); 0; cos(alpha_25g)];

%% test force interp
% figure(1);
% axis equal; hold on;
% F_hat = norm(max(Fa))*0.05;
% moment_s = 0;
% for ii=1:n_struct
%     plot3(xys(ii,1), xys(ii,2), norm(Fs(ii,:))/F_hat, 'r*');
%     moment_s = moment_s + xys(ii,1:2).*Fs(ii,3);
%     hold on;
% end
% moment_a = 0;
% for ii=1:n_mesh
%     plot3(xya(ii,1), xya(ii,2), norm(Fa(ii,:))/F_hat, 'bo');
%     moment_a = moment_a + xya(ii,1:2).*Fa(ii,3);
%     hold on;
% end

%% test spline2 with defromation from xya to xys
% addpath(genpath('../data_from_OAS'));
% addpath(genpath('../Spline_interp'));
% 
% load wing_transformed_mesh.txt
% load wing_AS1_mesh.txt
% 
% wing_num_x = 5;
% wing_num_y = 11;
% n_mesh = (wing_num_x-1) * (wing_num_y-1);
% %
% wing_mesh = reshape(wing_transformed_mesh, wing_num_y, wing_num_x, 3);
% pts_origin = 0.75 * wing_mesh(1:end-1,1:end-1,:) + ...
%              0.25 * wing_mesh(1:end-1,2:end,:) + ...
%              0.75 * wing_mesh(2:end,1:end-1,:) + ...
%              0.25 * wing_mesh(2:end,2:end,:);
% pts_origin = pts_origin*0.5;
% %
% wing_AS1_mesh = reshape(wing_AS1_mesh, wing_num_y, wing_num_x, 3);
% pts_AS1 = 0.75 * wing_AS1_mesh(1:end-1,1:end-1,:) + ...
%                  0.25 * wing_AS1_mesh(1:end-1,2:end,:) + ...
%                  0.75 * wing_AS1_mesh(2:end,1:end-1,:) + ...
%                  0.25 * wing_AS1_mesh(2:end,2:end,:);
% pts_AS1 = pts_AS1*0.5;
% %
% deform_air = pts_AS1 - pts_origin;
% deform_air_row = reshape(deform_air,[n_mesh,3]);
% 
% figure(1);
% %axis equal; hold on;
% plot3(pts_origin(:,:,1), pts_origin(:,:,2), deform_air(:,:,3), 'bo-'); hold on;
% 
% n_struct = length(grids_set(2).GRIDs_num);
% xys = zeros(n_struct, 3);
% xya = reshape(pts_origin, [n_mesh,3]);
% for ii=1:n_struct
%     xys(ii,:) = grids(grids_set(2).GRIDs_num(ii)).loc;
% end
% [Aa, As, Asa] = spline2(xya, xys);
% deform_struct = Asa* deform_air_row;
% 
% for ii=1:n_struct
%     plot3(xys(ii,1), xys(ii,2), deform_struct(ii,3), 'r*');
%     hold on;
% end



