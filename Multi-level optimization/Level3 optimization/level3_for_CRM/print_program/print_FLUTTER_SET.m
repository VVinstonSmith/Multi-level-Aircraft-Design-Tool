function y = print_FLUTTER_SET(fid, ID, MODES)

% FLUTTER: 气动弹性配平变量响应
% ATTA: empty
% ATTB: empty
% ATT1: 颤振模态SET1卡的ID
% ATT2: 密度比FLFACT卡的ID
% ATT3: 马赫数FLFACT卡的ID
% ATT4: 速度FLFACT卡的ID


fprintf(fid,'$\n');
y = 0;
fprintf(fid,'SET1     ');
fprintf(fid,'%-7d ',ID);

row_num = 3;
for ii= 1:length(MODES)
	fprintf(fid,'%-7d ',MODES(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(MODES)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
