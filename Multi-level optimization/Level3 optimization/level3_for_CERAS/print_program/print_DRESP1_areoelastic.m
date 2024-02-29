function y = print_DRESP1_areoelastic(fid, ID, LABEL, RTYPE, ATTA, ATTB, ATTi)
% LABLE: ��Ӧ����
% RTYPE: ��Ӧ�������ͣ���STABDER, TRIM, FLUTTER
% ATTA: ��Ӧ���� 
% ATTi: ����ID

% STABDER: �����������ȶ��Ե���
% ATTA: AESTAT�� �� AESURF�� �� ID
% ATTB: 0��ʾ��Լ����1��ʾ��Լ��
% ATTi: �������ɶȷ���

% TRIM: ����������ƽ������Ӧ
% ATTA: AESTAT�� �� AESURF�� �� ID
% ATTB: empty
% ATTi: empty

% FLUTTER: ����������ƽ������Ӧ
% ATTA: empty
% ATTB: empty
% ATT1: ����ģ̬SET1����ID
% ATT2: �ܶȱ�FLFACT����ID
% ATT3: �����FLFACT����ID
% ATT4: �ٶ�FLFACT����ID
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
    
