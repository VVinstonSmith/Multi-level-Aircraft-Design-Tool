function y = print_TRIM(fid, ID, MACH, Q, LABEL, UX)

fprintf(fid,'$ Trim Parameters for Subcase:%d\n',ID);

y=0;
fprintf(fid,'TRIM     ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7.2f ',MACH);
print_form_number(fid,Q);

fprintf(fid,'%-7s ',LABEL{1});
print_form_number(fid,UX(1));
fprintf(fid,'%-7s ',LABEL{2});
print_form_number(fid,UX(2));
fprintf(fid,'\n');
fprintf(fid,'         ');


row_num = 2;
for ii= 3:length(LABEL)
    fprintf(fid,'%-7s ',LABEL{ii});
    print_form_number(fid,UX(ii));
    row_num = row_num + 2;
    if row_num==10
        if ii==length(LABEL)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');


end

