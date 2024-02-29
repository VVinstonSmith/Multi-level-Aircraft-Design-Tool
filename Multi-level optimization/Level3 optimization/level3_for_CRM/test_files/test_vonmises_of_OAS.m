C_r = 13.606;
x1 = 50.1495;
x0 = 56.8842;
Iz = 0.194329; 
Iy = 1.39449;
J = 0.203193;
alpha = 0.762033867523995 * pi/180;
half_span = 29.38;

Fz = 9.80665 *  2.5 * 1e6 * cos(alpha);
Fy = 9.80665 *  2.5 * 1e6 * sin(alpha);

ka = 45 * pi/180;

L = half_span/cos(ka) - (x0-x1)*sin(ka);

Toq = Fz * (x0-x1) * cos(ka);
Mz = Fz * L;
My = Fy * half_span;

h_top = 0.678781;
h_front = 4.81 / 2;

sigma_z = Mz/Iz * h_top;
sigma_y = My/Iy * h_front;

A_enc = 5.91213;
t_skin = 0.02;
t_web = 0.01;
q_toq = Toq / (2*A_enc);
% q_M = 0.5 * Fz / 1.0618962397758074;
q_M =  1.008e+07

tao_fweb = (q_toq+q_M) / t_web;
tao_rweb = (-q_toq+q_M) / t_web;
tao_fspar = (q_toq+q_M) / t_skin;
tao_rspar = (-q_toq+q_M) / t_skin;

tao_f = max(abs(tao_fweb), abs(tao_fspar));
tao_r = max(abs(tao_rweb), abs(tao_rspar));

von_upperFront = sqrt(3*tao_f^2 + (sigma_z+sigma_y)^2)
von_lowerFront = sqrt(3*tao_f^2 + (-sigma_z+sigma_y)^2)
von_upperRear = sqrt(3*tao_r^2 + (sigma_z-sigma_y)^2)
von_lowerRear = sqrt(3*tao_r^2 + (-sigma_z-sigma_y)^2)





