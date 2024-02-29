function y = get_Kb(eta, lamda)
% picture(06, 6-64)
% 展长修正因子
%
% eta: 展向相对位置
x1_data = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9 1];
%
% lamda: 梢根比
x2_data = [0, 0.5, 1.0];
%
y_data = [
 0, 0.157712305025997, 0.303292894280763, 0.435008665511265, 0.556325823223570, 0.670710571923744, 0.776429809358752, 0.859618717504333, 0.928942807625650, 0.980935875216638, 0.998266897746967;
 0, 0.135181975736568, 0.265164644714038, 0.398613518197574, 0.516464471403813, 0.625649913344887, 0.731369150779896, 0.831889081455806, 0.915077989601387, 0.975736568457539, 0.998266897746967;
 0, 0.135181975736568, 0.247833622183709, 0.367417677642981, 0.487001733102253, 0.597920277296361, 0.707105719237435, 0.802426343154246, 0.883882149046794, 0.949740034662045, 0.998266897746967];
%
y = interp2(x1_data, x2_data, y_data, eta, lamda, 'linear');

end

