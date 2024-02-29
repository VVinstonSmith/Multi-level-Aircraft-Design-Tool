function [Wsf, Wwe, Wri, Wot, W_W] = Weight_wing_sweep(n_mz, p, S_exp, b_exp, ka_half, lamda_exp, A_exp, H_exp)
% ���ڿ����ٺ����� Mig-15 Mig-19 F-86
% formula(08, 2-38)
% formula(08, 2-39)
% formula(08, 2-40)
% formula(08, 2-41)
% Wsf�����ӻ�����Ƥ+����+��Ե��������
% Wwe��������������
% Wri: ��������
% Wot: �����������ṹ����
% W_W: ����

% n_mz: ������
% p: ���غ�(kg/m^2)
% S_exp: ��¶�����(m^2)
% b_exp: ��¶չ��(m)
% ka_half: 1/2: ���ߺ��ӽ�
% lamda_exp: ��¶�����Ҹ���
% A_exp: ��¶��չ�ұ�
% H_exp: ��¶��������߶�(m)
Wsf = 0.51*1e-4 * n_mz * p * S_exp * (0.5*b_exp)^2;
Wsf = Wsf / cos(ka_half)^2;
Wsf = Wsf * (1 + 1/(1/lamda_exp+1)) / H_exp;
%
Wwe = 1.6*1e-4 * n_mz * p * S_exp * (0.5*b_exp);
Wwe = Wwe * (1 + 1/(1/lamda_exp+1)) / cos(ka_half);
%
Wri = 6.8*1e-4 * n_mz * p * S_exp *(0.5*b_exp);
Wri = Wri * cos(ka_half) / A_exp;
%
Wot = 9.973 * S_exp;
%
W_W = 1.1 * (Wsf+Wwe+Wri+Wot);

end

