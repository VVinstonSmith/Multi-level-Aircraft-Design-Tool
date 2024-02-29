function [cbar_area,cbar, wing_box_grids, grids] = connect_cbar_area_hh(area1_num, area2_num, cbar_area, cbar, wing_box1, grids)

cbar1_num = cbar_area(area1_num).CBAR_num(1);
cbar2_num = cbar_area(area2_num).CBAR_num(1);
%
grids(cbar_area(area1_num).GRIDi_num(1)).region = 'empty';
wing_box_grids = delete_num(wing_box1.GRIDs_num, cbar_area(area1_num).GRIDi_num(1));
cbar_area(area1_num).GRIDi_num(1) = cbar_area(area2_num).GRIDi_num(1);
cbar(cbar1_num).GRID1_num = cbar(cbar2_num).GRID1_num;
cbar(cbar1_num).GRID1_id = cbar(cbar2_num).GRID1_id;

end

