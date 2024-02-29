function [DESVAR_count, DESVAR_id, desvar] = create_exp_var(comp_name, DESVAR_count, DESVAR_id, desvar, XINT, region, component)

a_LB = 0; a_UB = 10;
b_LB = -10; b_UB = 10;
c_LB = 0; c_UB = 10;

a_INT = 0.2*XINT;
b_INT = 1.5;
%b_INT = 0;
c_INT = 0.8*XINT;

DESVAR_count = DESVAR_count + 1;
DESVAR_id = DESVAR_id + 1;
desvar(DESVAR_count) = DESVAR(DESVAR_id, ['a',comp_name], a_INT, a_LB, a_UB, [],...
                    region, 0, component, 0);
DESVAR_count = DESVAR_count + 1;
DESVAR_id = DESVAR_id + 1;
desvar(DESVAR_count) = DESVAR(DESVAR_id, ['b',comp_name], b_INT, b_LB, b_UB, [],...
                    region, 0, component, 0);
DESVAR_count = DESVAR_count + 1;
DESVAR_id = DESVAR_id + 1;
desvar(DESVAR_count) = DESVAR(DESVAR_id, ['c',comp_name], c_INT, c_LB, c_UB, [],...
                    region, 0, component, 0);


end

