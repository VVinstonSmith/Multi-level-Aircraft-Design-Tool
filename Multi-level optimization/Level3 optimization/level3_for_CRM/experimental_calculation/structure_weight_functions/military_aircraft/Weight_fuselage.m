function W_V = Weight_vtail(Ke, Kin, q_max, WTO, L_D)
% 机身重量估算
% formula(08, 2-43)

% Ke: (机身内双发:Ke=1.24, 机身内单发:Ke=1.0)
% Kin: (机身式进气道:Kin=1.25, 否则:Kin=1.0)
% q_max: 最大动压(N/m^2)
% WTO: 飞机正常起飞重量
% L_D: 机身长细比
W_F = 6.3995 * Ke * Kin^1.42 * (q_max/1000)^0.283;
W_F = W_F * (WTO/1000)^0.95 * L_D^0.71;

end

