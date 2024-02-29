function S = S_triangle( A,B,C )

% 三边长
a = sqrt((A(1)-B(1))^2+(A(2)-B(2))^2+(A(3)-B(3))^2);
b = sqrt((C(1)-B(1))^2+(C(2)-B(2))^2+(C(3)-B(3))^2);
c = sqrt((A(1)-C(1))^2+(A(2)-C(2))^2+(A(3)-C(3))^2);

p = (a+b+c)/2;
% 三角形面积
S = sqrt(p*(p-a)*(p-b)*(p-c));

end

