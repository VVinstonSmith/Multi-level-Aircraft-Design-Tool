clear;clc;close all;

% Rosen=@(x) 100*(x(1).^2-x(2)).^2+(1-x(1)).^2;
% range_l=[ -2.048 ; -2.048 ];
% range_r=[ 2.048 ; 2.048 ];

Ras=@(x) 70-(10+x(1)^2+x(2)^2-10*(cos(2*pi*x(1)+cos(2*pi*x(2)))));
range_l=[ -5 ; -5 ];
range_r=[ 5 ; 5 ];

% new_func=@(x) x+10*sin(5*x)+7*cos(4*x)+15;
% range_l=0;range_r=9;
% t=0:0.01:9;
% y=new_func(t);
% figure(5);
% plot(t,y);

NUMPOP=50;
LENGTH=32;
ITERATION=2000;
cross_rate=0.6;
sub_cross_rate=0.8;
variation_rate=0.01;

[pop, pop_result] = GA_method(...
    Ras, range_l, range_r,...
    NUMPOP, LENGTH, ITERATION,...
    cross_rate, sub_cross_rate, variation_rate);

