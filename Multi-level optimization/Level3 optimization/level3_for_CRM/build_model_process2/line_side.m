function S = line_side( P1,P2,P )

S = (P1(1)-P(1)) * (P2(2)-P(2)) -...
    (P1(2)-P(2)) * (P2(1)-P(1));

end

