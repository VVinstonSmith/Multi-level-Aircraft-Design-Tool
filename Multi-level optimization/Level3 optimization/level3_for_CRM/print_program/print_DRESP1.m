function y = print_DRESP1(fid, ID, LABEL, RTYPE, PTYPE, ATTA, ATTi)
% LABLE: 响应名称
% RTYPE: 响应属性类型，如DISP, STRESS, STABDER
% PTYPE: 属性卡类型，如 PBAR,PROD
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
if strcmp(RTYPE,'WEIGHT')==1
    fprintf(fid,'\n');
    return;
elseif strcmp(RTYPE,'DISP')==1
    fprintf(fid,'        ');
else
    fprintf(fid,'%-7s ',PTYPE);
end

fprintf(fid,'        ');
if isempty(ATTA)
    fprintf(fid,'%-7s ','-');
else
    if isa(ATTA, 'double')
        fprintf(fid,'%-7d ',ATTA);
    elseif  isa(ATTA, 'char')
        fprintf(fid,'%-7s ',ATTA);
    end
end
fprintf(fid,'        ');

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
    
