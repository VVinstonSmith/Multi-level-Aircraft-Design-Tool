function y = print_DOPTPRM(fid, PARAM, VAL, ISDOT)
% �Ż����̿��Ʋ������� 
% 'IPRINT' : ����������(0�������2������������Ѱ�鷽��5�����������Ŀ�꺯������Ʊ�����ֵ)
% 'DESMAX' : ����������
% 'CONV2': ����׼��
% 'DELP' : ���ε������������ֵ
% 'P1': �������
% 'P2': �������

fprintf(fid,'$\n');
fprintf(fid,'DOPTPRM  ');
y = 0;
for ii = 1:length(PARAM)
    fprintf(fid,'%-7s ',PARAM{ii});
    if ISDOT(ii)==1
        print_form_number(fid,VAL(ii));
    else
        fprintf(fid,'%-7d ',VAL(ii));
    end
    if mod(ii,4)==0 && ii~=length(PARAM)
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
