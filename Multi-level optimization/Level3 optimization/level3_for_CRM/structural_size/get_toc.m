function y = get_toc(region, eta)

global toc_wing
global toc_htail

if strcmp(region, 'wing')
    toc = toc_wing;
elseif strcmp(region, 'htail')
    toc = toc_htail; 
end

if eta < toc(1,1)
    y = toc(2,1);
elseif eta > toc(1,end)
    y = toc(2,end);
else
    y = interp1(toc(1,:), toc(2,:), eta, 'linear');
end

end

