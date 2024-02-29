function Mcr = get_Mcr_airfoil(airfoil_type, CL, t_bar)
% formula(06, 8-9)
% �����ٽ����������
if strcmp(airfoil_type, 'NACA')
    Mcr = 0.86 - 0.1*CL - t_bar;
else% ���ٽ�����
    Mcr = 0.91 - 0.1*CL - t_bar;
end

end

