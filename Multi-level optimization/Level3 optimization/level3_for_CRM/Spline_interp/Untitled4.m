clear;
xys = [
    1, 1;
    1, 3;
    3, 1;
    3, 3];
xya = [
    2, 1;
    1, 2;
    2, 3;
    3, 2;
    2, 2];
[As, Aa, Aas] = spline2(xys, xya);