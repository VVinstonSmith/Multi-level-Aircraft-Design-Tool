function [DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr] = ...
          add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr,...
          index, component, DEQATN_id, Lallow, Uallow, type)

for ii=1:length(index)-1
    DRESP2_count = DRESP2_count + 1;
    DRESP_id = DRESP_id + 1;
    name = [component, num2str(ii), 'x', num2str(ii+1)];
    dresp2(DRESP2_count) = DRESP2(DRESP_id, name, DEQATN_id,...
        [index(ii),index(ii+1)], [], [], [], [], type);
    %
    DCONSTR_count = DCONSTR_count+1;
    DCONSTR_id = DCONSTR_id+1;
    dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, Lallow, Uallow, type, []);
end

