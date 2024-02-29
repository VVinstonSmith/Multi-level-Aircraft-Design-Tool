function y = get_ka_any_c( k, Cr, Ct, B, ka_q )
% 已知根弦长Cr，梢弦长Ct，展长B，1/4弦后掠角ka，求相对弦长k的后掠角
% 0.25*Cr + 0.75*Ct + 0.5*B*tan(ka_q)
% = k*Cr + (1-k)*Ct + 0.5*B*tan(ka)

y = 0.25*Cr + 0.75*Ct + 0.5*B*tan(ka_q) - k*Cr - (1-k)*Ct;
y = y/(0.5*B);
y = atan(y);

end

