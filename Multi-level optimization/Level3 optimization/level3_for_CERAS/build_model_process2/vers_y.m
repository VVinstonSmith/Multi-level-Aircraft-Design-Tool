function GRIDS_NEW = vers_y(GRIDS)
if size(GRIDS,2)==3
    GRIDS_NEW = [GRIDS(:,1), -GRIDS(:,2), GRIDS(:,3)];
else
    GRIDS_NEW = [GRIDS(:,1), -GRIDS(:,2)];
end

end

