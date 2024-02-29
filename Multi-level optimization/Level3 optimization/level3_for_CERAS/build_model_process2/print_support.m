%% 计算重心
mass_bar = 0;
mass_shell = 0;
mass_wing_str = 0;
mass_htail_str = 0;
mass_wing_nstr = 0;
mass_fuel = 0;
mass_htail_nstr = 0;
mass_body_nstr = 0;
%
cg_wing_str = [0,0,0];
cg_htail_str = [0,0,0];
cg_wing_nstr = [0,0,0];
cg_fuel = [0,0,0];
cg_htail_nstr = [0,0,0];
cg_body_nstr = [0,0,0];

%% 
for ii=1:length(cbar)
    [m, X] = cbar(ii).mass_center(grids,pbar,mat);
    mass_bar = mass_bar + m;
    if strcmp(cbar(ii).region,'wing')  
        mass_wing_str = mass_wing_str + m;
        cg_wing_str = cg_wing_str + m*X;
    elseif strcmp(cbar(ii).region,'htail')
        mass_htail_str = mass_htail_str + m;
        cg_htail_str = cg_htail_str + m*X;
    elseif strcmp(cbar(ii).region,'fuselage')
        continue;
    else
        disp('lose region card');
    end
end
for ii=1:length(cquad)
    [m, X] = cquad(ii).mass_center(grids,pshell,mat);
    mass_shell = mass_shell + m;
    if strcmp(cquad(ii).region,'wing')  
        mass_wing_str = mass_wing_str + m;
        cg_wing_str = cg_wing_str + m*X;
    elseif strcmp(cquad(ii).region,'htail')
        mass_htail_str = mass_htail_str + m;
        cg_htail_str = cg_htail_str + m*X;
    else
        disp('lose region card');
    end
end
for ii=1:length(mass)
    m = mass(ii).mass;
    X = mass(ii).loc;
    if strcmp(mass(ii).region,'wing')
        if strcmp(mass(ii).desc, 'fuel')
            mass_fuel = mass_fuel + m;
            cg_fuel = cg_fuel + m*X;
        elseif strcmp(mass(ii).desc, 'secondary')
            mass_wing_nstr = mass_wing_nstr + m;
            cg_wing_nstr = cg_wing_nstr + m*X;
        else
            disp('description lost');
        end
    elseif strcmp(mass(ii).region,'htail')
        mass_htail_nstr = mass_htail_nstr + m;
        cg_htail_nstr = cg_htail_nstr + m*X;
    elseif strcmp(mass(ii).region,'fuselage')
        mass_body_nstr = mass_body_nstr + m;
        cg_body_nstr = cg_body_nstr + m*X;
    else
        disp('lose region card');
    end
end
mass_wing_str, mass_htail_str, mass_fuel
mass_wing_nstr, mass_htail_nstr, mass_body_nstr

mass_total = mass_wing_str + mass_htail_str + mass_fuel +...
             mass_wing_nstr + mass_htail_nstr + mass_body_nstr;
cg_total = cg_wing_str + cg_htail_str + cg_fuel +...
           cg_wing_nstr + cg_htail_nstr + cg_body_nstr;
cg_total = cg_total / mass_total;
cg_wing_str = cg_wing_str / mass_wing_str;
cg_fuel = cg_fuel / mass_fuel;
cg_wing_nstr = cg_wing_nstr / mass_wing_nstr;
cg_body_nstr = cg_body_nstr / mass_body_nstr;
    
%% 离质心最近点的点
Node_num= 0;
Node_loc = [0,0,0];
for ii = 1:length(fuselage.GRIDs_num)
    new_loc = grids(fuselage.GRIDs_num(ii)).loc;
    if norm(new_loc - cg_total) < norm(Node_loc - cg_total)
        Node_num = fuselage.GRIDs_num(ii);
        Node_loc = new_loc;
    end
end
mass_grid_id = grids(Node_num).id;

%%
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$\n');
% print_PARAM(fid, GRDPNT, WTMASS, AUNITS, SUPORT, LMODES, OPTEXIT)
print_PARAM(fid, mass_grid_id, 1/9.8, 0, [], OPTEXIT);
% print_SPC1(fid, SID, C, G)
% print_SPCADD(fid, SID, S)
% print_SUPORT1(fid, id, GRDPNT, SUPORT)
fprintf(fid,'$纵向配平约束\n');
print_SUPORT1(fid, 1, mass_grid_id, 35);
print_SPCADD(fid, SPC_long_id, 100);
print_SPC1(fid, 100, 1246, mass_grid_id);
fprintf(fid,'$\n');
fprintf(fid,'$横向配平约束\n');
print_SUPORT1(fid, 2, mass_grid_id, 4);
print_SPCADD(fid, SPC_lat_id, 200);
print_SPC1(fid, 200, 12356, mass_grid_id);
fprintf(fid,'$\n');
fprintf(fid,'$颤振约束\n');
print_SPCADD(fid, SPC_elas_id, 300);
print_SPC1(fid, 300, 123456, mass_grid_id);
fprintf(fid,'$\n');

