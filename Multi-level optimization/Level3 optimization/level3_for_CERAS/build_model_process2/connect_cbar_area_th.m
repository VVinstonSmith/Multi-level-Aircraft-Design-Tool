function [cbar_area,cbar, wing_box_grids, grids] = connect_cbar_area_th(area1_num, area2_num, cbar_area, cbar, wing_box1, grids)

wing_box_grids = delete_num(wing_box1.GRIDs_num, cbar_area(area1_num).GRIDi_num(end));

cbar1_num = cbar_area(area1_num).CBAR_num(end);
cbar2_num = cbar_area(area2_num).CBAR_num(1);
%
grids(cbar_area(area1_num).GRIDi_num(end)).region = 'empty';
cbar_area(area1_num).GRIDi_num(end) = cbar_area(area2_num).GRIDi_num(1);
cbar(cbar1_num).GRID2_num = cbar(cbar2_num).GRID1_num;
cbar(cbar1_num).GRID2_id = cbar(cbar2_num).GRID1_id;
end

