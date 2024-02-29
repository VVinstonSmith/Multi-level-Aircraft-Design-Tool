function y = get_CL_delta_ail_2d(Cf_C, t_bar)
% formula(06, 6-49)
% 副翼单位偏转产生的二维翼型升力系数增量
%
% 忽略非线性修正因子K
% 认为Cl_alpha/Cl_alpha_the==1，所以Cl_delta/Cl_delta_the==1
%
Cl_delta_the = get_Cl_delta_the(Cf_C, t_bar);
y = Cl_delta_the;

end

