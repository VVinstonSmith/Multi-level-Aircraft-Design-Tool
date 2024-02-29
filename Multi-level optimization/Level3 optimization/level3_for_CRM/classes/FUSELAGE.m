classdef FUSELAGE
    
    properties
        blocks_num;% 块序号组成的数组
        GRIDs_num;% 所有GRID的ii
        
        X_start;% 机头位置
        X_end;% 机尾位置   
        X_loc;
        X_seq;% 位置序列(用于对结构质量和刚度做插值)
        Z_seq;
        RHO_STR_seq;% 结构线密度序列
        EI1_seq;% 刚度序列
        EI2_seq;% 
        GJ_seq;% 
        h_seq;
        b_seq;
        
    end
    
    methods
        function obj = FUSELAGE(X_loc,X_seq,Z_seq, RHO_STR_seq, EI1_seq,EI2_seq,GJ_seq, h_seq, b_seq)
            % X_loc 实际的分段
            % X_seq 插值序列
            obj.X_start = X_loc(1);
            obj.X_end = X_loc(end);
            obj.X_loc = X_loc;
            obj.X_seq = X_seq;
            obj.Z_seq = Z_seq;
            obj.RHO_STR_seq = RHO_STR_seq;
            obj.EI1_seq = EI1_seq;
            obj.EI2_seq = EI2_seq;
            obj.GJ_seq = GJ_seq;
            obj.h_seq = h_seq;
            obj.b_seq = b_seq;
        end
        %
        function [obj,fuse_block,FUSE_BLOCK_count,...
                grids,GRID_count,GRID_id,...
                mass, MASS_count, MASS_STR_id, MASS_NSTR_id,...
                pbar,PBAR_count,PBAR_id,cbar,CBAR_count,CBAR_id,...
                rbe2, RBE2_count]  =...%
                create_block(obj, fuse_block,FUSE_BLOCK_count,...
                grids,GRID_count,GRID_id, mat,...
                mass, MASS_count, MASS_STR_id, MASS_NSTR_id,...
                pbar,PBAR_count,PBAR_id,cbar,CBAR_count,CBAR_id,...
                rbe2, RBE2_count,...
                MASS_fuse_NSTR_mass, MASS_fuse_NSTR_loc)
            % fuse_block, FUSE_BLOCK_count
            % grids, GRID_count, GRID_id
            % pbar, PBAR_count, PBAR_id, cbar, CBAR_count
            % mass, MASS_count, MASS_STR_id, MASS_NSTR_id
            % rbe2, RBE2_count
            % MASS_fuse_NSTR_mass, MASS_fuse_NSTR_loc  
            for ii = 1:length(obj.X_loc)-1
                %% fuse_block
                FUSE_BLOCK_count = FUSE_BLOCK_count+1;
                fuse_block(FUSE_BLOCK_count) = FUSE_BLOCK();
                obj.blocks_num = [obj.blocks_num, FUSE_BLOCK_count];
                fuse_block(FUSE_BLOCK_count).mat_num = 1;
                %% create GRIDs
                GRID1_loc = [obj.X_loc(ii), 0, 0];
                GRID2_loc = [obj.X_loc(ii+1), 0, 0];
                GRID1_loc(3) = interp1(obj.X_seq, obj.Z_seq, GRID1_loc(1), 'linear');
                GRID2_loc(3) = interp1(obj.X_seq, obj.Z_seq, GRID2_loc(1), 'linear');
                GRID0_loc = 0.5*(GRID1_loc + GRID2_loc);
                %
                if ii==1
                    GRID_count = GRID_count+1;
                    GRID1_num = GRID_count;
                    GRID1_id = GRID_id + 2*(FUSE_BLOCK_count-1) +1;
                    grids(GRID_count) = GRID(GRID1_id, 'fuselage', GRID1_loc);
                    obj.GRIDs_num = [obj.GRIDs_num, GRID1_num];
                else
                    GRID1_num = fuse_block(FUSE_BLOCK_count-1).GRID2_num;
                    GRID1_id = fuse_block(FUSE_BLOCK_count-1).GRID2_id;
                end
                %
                GRID_count = GRID_count+1;
                GRID0_num = GRID_count;
                GRID0_id = GRID_id + 2*(FUSE_BLOCK_count-1) + 2;
                grids(GRID_count) = GRID(GRID0_id, 'fuselage', GRID0_loc);
                %
                GRID_count = GRID_count+1;
                GRID2_num = GRID_count;
                GRID2_id = GRID_id + 2*(FUSE_BLOCK_count-1) + 3;
                grids(GRID_count) = GRID(GRID2_id, 'fuselage', GRID2_loc);
                obj.GRIDs_num = [obj.GRIDs_num, GRID0_num, GRID2_num];
                %
                fuse_block(FUSE_BLOCK_count).GRID1_num = GRID1_num;
                fuse_block(FUSE_BLOCK_count).GRID0_num = GRID0_num;
                fuse_block(FUSE_BLOCK_count).GRID2_num = GRID2_num;
                fuse_block(FUSE_BLOCK_count).GRID1_id = GRID1_id;
                fuse_block(FUSE_BLOCK_count).GRID0_id = GRID0_id;
                fuse_block(FUSE_BLOCK_count).GRID2_id = GRID2_id;
                %% 属性插值
                RHO = interp1(obj.X_seq, obj.RHO_STR_seq, GRID0_loc(1), 'linear');
                EI1 = interp1(obj.X_seq, obj.EI1_seq, GRID0_loc(1), 'linear');
                EI2 = interp1(obj.X_seq, obj.EI2_seq, GRID0_loc(1), 'linear');
                GJ = interp1(obj.X_seq, obj.GJ_seq, GRID0_loc(1), 'linear');
