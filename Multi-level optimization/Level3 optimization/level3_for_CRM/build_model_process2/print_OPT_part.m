
%% print VAR
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DESVAR  ID      LABEL   XINIT   XLB     XUB     DELXV\n');
for ii=1:length(desvar)
    if use_opt_vars
        desvar(ii).XFIN = var_values(ii);
        desvar(ii).print_XFIN(fid);
    else
        desvar(ii).print_XINT(fid);
    end
end
fprintf(fid,'$\n');
%% print DEQATN
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DEQATN  EQID            EQUATION\n');
for ii=1:length(deqatn)
    deqatn(ii).print(fid);
end
fprintf(fid,'$\n');
%% print DVPREL1
if use_span_function==false
    fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
    fprintf(fid,'$DVPREL1 ID      TYPE    PID     FID     PMIN    PMAX    C0      XXXX    +DVPREL1\n');
    fprintf(fid,'$        DVID1   COEF1   DVID2   COEF2   DVID3   COEF3   ....\n');
    for ii=1:length(dvprel1)
        dvprel1(ii).print(fid);
    end
    fprintf(fid,'$\n');
end
%% print DVPREL2
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DVPREL2 ID      TYPE    PID     FID     PMIN    PMAX    EQID\n');
for ii=1:length(dvprel2)
    dvprel2(ii).print(fid);
end
fprintf(fid,'$\n');
%% print DISP(DRESP1,DRESP2,DCONSTR)
fprintf(fid,'$WEIGHT\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP1  ID      LABEL   RTYPE   PTYPE   REGION  ATTA    ATTB    ATT1\n');
for ii=1:length(dresp1)
    if strcmp(dresp1(ii).type, 'WEIGHT')
        dresp1(ii).print(fid);
    end
end
fprintf(fid,'$\n');
%% print DISP(DRESP1,DRESP2,DCONSTR)
fprintf(fid,'$DISP\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP1  ID      LABEL   RTYPE   PTYPE   REGION  ATTA    ATTB    ATT1\n');
for ii=1:length(dresp1)
    if strcmp(dresp1(ii).type, 'DISP')
        dresp1(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP2  ID      LABEL   EQID    REGION\n');
for ii=1:length(dresp2)
    if strcmp(dresp2(ii).type, 'DISP')
        dresp2(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONSTR DCID    RID     LALLOW  UALLOW\n');
for ii=1:length(dconstr)
    if strcmp(dconstr(ii).type, 'DISP')
        dconstr(ii).print(fid);
    end
end   
fprintf(fid,'$\n');
%% print STRESS(DRESP1,DRESP2,DCONSTR)
fprintf(fid,'$STRESS\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP1  ID      LABEL   RTYPE   PTYPE   REGION  ATTA    ATTB    ATT1\n');
for ii=1:length(dresp1)
    if strcmp(dresp1(ii).type, 'STRESS')
        dresp1(ii).print(fid);
    end
end
% fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
% fprintf(fid,'$DRESP2  ID      LABEL   EQID    REGION\n');
% for ii=1:length(dresp2)
%     if strcmp(dresp2(ii).type, 'STRESS')
%         dresp2(ii).print(fid);
%     end
% end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONSTR DCID    RID     LALLOW  UALLOW\n');
for ii=1:length(dconstr)
    if strcmp(dconstr(ii).type, 'STRESS')
        dconstr(ii).print(fid);
    end
end   
fprintf(fid,'$\n');  
%% print STABDER(DRESP1,DRESP2,DCONSTR)
fprintf(fid,'$STABDER\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP1  ID      LABEL   RTYPE   PTYPE   REGION  ATTA    ATTB    ATT1\n');
for ii=1:length(dresp1)
    if strcmp(dresp1(ii).type, 'STABDER')
        dresp1(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP2  ID      LABEL   EQID    REGION\n');
for ii=1:length(dresp2)
    if strcmp(dresp2(ii).type, 'STABDER')
        dresp2(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONSTR DCID    RID     LALLOW  UALLOW\n');
for ii=1:length(dconstr)
    if strcmp(dconstr(ii).type, 'STABDER')
        dconstr(ii).print(fid);
    end
end   
fprintf(fid,'$\n');
%% print FLUTTER(DRESP1,DRESP2,DCONSTR)
fprintf(fid,'$FLUTTER\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP1  ID      LABEL   RTYPE   PTYPE   REGION  ATTA    ATTB    ATT1\n');
for ii=1:length(dresp1)
    if strcmp(dresp1(ii).type, 'FLUTTER')
        dresp1(ii).print(fid);
    end
end
%
print_SET(fid, FLUTTER_mode_SET_id, 'FLUTTER_mode_SET', FLUTTER_mode_SET);
print_FLFACT(fid, [0,0,FLFACT_V_dresp_id], [], [], FLFACT_V_dresp);
%
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP2  ID      LABEL   EQID    REGION\n');
for ii=1:length(dresp2)
    if strcmp(dresp2(ii).type, 'FLUTTER')
        dresp2(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONSTR DCID    RID     LALLOW  UALLOW\n');
for ii=1:length(dconstr)
    if strcmp(dconstr(ii).type, 'FLUTTER')
        dconstr(ii).print(fid);
    end
end   
fprintf(fid,'$\n');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DRESP2  ID      LABEL   EQID    REGION\n');
for ii=1:length(dresp2)
    if strcmp(dresp2(ii).type, 'monotonic')
        dresp2(ii).print(fid);
    end
end
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONSTR DCID    RID     LALLOW  UALLOW\n');
for ii=1:length(dconstr)
    if strcmp(dconstr(ii).type, 'monotonic')
        dconstr(ii).print(fid);
    end
end   
fprintf(fid,'$\n');
%% print DCONADD  
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DCONADD DCID    DCi\n');
for ii=1:length(dconadd)
    dconadd(ii).print(fid);
end
fprintf(fid,'$\n');
%% print DOPTPRM
% DOPTPRM_PARAM = {
%     'DESMAX', 'P1', 'P2', 'DELB', 'APRCOD', 'CONV1', 'CONVDV', 'DELX', 'ADSCOD',...
%       'DELP', 'GMAX'};
% DOPTPRM_VAL = [
%           40,    1,   15,  1e-4,         1,   1e-4,     0.001,    0.1,        1,...
%          0.1,    5e-4,    1e-3, 0.003]; 
% DOPTPRM_ISDOT = [
%            0,    0,    0,     1,         0,      1,         1,      1,        0,...
%            1,     1];           
DOPTPRM_PARAM = {'DESMAX', 'P1', 'P2'};
DOPTPRM_VAL = [40, 1, 15];
DOPTPRM_ISDOT = [0, 0, 0];
print_DOPTPRM(fid, DOPTPRM_PARAM, DOPTPRM_VAL, DOPTPRM_ISDOT);
fprintf(fid,'$\n');
