function [As, Aa, Aas] = spline2(xys, xya)

ns = size(xys,1);
na = size(xya,1);

r0 = 3;
As = zeros(ns+r0, ns+r0);
for ii=1:ns
    As(r0+ii,1) = 1;
    As(r0+ii,2) = xys(ii,1);
    As(r0+ii,3) = xys(ii,2);
    for jj=1:ns
        rij2 = sum((xys(ii,:)-xys(jj,:)).^2);
        if rij2<1e-8
            As(r0+ii,r0+jj) = 0;
        else
            As(r0+ii,r0+jj) = rij2 * log(rij2);
        end
    end
end
As(1:r0,r0+1:end) = As(r0+1:end,1:r0)';
As_inv  = inv(As);

Aa = zeros(na, r0+ns);
for ii=1:na
    Aa(ii,1) = 1;
    Aa(ii,2) = xya(ii,1);
    Aa(ii,3) = xya(ii,2);
    for jj=1:ns
        rij2 = sum((xya(ii,:)-xys(jj,:)).^2);
        if rij2<1e-8
            Aa(ii,r0+jj) = 0;
        else
            Aa(ii,r0+jj) = rij2*log(rij2);
        end
    end
end
Aas = Aa * As_inv(:,r0+1:end);


end

