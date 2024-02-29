function alpha0_deg = get_alpha0_NACA(num, alpha_des, CL_des)
% formula(06, 6-4)
% NACA��������ӭ�ǹ���

% num: λ��
% CL_des: �������ϵ��
% alpha_des: ���ӭ��
if num==4
    K=0.93;
elseif num==5
    K=1.08;
elseif num==6
    K=0.74;
end

alpha0_deg = K*(alpha_des - 57.3/(2*pi)*CL_des);

end

