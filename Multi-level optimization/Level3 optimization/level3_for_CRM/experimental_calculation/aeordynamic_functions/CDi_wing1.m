function Cd_i = CDi_wing1(CL,A)
% formula(06,1-22)
% �����յ�����ϵ��

% �Ҹ���0.33--0.5��������
delta = 0.318;

Cd_i = CL^2/(pi*A) * (1+delta);

end

