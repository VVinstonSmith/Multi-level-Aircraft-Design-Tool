function y = print_FLUTTER_SET(fid, ID, MODES)

% FLUTTER: ����������ƽ������Ӧ
% ATTA: empty
% ATTB: empty
% ATT1: ����ģ̬SET1����ID
% ATT2: �ܶȱ�FLFACT����ID
% ATT3: �����FLFACT����ID
% ATT4: �ٶ�FLFACT����ID


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
    
