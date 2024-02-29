function P = drop_point(P1, P2, P0)

v1 = P0 - P1;
v2 = P2 - P1;
k = dot(v1,v2)/norm(P2-P1)/norm(P2-P1);
P = k*(P2-P1) + P1;

end

