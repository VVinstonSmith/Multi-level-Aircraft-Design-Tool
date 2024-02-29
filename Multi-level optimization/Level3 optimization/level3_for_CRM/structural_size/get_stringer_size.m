function [h, b, Izz, Iyy, J] = get_stringer_size(region, eta, n_str)

global A_str_total_wing
global A_str_total_htail

if strcmp(region, 'wing')
    A_str = A_str_total_wing;
elseif strcmp(region, 'htail')
    A_str = A_str_total_htail;
end

if eta < A_str(1,1)
    A = A_str(2,1);
elseif eta > A_str(1,end)
    A = A_str(2,end);
else
    A = interp1(A_str(1,:), A_str(2,:), eta, 'linear');
end

A = A / n_str;

b_over_h = 1;
%
h = sqrt(A/b_over_h);
b = h * b_over_h;
Izz = (b * h^3) / 12;
Iyy = (h * b^3) / 12;
J = (h * b^3) / 12;

end

