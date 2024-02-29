addpath(genpath('../data_from_OAS'));

load point_masses_wing.txt
load point_massCGs_wing.txt

point_masses_wing_left = point_masses_wing;
point_masses_wing_right = point_masses_wing;

point_massCGs_wing_left = point_massCGs_wing;
point_massCGs_wing_right = point_massCGs_wing;
point_massCGs_wing_right(:,2) = -point_massCGs_wing_right(:,2);

% 机翼非结构集中质量点
MASS_wing_nstr_mass = [point_masses_wing_left; point_masses_wing_right];
MASS_wing_nstr_loc = [point_massCGs_wing_left; point_massCGs_wing_right];

% figure(255);
% axis equal;hold on;
% for ii=1:size(MASS_wing_nstr_mass)
%     plot3(MASS_wing_nstr_loc(ii,1), MASS_wing_nstr_loc(ii,2), MASS_wing_nstr_loc(ii,3), '*');
%     hold on;
% end

% 平尾非结构集中质量点
MASS_htail_nstr_mass = [];
MASS_htail_nstr_loc = [];

