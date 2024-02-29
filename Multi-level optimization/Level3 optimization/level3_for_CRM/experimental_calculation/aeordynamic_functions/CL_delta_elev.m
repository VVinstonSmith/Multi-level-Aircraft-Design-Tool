function y = CL_delta_elev(CL_alpha_H, kq, S_H, S_e, S, ka_e)
% formual(06, 3-2)
% Éý½µ¶æÉýÁ¦²Ù×ÝÏµÊý


ne = sqrt(S_e/S_H) * cos(ka_e);
y = kq * CL_alpha_H * S_H/S * ne;

end

