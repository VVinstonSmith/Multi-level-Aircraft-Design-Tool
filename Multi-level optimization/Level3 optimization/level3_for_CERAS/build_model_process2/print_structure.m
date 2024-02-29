

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% material
for ii = 1:length(mat)
    print_MAT1(fid, mat(ii).id, mat(ii).E, mat(ii).G, mat(ii).NU, mat(ii).RHO, 0, 0, 0);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% coordinate
for ii = 1:length(coord)
    print_CORD2R(fid, coord(ii).id, coord(ii).RID, coord(ii).A, coord(ii).B, coord(ii).C);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% grids
GRIDS_valid_num = 0;
for ii = 1:length(grids)
    if strcmp(grids(ii).region,'empty')==0
        GRIDS_valid_num = GRIDS_valid_num+1;
        print_GRID(fid, grids(ii).id, grids(ii).loc(1), grids(ii).loc(2), grids(ii).loc(3));
    end
end
GRIDS_valid_num

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% rbe2
for ii = 1:length(rbe2)
    print_RBE2(fid, rbe2(ii).id, rbe2(ii).GN_id, rbe2(ii).CM, rbe2(ii).GM_id);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% pbar
for ii = 1:length(pbar)
    pbar(ii).M_id = mat(pbar(ii).M_num).id;
    print_PBAR(fid, pbar(ii).id, pbar(ii).M_id,...
        pbar(ii).A, pbar(ii).Izz, pbar(ii).Iyy, pbar(ii).J, pbar(ii).h, pbar(ii).b);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% cbar
for ii = 1:length(cbar)
    cbar(ii).pid = pbar(cbar(ii).p_num).id;
    print_CBAR(fid, cbar(ii).id, cbar(ii).pid,...
        cbar(ii).GRID1_id, cbar(ii).GRID2_id, cbar(ii).V);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% rbar
% for ii = 1:length(rbar)
%     rbar(ii).CNA = 123456;
%     rbar(ii).GRID1_id = grids(rbar(ii).GRID1_num).id;
%     rbar(ii).GRID2_id = grids(rbar(ii).GRID2_num).id;
%     print_RBAR(fid, rbar(ii).id, rbar(ii).GRID1_id, rbar(ii).GRID2_id,...
%         rbar(ii).CNA, rbar(ii).CNB);
% end

%% pshell
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
for ii = 1:length(pshell)
    pshell(ii).MID1 = mat(pshell(ii).M_num).id;
    pshell(ii).MID2 = mat(pshell(ii).M_num).id;
    pshell(ii).MID3 = mat(pshell(ii).M_num).id;
    print_PSHELL(fid, pshell(ii).id, pshell(ii).MID1, pshell(ii).thick,...
        pshell(ii).MID2, pshell(ii).MID3, 0, hs_rate);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% cquad
for ii = 1:length(cquad)
    cquad(ii).pid = pshell(cquad(ii).p_num).id;
    id1 = grids(cquad(ii).GRID1_num).id;
    id2 = grids(cquad(ii).GRID2_num).id;
    id3 = grids(cquad(ii).GRID3_num).id;
    id4 = grids(cquad(ii).GRID4_num).id;
    print_CQUAD4(fid, cquad(ii).id, cquad(ii).pid,...
        id1, id2, id3, id4, 0, 0);
end

fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$CONM2   EID     G       CID     M       X1      X2      X3\n');
%% CONM
for ii = 1:length(mass)
    GRID_id = grids(mass(ii).GRID_num).id;
    print_CONM2(fid, mass(ii).id, GRID_id, 0, mass(ii).mass, [0,0,0], mass(ii).I);
end


