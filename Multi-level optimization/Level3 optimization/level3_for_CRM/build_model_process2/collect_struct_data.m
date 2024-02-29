
addpath(genpath('../data_from_OAS'));

global toc_wing
global A_fspar_wing A_rspar_wing A_str_total_wing
global t_fweb_wing t_rweb_wing t_skin_wing
global toc_htail
global A_fspar_htail A_rspar_htail A_str_total_htail
global t_fweb_htail t_rweb_htail t_skin_htail
% 
load toc_wing.txt
load A_fspar_wing.txt
load A_rspar_wing.txt
load A_str_total_wing.txt
load t_skin_wing.txt
load t_fweb_wing.txt
load t_rweb_wing.txt
%
load toc_htail.txt
load A_fspar_htail.txt
load A_rspar_htail.txt
load A_str_total_htail.txt
load t_skin_htail.txt
load t_fweb_htail.txt
load t_rweb_htail.txt

load flight_condition_paras.txt
load wing_geometry_paras.txt
load htail_geometry_paras.txt
load control_surface_paras.txt
load fuselage_paras.txt
load weight_paras.txt

t_skin_wing(2,:)  = t_skin_wing(2,:) * 1e-3;
t_fweb_wing(2,:)  = t_fweb_wing(2,:) * 1e-3;
t_rweb_wing(2,:)  = t_rweb_wing(2,:) * 1e-3;
t_skin_htail(2,:)  = t_skin_htail(2,:) * 1e-3;
t_fweb_htail(2,:)  = t_fweb_htail(2,:) * 1e-3;
t_rweb_htail(2,:)  = t_rweb_htail(2,:) * 1e-3;

% disp('load data finished')
% 
% figure(31);
% plot(toc_wing(1,:), toc_wing(2,:), '*-');
% hold off
% figure(32);
% plot(A_fspar_wing(1,:), A_fspar_wing(2,:), '*-'); hold on;
% plot(A_rspar_wing(1,:), A_rspar_wing(2,:), '*-'); hold on;
% plot(A_str_total_wing(1,:), A_str_total_wing(2,:), '*-'); hold on;
% hold off
% figure(33);
% plot(1-t_skin_wing(1,:), t_skin_wing(2,:), '*r-'); hold on;
% plot(1-t_fweb_wing(1,:), t_fweb_wing(2,:), '*k-'); hold on;
% plot(1-t_rweb_wing(1,:), t_rweb_wing(2,:), '*b-'); hold on;
% hold off
% 
% figure(34);
% plot(toc_htail(1,:), toc_htail(2,:), '*-');
% hold off
% figure(35);
% plot(A_fspar_htail(1,:), A_fspar_htail(2,:), '*-'); hold on;
% plot(A_rspar_htail(1,:), A_rspar_htail(2,:), '*-'); hold on;
% plot(A_str_total_htail(1,:), A_str_total_htail(2,:), '*-'); hold on;
% hold off
% figure(36);
% plot(t_skin_htail(1,:), t_skin_htail(2,:), '*-'); hold on;
% plot(t_fweb_htail(1,:), t_fweb_htail(2,:), '*-'); hold on;
% plot(t_rweb_htail(1,:), t_rweb_htail(2,:), '*-'); hold on;
% hold off
% 
% 


