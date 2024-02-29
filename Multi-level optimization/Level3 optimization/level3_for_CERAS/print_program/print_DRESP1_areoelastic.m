function y = print_DRESP1_areoelastic(fid, ID, LABEL, RTYPE, ATTA, ATTB, ATTi)
% LABLE: 响应名称
% RTYPE: 响应属性类型，如STABDER, TRIM, FLUTTER
% ATTA: 响应特性 
% ATTi: 属性ID

% STABDER: 静气动弹性稳定性导数
% ATTA: AESTAT卡 或 AESURF卡 的 ID
% ATTB: 0表示无约束，1表示有约束
% ATTi: 刚体自由度分量

% TRIM: 气动弹性配平变量响应
% ATTA: AESTAT卡 或 AESURF卡 的 ID
% ATTB: empty
% ATTi: empty

% FLUTTER: 气动弹性配平变量响应
% ATTA: empty
% ATTB: empty
% ATT1: 颤振模态SET1卡的ID
% ATT2: 密度比FLFACT卡的ID
% ATT3: 马赫数FLFACT卡的ID
% ATT4: 速度FLFACT卡的ID
y = 0;
fprintf(fid,'DRESP1   ');
fprintf(fid,'%-7d ',ID);
fprintf(fid,'%-7s ',LABEL);
fprintf(fid,'%-7s ',RTYPE);
fprintf(fid,'        ');
fprintf(fid,'        ');
   
if strcmp(RTYPE,'FLUTTER')==0
    fprintf(fid,'%-7d ',ATTA);
else
    fprintf(fid,'        ');
end

if strcmp(RTYPE,'TRIM')==1
    fprintf(fid,'\n');
    return;
end
   
if strcmp(RTYPE,'FLUTTER')==0
    fprintf(fid,'%-7d ',ATTB);
else
    fprintf(fid,'        ');
end

row_num = 9;
for ii= 1:length(ATTi)
	fprintf(fid,'%-7d ',ATTi(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(ATTi)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
