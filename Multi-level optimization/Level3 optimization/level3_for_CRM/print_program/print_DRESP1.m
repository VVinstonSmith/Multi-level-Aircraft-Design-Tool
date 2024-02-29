function y = print_DRESP1(fid, ID, LABEL, RTYPE, PTYPE, ATTA, ATTi)
% LABLE: ��Ӧ����
% RTYPE: ��Ӧ�������ͣ���DISP, STRESS, STABDER
% PTYPE: ���Կ����ͣ��� PBAR,PROD
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
    
