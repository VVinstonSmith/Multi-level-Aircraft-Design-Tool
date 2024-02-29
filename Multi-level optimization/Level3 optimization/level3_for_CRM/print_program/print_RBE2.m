function y = print_RBE2(fid, EID, GN, CM, GM)

% GN:独立结点
% GM:非独立结点

y = 0;

fprintf(fid,'RBE2     ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',GN);
fprintf(fid,'%-7d ',CM);


row_num = 5;
for ii= 1:length(GM)
	fprintf(fid,'%-7d ',GM(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(GM)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end

