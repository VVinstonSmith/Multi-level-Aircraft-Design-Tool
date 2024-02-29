function y = print_OMIT1(fid, C, GRIDS)
%删除一些结点的某个自由度
y = 0;
fprintf(fid,'OMIT1    ');
fprintf(fid,'%-7d ',C);

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
    
