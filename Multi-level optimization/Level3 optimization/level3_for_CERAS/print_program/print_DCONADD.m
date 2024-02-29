function y = print_DCONADD(fid, DCID, DC)

% DC: DCONSTRÊý¾Ý¿¨±àºÅ

y = 0;
fprintf(fid,'DCONADD  ');
fprintf(fid,'%-7d ',DCID);

row_num = 3;
for ii= 1:length(DC)
	fprintf(fid,'%-7d ',DC(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(DC)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
