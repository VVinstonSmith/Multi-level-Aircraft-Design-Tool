function Cf = get_C_f(Ma, Re_c, type)
% picture(06, 7-3) 
% ��������Ħ��ϵ��(������-ʷ��ϣ͢��ʽ)

% type: T:���� L:����
if type=='T'
    Cf = 0.455 / (log10(Re_c)^2.58 * (1+0.144*Ma^2)^0.65);
elseif type=='L'
    Cf = 1.328 / sqrt(Re_c);
end
    
end

