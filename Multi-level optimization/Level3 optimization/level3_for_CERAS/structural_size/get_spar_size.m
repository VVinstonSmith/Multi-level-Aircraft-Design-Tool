function [h, b, Izz, Iyy, J] = get_spar_size(region, position, eta)

global A_fspar_wing A_rspar_wing
global A_fspar_htail A_rspar_htail 

if strcmp(region, 'wing')
    if strcmp(position, 'front')
        A_spar = A_fspar_wing;
    elseif strcmp(position, 'rear')
        A_spar = A_rspar_wing;
    end
elseif strcmp(region, 'htail')
    if strcmp(position, 'front')
        A_spar = A_fspar_htail;
    elseif strcmp(position, 'rear')
        A_spar = A_rspar_htail;
    end    
end

if eta < A_spar(1,1)
    A = A_spar(2,1);
elseif eta > A_spar(1,end)
    A = A_spar(2,end);
else
    A = interp1(A_spar(1,:), A_spar(2,:), eta, 'linear');
end
b_over_h = 4;
%
h = sqrt(A/b_over_h);
b = h * b_over_h;
Izz = (b * h^3) / 12;
Iyy = (h * b^3) / 12;
J = (h * b^3) / 12;

end

