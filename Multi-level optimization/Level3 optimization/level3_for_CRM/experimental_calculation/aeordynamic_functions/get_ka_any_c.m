function y = get_ka_any_c( k, Cr, Ct, B, ka_q )
% ��֪���ҳ�Cr�����ҳ�Ct��չ��B��1/4�Һ��ӽ�ka��������ҳ�k�ĺ��ӽ�
% 0.25*Cr + 0.75*Ct + 0.5*B*tan(ka_q)
% = k*Cr + (1-k)*Ct + 0.5*B*tan(ka)

y = 0.25*Cr + 0.75*Ct + 0.5*B*tan(ka_q) - k*Cr - (1-k)*Ct;
y = y/(0.5*B);
y = atan(y);

end

