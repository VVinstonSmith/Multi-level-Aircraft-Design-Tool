

%% plot aero_block
figure(1);
axis equal; hold on;
for ii = 1:length(aero_block)
    if strcmp(aero_block(ii).sub_region,'aileron')==1 || strcmp(aero_block(ii).sub_region,'elevator')==1 || strcmp(aero_block(ii).sub_region,'rudder')==1
        aero_block(ii).plot_block('r',1);
        aero_block(ii).plot_axis(3);
    else
        aero_block(ii).plot_block('r',1);
    end   
end
%% plot wing_parts
figure(2);
axis equal; hold on;
for ii= 1:WING_PART_count
    wing_part(ii).plot_shape();
    wing_part(ii).plot_block_point();
    wing_part(ii).plot_STRpoint_xyz();
end


%% print structure
figure(3);
axis equal; hold on;
fuselage.plot_fuselage()

% plot ribs
for ii = 1:length(rib)
    rib(ii).plot(grids, cbar, 'bo-', 2);
end

% plot mass 
for ii = 1:length(mass)
    mass(ii).plot(grids, 'r^');
end
plot3(MASS_wing_nstr_loc(:,1),MASS_wing_nstr_loc(:,2),MASS_wing_nstr_loc(:,3),'b^'); hold on;

%plot RBE2
for ii = 1:length(rbe2)
    if rbe2(ii).CM == 123456
        rbe2(ii).plot(grids, 'r-',1.5);
    elseif rbe2(ii).CM == 123
        rbe2(ii).plot(grids, 'g-',1.5);
    end
end
hold off;

% plot bars
figure(4);
axis equal; hold on;
for ii = 1:length(wing_box_w)
    wing_box_w(ii).plot_rods(cbar_area, grids, 'ro-', 'bo-', 2);
end
for ii = 1:length(wing_box_h)
    wing_box_h(ii).plot_rods(cbar_area, grids, 'ro-', 'bo-', 2);
end
% for ii = 1:length(wing_box_v)
%     wing_box_v(ii).plot_rods(cbar_area, grids, 'ro-', 'bo-', 2);
% end
hold off;

%plot shells
figure(22);
axis equal; hold on;
for ii = 1:length(wing_box_w)
    wing_box_w(ii).plot_boards(cquad_area, grids, 'b', 2);
end
for ii = 1:length(wing_box_h)
    wing_box_h(ii).plot_boards(cquad_area, grids, 'b', 2);
end
% for ii = 1:length(wing_box_v)
%     wing_box_v(ii).plot_boards(cquad_area, grids, 'b', 2);
% end
hold off;

%% plot GRIDs SET
figure(6);
axis equal; hold on;
grids_set(1).plot(grids,'*r');
figure(7);
axis equal; hold on;
grids_set(2).plot(grids,'*r');
figure(8);
axis equal; hold on;
grids_set(3).plot(grids,'*r');
figure(9);
axis equal; hold on;
grids_set(4).plot(grids,'*r');

figure(11);
axis equal; hold on;
grids_set(GS_count_ribs).plot(grids,'ob');
grids_set(GS_count_bar).plot(grids,'*r');



%% plot AERO
figure(12); 
axis equal; hold on;
for ii = 1:length(caero)
    if isempty(caero(ii).sub_region)
        linewidth  = 1;
        color = 'k';
    else
        linewidth  = 2;
        color = 'b';
    end
    caero(ii).plot_CAERO(color, linewidth);
end
hold off;


