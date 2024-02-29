function y = get_d_Cm0_d_tao(ka_q, A, lamda)
% 单位扭转角产生的零升力矩增量
% picture(06, 8-4)
ka_q_deg = ka_q * 180/pi;
% x1: ka_q_deg
% x2: A
x1_data = [0, 30, 60];
x2_data = [0, 1.5, 3.5, 6.0, 8.0, 10.0];

% lamda=0
y_data_1 = [
    0, 0, 0;
    0, -3.1*1e-4, -9.23*1e-4;
    0, -1.38*1e-3, -3.6*1e-3;
    0, -3.23*1e-3, -7.36*1e-3;
    0, -5*1e-3, -0.01099;
    0, -6.83*1e-3, -0.0145];
% lamda=0.5
y_data_2 = [
    0, 0, 0;
    0, -4.308*1e-4, -1.292*1e-3;
    0, -2.154*1e-3, -5.63*1e-3;
    0, -5.364*1e-3, -0.0127;
    0, -8.444*1e-3, -0.0191;
    0, -0.0117, -0.0258];
% lamda=1
y_data_3 = [
    0, 0, 0;
    0, -4.308*1e-4, -1.1875*1e-3;
    0, -2.08*1e-3, -5.63*1e-3;
    0, -5.333*1e-3, -0.0131;
    0, -8.444*1e-3, -0.0193;
    0, -0.012, -0.0264];
%
if A>10
    A1 = 10;
    A2 = A-A1;
    y1 = interp2(x1_data, x2_data, y_data_1, ka_q_deg, A1) +...
        interp2(x1_data, x2_data, y_data_1, ka_q_deg, A2);
    y2 = interp2(x1_data, x2_data, y_data_2, ka_q_deg, A1) +...
        interp2(x1_data, x2_data, y_data_2, ka_q_deg, A2);
    y3 = interp2(x1_data, x2_data, y_data_3, ka_q_deg, A1) +...
        interp2(x1_data, x2_data, y_data_3, ka_q_deg, A2);
else
    y1 = interp2(x1_data, x2_data, y_data_1, ka_q_deg, A);
    y2 = interp2(x1_data, x2_data, y_data_2, ka_q_deg, A);
    y3 = interp2(x1_data, x2_data, y_data_3, ka_q_deg, A);
end
if lamda>=0 && lamda<0.5
    y = y1*(0.5-lamda) + y2*(lamda-0);
    y = y/(0.5-0);
elseif lamda>=0.5 && lamda<=1
    y = y2*(1-lamda) + y3*(lamda-0.5);
    y = y/(1-0.5);
end


end