%                 A = interp1(obj.X_seq, obj.A_seq, GRID0_loc(1), 'linear');
                h = interp1(obj.X_seq, obj.h_seq, GRID0_loc(1), 'linear');
                b = interp1(obj.X_seq, obj.b_seq, GRID0_loc(1), 'linear');
                %% block 属性
                fuse_block(FUSE_BLOCK_count).RHO = RHO;
                fuse_block(FUSE_BLOCK_count).EI1 = EI1;
                fuse_block(FUSE_BLOCK_count).EI2 = EI2;
                fuse_block(FUSE_BLOCK_count).GJ = GJ;
                fuse_block(FUSE_BLOCK_count).h = h;
                fuse_block(FUSE_BLOCK_count).b = b;
                %% build MASS_STR
                MASS_STR = RHO * (GRID2_loc(1)-GRID1_loc(1));
                MASS_count = MASS_count+1;
                MASS_STR_id = MASS_STR_id+1;
                mass(MASS_count) = MASS(MASS_STR_id, 'fuselage', GRID0_loc, GRID0_num, MASS_STR, zeros(1,6));
                fuse_block(FUSE_BLOCK_count).MASS_STR = MASS_STR;
                fuse_block(FUSE_BLOCK_count).MASS_STR_num = MASS_count;
                fuse_block(FUSE_BLOCK_count).MASS_STR_id = MASS_STR_id;
                %% build MASS_NSTR
                MASS_NSTR = [];
                MASS_NSTR_loc = [];
                for jj = 1:length(MASS_fuse_NSTR_mass)
                    if MASS_fuse_NSTR_loc(jj,1)<obj.X_start && ii==1
                        MASS_NSTR = [MASS_NSTR; MASS_fuse_NSTR_mass(jj)];
                        MASS_NSTR_loc = [MASS_NSTR_loc; MASS_fuse_NSTR_loc(jj,:)];
                    end
                    if MASS_fuse_NSTR_loc(jj,1)>=obj.X_end && ii==length(obj.X_loc)-1
                        MASS_NSTR = [MASS_NSTR; MASS_fuse_NSTR_mass(jj)];
                        MASS_NSTR_loc = [MASS_NSTR_loc; MASS_fuse_NSTR_loc(jj,:)];
                    end
                    if MASS_fuse_NSTR_loc(jj,1)>=GRID1_loc(1) && MASS_fuse_NSTR_loc(jj,1)<GRID2_loc(1)
                        MASS_NSTR = [MASS_NSTR; MASS_fuse_NSTR_mass(jj)];
                        MASS_NSTR_loc = [MASS_NSTR_loc; MASS_fuse_NSTR_loc(jj,:)];
                    end
                end
                GRID_NSTR_num = zeros(length(MASS_NSTR),1);
                GRID_NSTR_id_group = zeros(length(MASS_NSTR),1);
                MASS_NSTR_num = zeros(length(MASS_NSTR),1);
                MASS_NSTR_id_group = zeros(length(MASS_NSTR),1);
                for jj = 1:length(MASS_NSTR)
                    % grid
                    GRID_count = GRID_count+1;
                    GRID_NSTR_id = GRID0_id + jj*100;
                    GRID_NSTR_num(jj) =  GRID_count;
                    GRID_NSTR_id_group(jj) = GRID_NSTR_id;
                    grids(GRID_count) = GRID(GRID_NSTR_id, 'fuselage', MASS_NSTR_loc(jj,:));
                    %conm2
                    MASS_count = MASS_count+1;
                    MASS_NSTR_id = MASS_NSTR_id+1;
                    MASS_NSTR_num(jj) = MASS_count;
                    MASS_NSTR_id_group(jj) = MASS_NSTR_id;
                    mass(MASS_count) = MASS(MASS_NSTR_id, 'fuselage', MASS_NSTR_loc(jj,:), GRID_count, MASS_NSTR(jj), zeros(1,6));
                    %rbe2
                    RBE2_count = RBE2_count+1;
                    L0 = norm(grids(GRID_count).loc-grids(GRID0_num).loc);
                    L1 = norm(grids(GRID_count).loc-grids(GRID1_num).loc);
                    L2 = norm(grids(GRID_count).loc-grids(GRID2_num).loc);
                    if L0<=L1 && L0<=L2
                        rbe2(RBE2_count) = RBE2(RBE2_count, GRID0_id, GRID0_num, GRID_NSTR_id, GRID_count, 123456);
                    elseif L1<=L0 && L1<=L2
                        rbe2(RBE2_count) = RBE2(RBE2_count, GRID1_id, GRID1_num, GRID_NSTR_id, GRID_count, 123456);
                    elseif L2<=L0 && L2<=L1
                        rbe2(RBE2_count) = RBE2(RBE2_count, GRID2_id, GRID2_num, GRID_NSTR_id, GRID_count, 123456);
                    end
                end
                fuse_block(FUSE_BLOCK_count).MASS_NSTR = MASS_NSTR;
                fuse_block(FUSE_BLOCK_count).MASS_NSTR_loc = MASS_NSTR_loc;
                fuse_block(FUSE_BLOCK_count).GRID_NSTR_num = GRID_NSTR_num;
                fuse_block(FUSE_BLOCK_count).GRID_NSTR_id = GRID_NSTR_id_group;
                fuse_block(FUSE_BLOCK_count).MASS_NSTR_num = MASS_NSTR_num;
                fuse_block(FUSE_BLOCK_count).MASS_NSTR_id = MASS_NSTR_id_group;

                %% build bar
                PBAR_count = PBAR_count+1;
                pbar(PBAR_count) = PBAR(0, 0, 0, 0, 0, 0, 0,0, 'fuselage');
                PBAR_id = PBAR_id + 1;
                pbar(PBAR_count).id = PBAR_id;
                mat_num = fuse_block(FUSE_BLOCK_count).mat_num;
                pbar(PBAR_count).M_num = mat_num;
                pbar(PBAR_count).M_id = mat(mat_num).id;
                pbar(PBAR_count).A = 1;
                pbar(PBAR_count).Izz = EI1/mat(mat_num).E;
                pbar(PBAR_count).Iyy = EI2/mat(mat_num).E;
                pbar(PBAR_count).J = GJ/mat(mat_num).G;
                pbar(PBAR_count).h = h;
                pbar(PBAR_count).b = b;
                fuse_block(FUSE_BLOCK_count).PBAR_num = PBAR_count;
                fuse_block(FUSE_BLOCK_count).PBAR_id = PBAR_id;
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id + 1;
                cbar(CBAR_count).id = CBAR_id;
                cbar(CBAR_count).pid = PBAR_id;
                cbar(CBAR_count).p_num = PBAR_count;
                cbar(CBAR_count).region = 'fuselage';
                cbar(CBAR_count).V = [0,0,1];
                cbar(CBAR_count).GRID1_num = GRID1_num;
                cbar(CBAR_count).GRID2_num = GRID0_num;
                cbar(CBAR_count).GRID1_id = GRID1_id;
                cbar(CBAR_count).GRID2_id = GRID0_id;
                fuse_block(FUSE_BLOCK_count).CBAR1_num = CBAR_count;
                fuse_block(FUSE_BLOCK_count).CBAR1_id = CBAR_id;
                %
                CBAR_count = CBAR_count+1;
                CBAR_id = CBAR_id + 1;
                cbar(CBAR_count).id = CBAR_id;
                cbar(CBAR_count).pid = PBAR_id;
                cbar(CBAR_count).p_num = PBAR_count;
                cbar(CBAR_count).region = 'fuselage';
                cbar(CBAR_count).V = [0,0,1];
                cbar(CBAR_count).GRID1_num = GRID0_num;
                cbar(CBAR_count).GRID2_num = GRID2_num;
                cbar(CBAR_count).GRID1_id = GRID0_id;
                cbar(CBAR_count).GRID2_id = GRID2_id;
                fuse_block(FUSE_BLOCK_count).CBAR2_num = CBAR_count;
                fuse_block(FUSE_BLOCK_count).CBAR2_id = CBAR_id;
            end
        end
%         function [mass, mass_center] = total_mass(obj)
%             mass_NSTR = 0;
%             mass_NSTR_center = [0,0,0];
%             for ii = 1:length(obj.MASS_NSTR_num)
%                 mass_NSTR = mass_NSTR + obj.MASS_NSTR_mass(ii);
%                 mass_NSTR_center = mass_NSTR_center +...
%                     obj.MASS_NSTR_mass(ii)*obj.MASS_NSTR_loc(ii,:);
%             end
%             mass_NSTR_center = mass_NSTR_center/mass_NSTR;
%                 
    end
    
end

