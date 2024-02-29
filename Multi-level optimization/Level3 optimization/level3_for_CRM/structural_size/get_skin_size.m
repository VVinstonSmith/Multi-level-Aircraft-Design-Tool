function thick = get_skin_size(region, eta)

global t_skin_wing
global t_skin_htail

if strcmp(region, 'wing')
    t_skin = t_skin_wing;
elseif strcmp(region, 'htail')
    t_skin = t_skin_htail; 
end

if eta < t_skin(1,1)
    thick = t_skin(2,1);
elseif eta > t_skin(1,end)
    thick = t_skin(2,end);
else
    thick = interp1(t_skin(1,:), t_skin(2,:), eta, 'linear');
end

end

