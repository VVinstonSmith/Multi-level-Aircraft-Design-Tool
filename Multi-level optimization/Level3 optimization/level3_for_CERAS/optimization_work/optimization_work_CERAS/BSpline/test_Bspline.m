clear
close all
clc

x_cp = 0:0.25:1;
% x_cp = x_cp .* x_cp;
twist_cp = 1e-3*[1.50000, 1.50000, 8.91411, 9.00040, 6.94606];
twist_OAS = 1e-3*[1.50000, 1.61677, 1.94122, 2.43460, 3.05815, 3.77310, 4.54069, 5.32216, 6.07874, 6.77167, 7.36296, 7.83230, 8.17706, 8.39538, 8.48541, 8.44528, 8.27314, 7.96713, 7.52539, 6.94606];

twist_curve = BSpline([x_cp', twist_cp'],4);
us = linspace(0,1,20);
% Ns = zeros(21,1);
% for i = 1:length(us)
%     for j = 1:twist_curve.nCV
%         Ns(i,j) = twist_curve.basis(j,us(i));
%     end
% end
[xs,ys] = twist_curve.evaluate_batch(us);
figure(21);
plot(x_cp, twist_cp, 'o'); hold on;
plot(xs, twist_OAS, '*-'); hold on;
plot(xs,ys,'-*r'); hold on;


% Test sine wave

CVs =  [0         0
    0.2618    0.2588
    0.5236    0.5000
    0.7854    0.7071
    1.0472    0.8660
    1.3090    0.9659
    1.5708    1.0000];
figure(1);
plot(CVs(:,1),CVs(:,2), 'k-o');
hold on;
%%
sine_curve = BSpline(CVs,4);
us = linspace(0,1,100);
Ns = zeros(100,1);
for i = 1:length(us)
    for j = 1:sine_curve.nCV
        Ns(i,j) = sine_curve.basis(j,us(i));
    end
end
figure(2);
for i = 1:sine_curve.nCV
    plot(us,Ns(:,i), '*-');
    hold on
end
hold off
%%
[xs,ys] = sine_curve.evaluate_batch(us);
figure(1);
plot(xs,ys,'-ko');
% Test circle

CVs = [1    0
    1   1
    0   1
    -1  1
    -1  0
    -1  -1
    0   -1
    1   -1
    1   0];
knots = [0,0,0,pi/2,pi/2,pi,pi,3*pi/2,3*pi/2,2*pi,2*pi,2*pi];
weights = [1,sqrt(2)/2,1,sqrt(2)/2,1,sqrt(2)/2,1,sqrt(2)/2,1];
circle_curve = NURBS(CVs,3,0,2*pi);
circle_curve.set_knots(knots);
circle_curve.set_weights(weights);
us = linspace(0,2*pi,100);
[xs,ys] = circle_curve.evaluate_batch(us);
plot(xs,ys)
axis equal