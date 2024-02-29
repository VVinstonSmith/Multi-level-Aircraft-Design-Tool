%% 响应约束值
% 1g工况变形范围
TWIST_LOW_1g = -MAX_TWIST_DEG_1g * pi/180;
TWIST_UP_1g = MAX_TWIST_DEG_1g * pi/180;
ZDISP_LOW_1g = -MAX_DISP_RATIO_1g * half_span_wing;
ZDISP_UP_1g = MAX_DISP_RATIO_1g * half_span_wing;
% 2.5g工况变形范围
TWIST_LOW_25g = -MAX_TWIST_DEG_25g * pi/180;
TWIST_UP_25g = MAX_TWIST_DEG_25g * pi/180;
ZDISP_LOW_25g = -MAX_DISP_RATIO_25g * half_span_wing;
ZDISP_UP_25g = MAX_DISP_RATIO_25g * half_span_wing;
% 2.5g工况应力范围
STRESS_PBAR_LOW_25g = -yield;
STRESS_PBAR_UP_25g = yield;
STRESS_PSHELL_LOW_25g = -yield;
STRESS_PSHELL_UP_25g = yield;
% 滚转效率
% ROLLEFF_LOW = 0.2; 
% 颤振阻尼
DAMP_LOW = -1e+9;
DAMP_UP = -0.3;
%% 弯曲挠度 和 扭转角 响应与约束
% DRESP2(弯曲挠度) 和 DRESP2(扭转角) 在 build_wing_box.m已经定义
%% 1g工况约束
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_RWTWIST_id, TWIST_LOW_1g, TWIST_UP_1g, 'DISP', '1g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_LWTWIST_id, TWIST_LOW_1g, TWIST_UP_1g, 'DISP', '1g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_RWZDISP_id, ZDISP_LOW_1g, ZDISP_UP_1g, 'DISP', '1g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_LWZDISP_id, ZDISP_LOW_1g, ZDISP_UP_1g, 'DISP', '1g');
%% 2.5g工况约束
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_RWTWIST_id, TWIST_LOW_25g, TWIST_UP_25g, 'DISP', '2.5g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_LWTWIST_id, TWIST_LOW_25g, TWIST_UP_25g, 'DISP', '2.5g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_RWZDISP_id, ZDISP_LOW_25g, ZDISP_UP_25g, 'DISP', '2.5g');
%
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP2_LWZDISP_id, ZDISP_LOW_25g, ZDISP_UP_25g, 'DISP', '2.5g');
%% 重量响应
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_WEIGHT_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'WEIGHT', 'WEIGHT', [], [], [], 'WEIGHT');

%% 滚转效率响应与约束
% LABLE: 响应名称
% RTYPE: 响应属性类型，如STABDER, TRIM, FLUTTER
% ATTA: 响应特性 
% ATTi: 属性ID
% CLDELTA
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_CLDELTA_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'CLDELTA', 'STABDER', [], AESURF_aileron_id, 4, 'STABDER');
% CLP
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_CLP_id = DRESP_id;
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'CLP', 'STABDER', [], AESTAT_ROLL_id, 4, 'STABDER');
% DEQATN_ROLLEFF
DEQATN_count = DEQATN_count+1;
DEQATN_id = DEQATN_id+1;
DEQATN_ROLLEFF1_id = DEQATN_id;
EQATN = 'F(A,B) = -B/A';
deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
%
DEQATN_count = DEQATN_count+1;
DEQATN_id = DEQATN_id+1;
DEQATN_ROLLEFF2_id = DEQATN_id;
EQATN = ['F(B) = -B/', num2str(C_roll_stiff)];
deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
% ROLLEFF
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
% dresp2(DRESP2_count) = DRESP2(DRESP_id, 'ROLLEFF', DEQATN_ROLLEFF_id,...
%     [], [], [DRESP1_CLP_id, DRESP1_CLDELTA_id], [], [], 'STABDER');
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'ROLLEFF', DEQATN_ROLLEFF2_id,...
    [], [], [DRESP1_CLDELTA_id], [], [], 'STABDER');
