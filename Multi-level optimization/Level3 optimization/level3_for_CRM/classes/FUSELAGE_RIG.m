classdef FUSELAGE_RIG
    
    properties
        blocks_num;% 块序号组成的数组
        GRIDs_num;% 所有GRID的ii
        X_loc;
        Z_loc;
        n_node;
        MASS_num; 
        PBAR_num;
        CBARs_num;
        V;
        

    end
    
    methods
        function obj = FUSELAGE_RIG(X_loc,Z_loc,PBAR_num,V)
            obj.X_loc = X_loc;
            obj.Z_loc = Z_loc;
            obj.n_node = length(X_loc);
            obj.GRIDs_num = zeros(1,obj.n_node);
            obj.PBAR_num = PBAR_num;
            obj.V = V;
        end
        %
        function [obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id] =...
                create_fuse_block(obj, cbar,CBAR_count,CBAR_id, grids,GRID_count,GRID_id)
            for ii=1:obj.n_node-1
                P1 = [obj.X_loc(ii), 0, obj.Z_loc(ii)];
                P2 = [obj.X_loc(ii+1), 0, obj.Z_loc(ii+1)];
                if ii==1
                    GRID_count = GRID_count+1;
                    GRID_id = GRID_id+1;
                    grids(GRID_count) = GRID(GRID_id, 'fuselage', P1);
                    obj.GRIDs_num(ii) = GRID_count;
                end
                %
                GRID_count = GRID_count+1;
                GRID_id = GRID_id+1;
                grids(GRID_count) = GRID(GRID_id, 'fuselage', P2);
                obj.GRIDs_num(ii+1) = GRID_count;
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id+1;
                cbar(CBAR_count) = CBAR(CBAR_id, obj.PBAR_num, 'fuselage', obj.V,...
                    grids, GRID_count-1, GRID_count);
            end
        
        
%         function [obj, rbar,RBAR_count,RBAR_id, grids,GRID_count,GRID_id] =...
%                 create_fuse_block(obj, rbar,RBAR_count,RBAR_id, grids,GRID_count,GRID_id)
%             for ii=1:obj.n_node-1
%                 P1 = [obj.X_loc(ii), 0, obj.Z_loc(ii)];
%                 P2 = [obj.X_loc(ii+1), 0, obj.Z_loc(ii+1)];
%                 if ii==1
%                     GRID_count = GRID_count+1;
%                     GRID_id = GRID_id+1;
%                     grids(GRID_count) = GRID(GRID_id, 'fuselage', P1);
%                     obj.GRIDs_num(ii) = GRID_count;
%                 end
%                 %
%                 GRID_count = GRID_count+1;
%                 GRID_id = GRID_id+1;
%                 grids(GRID_count) = GRID(GRID_id, 'fuselage', P2);
%                 obj.GRIDs_num(ii+1) = GRID_count;
%                 %
%                 RBAR_count = RBAR_count+1;
%                 RBAR_id = RBAR_id+1;
%                 rbar(RBAR_count) = RBAR(GRID_count-1, GRID_count, RBAR_id);
%             end
        end
        
        function [obj, grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count] =...
                create_nstr_masses(obj, grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count, masses, mass_locs, desc)
            n_masses = length(masses);
            masses_locs = sortrows([masses, mass_locs], 2);
            index = 1;
            while masses_locs(index,2)<obj.X_loc(1)
                [grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count] = ...
                    create_CONmass(grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count, ...
                    'fuselage',desc, masses_locs(index,1), masses_locs(index,2:4), obj.GRIDs_num(1));
                obj.MASS_num = [obj.MASS_num, MASS_count];
                index = index+1;
                if index>n_masses
                    return;
                end
            end
            for ii=1:obj.n_node-1
                while masses_locs(index,2)>=obj.X_loc(ii) && masses_locs(index,2)<obj.X_loc(ii+1)
                    if masses_locs(index,2)-obj.X_loc(ii) < obj.X_loc(ii+1)-masses_locs(index,2)
                        grid_num = obj.GRIDs_num(ii);
                    else
                        grid_num = obj.GRIDs_num(ii+1);
                    end
                    [grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count] = ...
                        create_CONmass(grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count, ...
                        'fuselage',desc, masses_locs(index,1), masses_locs(index,2:4), grid_num);
                    obj.MASS_num = [obj.MASS_num, MASS_count];
                    index = index+1;
                    if index>n_masses
                        return;
                    end
                end
            end
            while index <= n_masses
                [grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count] = ...
                    create_CONmass(grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count, ...
                    'fuselage',desc, masses_locs(index,1), masses_locs(index,2:4), obj.GRIDs_num(end));
                obj.MASS_num = [obj.MASS_num, MASS_count];
                index = index+1;
                if index>n_masses
                    return;
                end
            end
        end
        
        function [grid_num] = find_grid(obj, Xp)
            if Xp<obj.X_loc(1)
                grid_num = obj.GRIDs_num(1);
                return
            elseif Xp>obj.X_loc(end)
                grid_num = obj.GRIDs_num(end);
                return
            end
            for ii=1:obj.n_node-1
                if Xp>=obj.X_loc(ii) && Xp<=obj.X_loc(ii+1)
                    if Xp-obj.X_loc(ii) < obj.X_loc(ii+1)-Xp
                        grid_num = obj.GRIDs_num(ii);
                    else
                        grid_num = obj.GRIDs_num(ii+1);
                    end
                    return;
                end
            end
        end
        function plot_fuselage(obj)
            plot3(obj.X_loc, zeros(1,obj.n_node), obj.Z_loc, '-*'); hold on;
        end
    end
end

