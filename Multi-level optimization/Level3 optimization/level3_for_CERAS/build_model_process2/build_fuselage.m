%% PABR_f
PBAR_count = PBAR_count + 1;
PBAR_f_num = PBAR_count;
A =1.;
b_over_h = 1;
h = sqrt(A/b_over_h);
b = h * b_over_h;
Izz = (b * h^3) / 12;
Iyy = (h * b^3) / 12;
J = (h * b^3) / 12;
pbar(PBAR_count) = PBAR(PBAR_f_id, MAT_body_num, A, Izz, Iyy, J, h,b, 'fuselage');
%%
fuselage = FUSELAGE_RIG(Xf_seq,Zf_seq,PBAR_f_num,[0,0,1]);
%% block 
% [fuselage,rbar,RBAR_count,RBAR_f_id, grids,GRID_count,GRID_f_id] =...
%    fuselage.create_fuse_block(rbar,RBAR_count,RBAR_f_id, grids,GRID_count,GRID_f_id);
[fuselage, cbar,CBAR_count,CBAR_f_id, grids,GRID_count,GRID_f_id] =...
   fuselage.create_fuse_block(cbar,CBAR_count,CBAR_f_id, grids,GRID_count,GRID_f_id);
%% fuselage nstr_masses
if length(MASS_fuse_nstr_mass)>0
    [fuselage,grids,GRID_count,GRID_f_id, mass,MASS_count,MASS_f_id, rbe2,RBE2_count] =...
       fuselage.create_nstr_masses(grids,GRID_count,GRID_f_id, mass,MASS_count,MASS_f_id, rbe2,RBE2_count,...
       MASS_fuse_nstr_mass, MASS_fuse_nstr_loc, 'fuselage_device');
end

