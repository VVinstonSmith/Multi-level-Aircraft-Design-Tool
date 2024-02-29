function CL_alpha_3d = CL_alpha_wing2(CL_alpha_2d, A, Ma, ka_half)
% formula(06, 6-12)

% CL_alpha_2d(平行于来流)
% A: 展弦比
% Ma
% ka_half: 1/2弦线后掠角

beta = sqrt(1-Ma^2);
K = CL_alpha_2d/(2*pi);

CL_alpha_3d = sqrt((A/K)^2 * (beta^2+tan(ka_half)^2) + 4);
CL_alpha_3d = 2 + CL_alpha_3d;
CL_alpha_3d = 2*pi*A / CL_alpha_3d; 

end

