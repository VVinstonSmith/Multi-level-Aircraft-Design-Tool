function [h, b, Izz, Iyy, J] = get_I(A, b_over_h)
%
h = sqrt(A/b_over_h);
b = h * b_over_h;
Izz = (b * h^3) / 12;
Iyy = (h * b^3) / 12;
J = (h * b^3) / 12;

end

