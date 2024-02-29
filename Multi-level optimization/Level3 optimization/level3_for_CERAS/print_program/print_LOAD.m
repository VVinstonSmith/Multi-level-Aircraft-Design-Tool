function y = print_LOAD(fid, SID, S, Si, Li)

n_force = length(Li);
y = n_force;

fprintf(fid,'LOAD     ');
fprintf(fid,'%-7d ',SID);
print_form_number(fid,S);


row_num = 2;
for ii= 1:n_force
    print_form_number(fid,Si(ii));
	fprintf(fid,'%-7d ',Li(ii));
    row_num = row_num + 1;
    if row_num==5
        if ii==n_force
            break;
        end
        row_num = 1;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');


end
    
