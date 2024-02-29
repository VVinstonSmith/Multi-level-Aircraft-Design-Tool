function y = print_MAT1(fid, MID, E, G, NU, RHO, ST, SC, SS)
% ST: ����Ӧ������
% SC: ѹ��Ӧ������
% SS: ����Ӧ������
y = 0;
fprintf(fid,'MAT1     ');
fprintf(fid,'%-7d ',MID);

print_form_number(fid,E);
print_form_number(fid,G);

fprintf(fid,'%-7.5f ',NU);
print_form_number(fid,RHO);

if ST~=0
    fprintf(fid,'\n');
    fprintf(fid,'         ');
    print_form_number(fid,ST);  
end
if SC~=0
    print_form_number(fid,SC);  
end
if SS~=0
    print_form_number(fid,SS);  
end

fprintf(fid,'\n');
end
