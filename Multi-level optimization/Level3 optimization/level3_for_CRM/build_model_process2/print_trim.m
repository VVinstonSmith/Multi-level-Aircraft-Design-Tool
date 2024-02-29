%% print Aero
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
% print_AEROS(fid, not_half, ACSID,RCSID,CREF,BREF,SREF)
print_AEROS(fid, 1, 0,0, C_A_wing, half_span_wing*2, S_wing);

%% AESTAT
AESTAT_ID = SURF_id+1 : SURF_id+5;
AESTAT_LABEL = {
    'ANGLEA';
    'URDD3';
    'URDD5';
    'ROLL';
    'YAW'};
print_AESTAT(fid, AESTAT_ID, AESTAT_LABEL);
AESTAT_ROLL_id = AESTAT_ID(4);

% print_TRIM(fid, ID, MACH, Q, LABEL, UX)
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
%% TRIM_1 1g
TRIM_1g_id = 1;
TRIM_LABEL_1 = {
    'URDD3'; 'URDD5'; 'ROLL'; 'YAW';...
    'AIL'};
UX_1 = [
    1; 0; 0; 0;...
    0];
V1 = Ma1 * speed_of_sound1;
Q1 = 0.5 * RHO_air1 * V1*V1;
print_TRIM(fid, TRIM_1g_id, Ma1, Q1, TRIM_LABEL_1, UX_1);
%% TRIM_2 2.5g
TRIM_25g_id = 2;
TRIM_LABEL_2 = {
    'URDD3'; 'URDD5'; 'ROLL'; 'YAW';...
    'AIL'};
UX_2 = [
    2.5; 0; 0; 0;...
    0];
V2 = Ma2 * speed_of_sound2;
Q2 = 0.5 * RHO_air2 * V2*V2;
print_TRIM(fid, TRIM_25g_id, Ma2, Q2, TRIM_LABEL_2, UX_2);
%% TRIM_3 roll
TRIM_roll_id = 3;
TRIM_LABEL_3 = {
    'ANGLEA'; 'URDD3'; 'URDD5'; 'YAW';...
    'AIL'; 'ELE'};
UX_3 = [
    0; 0; 0; 0;...
    10*pi/180; 0;];
print_TRIM(fid, TRIM_roll_id, Ma2, Q2, TRIM_LABEL_3, UX_3);


