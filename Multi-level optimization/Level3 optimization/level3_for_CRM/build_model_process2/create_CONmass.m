function [grids,GRID_count,GRID_id, mass,MASS_count,MASS_id, rbe2,RBE2_count] = create_CONmass(grids,GRID_count,GRID_id,mass,MASS_count,MASS_id,rbe2,RBE2_count, region,desc,MASS_mass,MASS_loc,GRID0_num)
%     grids, GRID_count, GRID_id,
%     mass, MASS_count, MASS_id, MASS_mass, MASS_loc
%     rbe2, RBE2_count  GRID0_num, GRID0_id,
    
    % grid
    GRID_count = GRID_count+1;
    GRID_id = GRID_id + 1;
    grids(GRID_count) = GRID(GRID_id, region, MASS_loc);
    %conm2
    MASS_count = MASS_count+1;
    MASS_id = MASS_id+1;
    mass(MASS_count) = MASS(MASS_id, region,desc, MASS_loc, GRID_count, MASS_mass, zeros(1,6));
    %rbe2
    RBE2_count = RBE2_count+1;
    rbe2(RBE2_count) = RBE2(RBE2_count, grids(GRID0_num).id, GRID0_num, GRID_id, GRID_count, 123456);

end

