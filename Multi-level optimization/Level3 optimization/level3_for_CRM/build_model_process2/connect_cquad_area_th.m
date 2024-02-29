function [cquad_area,cquad, wing_box_grids, grids] = connect_cquad_area_th(area1_num, area2_num, cquad_area, cquad, wing_box1, grids)

m = cquad_area(area1_num).m;
wing_box_grids = wing_box1.GRIDs_num;
for ii = 1:m+1
    grids(cquad_area(area1_num).GRIDij_num(ii,end)).region = 'empty';
    wing_box_grids = delete_num(wing_box_grids, cquad_area(area1_num).GRIDij_num(ii,end));
    cquad_area(area1_num).GRIDij_num(ii,end) = cquad_area(area2_num).GRIDij_num(ii,1);

end
for ii = 1:m
    cquad1_num = cquad_area(area1_num).CQUAD_num(ii,end);
    cquad2_num = cquad_area(area2_num).CQUAD_num(ii,1);
    cquad(cquad1_num).GRID2_num = cquad(cquad2_num).GRID1_num;
    cquad(cquad1_num).GRID3_num = cquad(cquad2_num).GRID4_num;
end

end

