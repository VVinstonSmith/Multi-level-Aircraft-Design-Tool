
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(GRIDs_SET_Rw_id, 'wing', 'Rwing');
%
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(GRIDs_SET_Lw_id, 'wing', 'Lwing');
%
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(GRIDs_SET_Rh_id, 'htail', 'Rhtail');
%
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(GRIDs_SET_Lh_id, 'htail', 'Lhtail');
%
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(0, 'rib', []);
%
GRIDs_SET_count = GRIDs_SET_count + 1;
grids_set(GRIDs_SET_count) = GRIDs_SET(0, 'bar', []);

% Rwing:1
% Lwing:2
% Rhtail:3
% Lhtail:4

GS_count_ribs = 5;
%% grids in ribs
for ii = 1:length(rib)
    grid1 = grids(rib(ii).GRIDs_up_num(1)).loc;
    set_temp = [rib(ii).GRID_lead_num, rib(ii).GRIDs_up_num([1,fix(0.5*end),end]), rib(ii).GRID_tail_num];
    %
    grids_set(GS_count_ribs).GRIDs_num =...
                [grids_set(GS_count_ribs).GRIDs_num, set_temp];
    %
    if strcmp(rib(ii).region,'wing')==1 
        if grid1(2)>=-1e-8% Rwing
            grids_set(1).GRIDs_num =...
                [grids_set(1).GRIDs_num, set_temp];
        end
        if grid1(2)<=1e-8% Lwing
            grids_set(2).GRIDs_num =...
                [grids_set(2).GRIDs_num, set_temp];
        end
    elseif strcmp(rib(ii).region,'htail')==1
        if grid1(2)>=-1e-8% Rhtail
            grids_set(3).GRIDs_num =...
                [grids_set(3).GRIDs_num, set_temp];
        end
        if grid1(2)<=1e-8% Lhtail
            grids_set(4).GRIDs_num =...
                [grids_set(4).GRIDs_num, set_temp];
        end
    elseif strcmp(rib(ii).region,'vtail')==1
        grids_set(5).GRIDs_num =...
                [grids_set(5).GRIDs_num, set_temp];
    end
end
%% grids in wing bar
GS_count_bar = 6;
for ii=1:length(wing_box_w)
    CP = wing_box_w(ii).center_point();
    cbar_area1 = cbar_area(wing_box_w(ii).CBAR_uf_num);
    cbar_area2 = cbar_area(wing_box_w(ii).CBAR_ur_num);
    grids_group = [cbar_area1.GRIDi_num(2:end-1), cbar_area2.GRIDi_num(2:end-1)];
    %
    grids_set(GS_count_bar).GRIDs_num = [grids_set(GS_count_bar).GRIDs_num, grids_group];
    %
    if CP(2)>=0% Rwing
        grids_set(1).GRIDs_num = [grids_set(1).GRIDs_num, grids_group];
    end
    if CP(2)<=0% Lwing
        grids_set(2).GRIDs_num = [grids_set(2).GRIDs_num, grids_group];
    end
end
%% grids in htail bar
for ii=1:length(wing_box_h)
    CP = wing_box_h(ii).center_point();
    cbar_area1 = cbar_area(wing_box_h(ii).CBAR_uf_num);
    cbar_area2 = cbar_area(wing_box_h(ii).CBAR_ur_num);
    grids_group = [cbar_area1.GRIDi_num(2:end-1), cbar_area2.GRIDi_num(2:end-1)];
    %
    grids_set(GS_count_bar).GRIDs_num = [grids_set(GS_count_bar).GRIDs_num, grids_group];
    %
    if CP(2)>=0% Rwing
        grids_set(3).GRIDs_num = [grids_set(3).GRIDs_num, grids_group];
    end
    if CP(2)<=0% Lwing
        grids_set(4).GRIDs_num = [grids_set(4).GRIDs_num, grids_group];
    end
end 

%% delete grids
for ii=1:length(grids_set)
    jj=1;
    while jj<=length(grids_set(ii).GRIDs_num)
        for kk=1:size(grids_to_delete,1)
            grid_num = grids_set(ii).GRIDs_num(jj);
            distance = norm(grids(grid_num).loc - grids_to_delete(kk,:));
            if distance<grids_to_delete_tol
                grids_set(ii).GRIDs_num(jj)=[];
                jj=jj-1;
            end
        end
        jj=jj+1;
    end
end

%% sort wing_grids_set by x
grids_set(1) = grids_set(1).sort_x(grids);
grids_set(2) = grids_set(2).sort_x(grids);

        
        
        