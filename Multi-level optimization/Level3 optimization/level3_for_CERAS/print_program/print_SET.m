function y = print_LOAD(fid, SET_id, SET_name, GRIDS)
y = 0;

fprintf(fid,'$ %s\n', SET_name);
fprintf(fid,'SET1     ');
fprintf(fid,'%-7d ',SET_id);
row_num = 3;
for ii= 1:length(GRIDS)
	fprintf(fid,'%-7d ',GRIDS(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(GRIDS)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');


end
    
