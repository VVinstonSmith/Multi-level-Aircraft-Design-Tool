function y = get_Ki(Z_W, d_F)
% picture(06, 9-4)
% 翼身干扰因子Ki

% Z_W: 机身中心到外露翼根弦1/4弦点的距离，1/4弦点在中心以下为正
% d_F: 翼身连接处的最大机身高度
if Z_W<0
    y = -Z_W/(0.5*d_F) * (1.505-1)/0.6;
else
    y = Z_W/(0.5*d_F) * (1.4-1);
end
y = y+1;
end

