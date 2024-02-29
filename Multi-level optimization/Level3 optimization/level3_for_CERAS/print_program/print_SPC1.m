function y = print_SPC1(fid, SID, C, G)

y = 0;
fprintf(fid,'SPC1     ');
fprintf(fid,'%-7d ',SID);
fprintf(fid,'%-7d ',C);

G_num = length(G);

row_num = 4;
for ii= 1:G_num
	fprintf(fid,'%-7d ',G(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==G_num
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
