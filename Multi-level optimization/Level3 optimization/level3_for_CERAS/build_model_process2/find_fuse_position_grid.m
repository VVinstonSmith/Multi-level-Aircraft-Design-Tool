function GRID_num = find_fuse_position_grid(fuse_block, grids, X)
    for ii = 1:length(fuse_block)
        X1 = grids(fuse_block(ii).GRID1_num).loc(1);
        X0 = grids(fuse_block(ii).GRID0_num).loc(1);
        X2 = grids(fuse_block(ii).GRID2_num).loc(1);
        if X>=X1 && X<X2
            L1 = abs(X-X1);
            L0 = abs(X-X0);
            L2 = abs(X-X2);
            if L0<=L1 && L0<=L2
                GRID_num = fuse_block(ii).GRID0_num;
            elseif L1<=L0 && L1<=L2
                GRID_num = fuse_block(ii).GRID1_num;
            elseif L2<=L0 && L2<=L1
                GRID_num = fuse_block(ii).GRID2_num;
            end
            return;
        end
    end
end