% constrain
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, ROLLEFF_LOW, [], 'STABDER', 'roll');
%% 颤振响应与约束
% FLUTTER: 气动弹性配平变量响应
% ATTA: empty
% ATTB: empty
% ATT1: 颤振模态SET1卡的ID
% ATT2: 密度比FLFACT卡的ID
% ATT3: 马赫数FLFACT卡的ID
% ATT4: 速度FLFACT卡的ID
DRESP1_count = DRESP1_count+1;
DRESP_id = DRESP_id+1;
DRESP1_FLUTTER_id = DRESP_id;
FLUTTER_mode_SET = 1:10;
% 用于计算响应的速度集合
FLFACT_V_dresp = FLFACT_V(end-2:end);
ATTi = [FLUTTER_mode_SET_id, FLFACT_rho_id, FLFACT_Ma_id, FLFACT_V_dresp_id];
dresp1(DRESP1_count) = DRESP1(DRESP_id, 'FLUTTER', 'FLUTTER', [], [], ATTi, 'FLUTTER');
%
DEQATN_count = DEQATN_count+1;
DEQATN_id = DEQATN_id+1;
DEQATN_FLUTTER_id = DEQATN_id;
EQATN = 'F(A) = (A-0.03)/0.1';
deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
%
DRESP2_count = DRESP2_count+1;
DRESP_id = DRESP_id+1;
dresp2(DRESP2_count) = DRESP2(DRESP_id, 'GDAMP', DEQATN_FLUTTER_id,...
    [], [], DRESP1_FLUTTER_id, [], [], 'FLUTTER');
% DAMP constrain
DCONSTR_count = DCONSTR_count+1;
DCONSTR_id = DCONSTR_id+1;
dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, DAMP_LOW, DAMP_UP, 'FLUTTER', 'flutter');
%% 机翼杆板结构的应力响应
for ii = 1:length(pbar)
    if strcmp(pbar(ii).region,'wing')
        % 响应
        DRESP1_count = DRESP1_count+1;
        DRESP_id = DRESP_id+1;
        ATTA = 6;% axial_stress
        dresp1(DRESP1_count) = DRESP1(DRESP_id, ['S',num2str(DRESP_id)],...
            'STRESS', 'PBAR', ATTA, pbar(ii).id, 'STRESS');
        % 1g工况约束
        %DCONSTR_count = DCONSTR_count+1;
        %DCONSTR_id = DCONSTR_id+1;
        %dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, STRESS_PBAR_LOW_1g, STRESS_PBAR_UP_1g, 'STRESS', '1g');
        % 2.5g工况约束
        DCONSTR_count = DCONSTR_count+1;
        DCONSTR_id = DCONSTR_id+1;
        dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, STRESS_PBAR_LOW_25g, STRESS_PBAR_UP_25g, 'STRESS', '2.5g');
    end
end
for ii = 1:length(pshell)
    if strcmp(pshell(ii).region,'wing')
        DRESP1_count = DRESP1_count+1;
        DRESP_id = DRESP_id+1;
        ATTA = 9;% all_stress
        dresp1(DRESP1_count) = DRESP1(DRESP_id, ['S',num2str(DRESP_id)],...
            'STRESS', 'PSHELL', ATTA, pshell(ii).id, 'STRESS');
        % 1g工况约束
        %DCONSTR_count = DCONSTR_count+1;
        %DCONSTR_id = DCONSTR_id+1;
        %dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, STRESS_PSHELL_LOW_1g, STRESS_PSHELL_UP_1g, 'STRESS', '1g');
        % 2.5g工况约束
        DCONSTR_count = DCONSTR_count+1;
        DCONSTR_id = DCONSTR_id+1;
        dconstr(DCONSTR_count) = DCONSTR(DCONSTR_id, DRESP_id, STRESS_PSHELL_LOW_25g, STRESS_PSHELL_UP_25g, 'STRESS', '2.5g');
    end
