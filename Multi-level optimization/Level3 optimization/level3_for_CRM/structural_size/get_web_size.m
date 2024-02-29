function thick = get_web_size(region, position, eta)

global t_fweb_wing t_rweb_wing
global t_fweb_htail t_rweb_htail

if strcmp(region, 'wing')
    if strcmp(position, 'front')
        t_web = t_fweb_wing;
    elseif strcmp(position, 'rear')
        t_web = t_rweb_wing;
    end
elseif strcmp(region, 'htail')
    if strcmp(position, 'front')
        t_web = t_fweb_htail;
    elseif strcmp(position, 'rear')
        t_web = t_rweb_htail;
    end    
end

if eta < t_web(1,1)
    thick = t_web(2,1);
elseif eta > t_web(1,end)
    thick = t_web(2,end);
else
    thick = interp1(t_web(1,:), t_web(2,:), eta, 'linear');
end

end