end
%% DCONADD
DCONADD_num = 0;
%
DCONADD_num = DCONADD_num + 1;
DCONADD_1g_num = DCONADD_num;
dconadd(DCONADD_1g_num) = DCONADD(DCONADD_1g_id, [], '1g');
%
DCONADD_num = DCONADD_num + 1;
DCONADD_25g_num = DCONADD_num;
dconadd(DCONADD_25g_num) = DCONADD(DCONADD_25g_id, [], '2.5g');
%
DCONADD_num = DCONADD_num + 1;
DCONADD_roll_num = DCONADD_num;
dconadd(DCONADD_roll_num) = DCONADD(DCONADD_roll_id, [], 'roll');
%
DCONADD_num = DCONADD_num + 1;
DCONADD_flutter_num = DCONADD_num;
dconadd(DCONADD_flutter_num) = DCONADD(DCONADD_flutter_id, [], 'flutter');
%
for ii = 1:length(dconstr)
    if strcmp(dconstr(ii).condition, '1g')
        if strcmp(dconstr(ii).type,'DISP')
            if contrain_disp
                dconadd(DCONADD_1g_num).DC(end+1) = dconstr(ii).id;
            end
        else
            dconadd(DCONADD_1g_num).DC(end+1) = dconstr(ii).id;
        end
    elseif strcmp(dconstr(ii).condition, '2.5g')
        if strcmp(dconstr(ii).type,'DISP')
            if contrain_disp
                 dconadd(DCONADD_25g_num).DC(end+1) = dconstr(ii).id;
            end
        else
            dconadd(DCONADD_25g_num).DC(end+1) = dconstr(ii).id;
        end
    elseif strcmp(dconstr(ii).condition, 'roll')
        dconadd(DCONADD_roll_num).DC(end+1) = dconstr(ii).id;
    elseif strcmp(dconstr(ii).condition, 'flutter')
        dconadd(DCONADD_flutter_num).DC(end+1) = dconstr(ii).id;
    end
end

if thick_monotonic
    DEQATN_count = DEQATN_count+1;
    DEQATN_id = DEQATN_id+1;
    DEQATN_LminusR_id = DEQATN_id;
    EQATN = 'LminusR(L,R)=L-R';
    deqatn(DEQATN_count) = DEQATN(DEQATN_id, EQATN);
    %fspar, rspar, str, fweb, rweb, skin
    w_num = length(wing_box_w) / 2;
    index_fweb=zeros(1,w_num);
    index_rweb=zeros(1,w_num);
    index_skin=zeros(1,w_num);
    i_fweb=1; i_rweb=1; i_skin=1;
    if var_mode==5 || var_mode==6
        index_fspar=zeros(1,w_num);
        index_rspar=zeros(1,w_num);
        i_fspar=1; i_rspar=1;
    end
    if var_mode==6
        index_str=zeros(1,w_num);
        i_str=1;
    end
    for ii=1:length(desvar)
        if strcmp(desvar(ii).component,'fweb')
            index_fweb(i_fweb) = ii; i_fweb=i_fweb+1;
        elseif strcmp(desvar(ii).component,'rweb')
            index_rweb(i_rweb) = ii; i_rweb=i_rweb+1;
        elseif strcmp(desvar(ii).component,'skin')
            index_skin(i_skin) = ii; i_skin=i_skin+1;
        elseif strcmp(desvar(ii).component,'fspar')
            index_fspar(i_fspar) = ii; i_fspar=i_fspar+1;
        elseif strcmp(desvar(ii).component,'rspar')
            index_rspar(i_rspar) = ii; i_rspar=i_rspar+1;
        elseif strcmp(desvar(ii).component,'str')
            index_str(i_str) = ii; i_str=i_str+1;
        else
            disp('error');
        end
    end
    Lallow = [];
    Uallow = 0;
    DCONSTR_mono_start_id = DCONSTR_id+1;
    [DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr] = ...
      add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr,...
      index_fweb, 'fw', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
    [DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr] = ...
      add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr,...
      index_rweb, 'rw', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
    [DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr] = ...
      add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
      DCONSTR_count, DCONSTR_id, dconstr,...
      index_skin, 'sk', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
    if var_mode==5 || var_mode==6
        [DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr] = ...
          add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr,...
          index_fspar, 'fb', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
        [DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr] = ...
          add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr,...
          index_rspar, 'rb', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
    end
    if var_mode==6
        [DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr] = ...
          add_monotonic_constr(DRESP2_count, DRESP_id, dresp2,...
          DCONSTR_count, DCONSTR_id, dconstr,...
          index_str, 'st', DEQATN_LminusR_id, Lallow, Uallow,'monotonic');
    end
    DCONADD_monotonic_num = 5;
    dconadd(DCONADD_monotonic_num) = DCONADD(DCONADD_monotonic_id, [], 'overall');
    dconadd(DCONADD_monotonic_num).DC = DCONSTR_mono_start_id : DCONSTR_id;                        
end


