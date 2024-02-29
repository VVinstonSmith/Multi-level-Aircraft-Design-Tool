%% 创建分析算例(sol101)
fid=fopen('SOL101.bdf','wt');
print_CASE(fid, 101, 0, 'STATIC ANALYSIS', 'NONE');
print_SUBCASE_STATICS(fid, 1, 'airloads_form_AS1', 'STATICS', 0, LOAD_id, SPC_elas_id, 'ALL', 'NONE', 'ALL');
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''static_loads.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);

%% 创建分析算例(sol144)
fid=fopen('SOL144a.bdf','wt');
print_CASE(fid, 144, 0, '1g Longitude', 'NONE');
% print_SUBCASE_AERO_STATIC(fid, ID, LABEL, ANALYSIS, DESSUB, TRIM, SPC, SUPORT)
print_SUBCASE_AERO_STATIC(fid, 1, '1g Longitude', 'SAERO', 0, 1, SPC_long_id, 1, 'ALL', 'NONE', 'ALL');
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);
%
fid=fopen('SOL144b.bdf','wt');
print_CASE(fid, 144, 0, '2.5g Longitude', 'NONE');
% print_SUBCASE_AERO_STATIC(fid, ID, LABEL, ANALYSIS, DESSUB, TRIM, SPC, SUPORT)
print_SUBCASE_AERO_STATIC(fid, 2, '2.5g Longitude', 'SAERO', 0, 2, SPC_long_id, 1, 'ALL', 'NONE', 'ALL');
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);
%
fid=fopen('SOL144c.bdf','wt');
print_CASE(fid, 144, 0, 'roll', 'NONE');
% print_SUBCASE_AERO_STATIC(fid, ID, LABEL, ANALYSIS, DESSUB, TRIM, SPC, SUPORT)
print_SUBCASE_AERO_STATIC(fid, 3, 'roll', 'SAERO', 0, 3, SPC_lat_id, 2, 'NONE', 'NONE', 'NONE');
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);
%% 创建分析算例(sol145)
fid=fopen('SOL145.bdf','wt');
print_CASE(fid, 145, 0, 'flutter', 'NONE');
% print_SUBCASE_FLUTTER(fid, ID, LABEL, ANALYSIS, DESSUB, METHOD, FMETHOD, SPC)
print_SUBCASE_FLUTTER(fid, 4, 'flutter', 'FLUTTER', 0, 3, 3, SPC_elas_id);
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);
%
%% 创建分析算例(sol200a)
fid=fopen('SOL200a.bdf','wt');
DESOBJ = DRESP1_WEIGHT_id;
DESGLB = [];
if thick_monotonic
    DESGLB = DCONADD_monotonic_id;
end
print_SOL200(fid, DESOBJ, DESGLB, 0);
case_id = 0;
% 1g static
if(flight_cases('1g'))
    case_id = case_id + 1;
    DESSUB = DCONADD_1g_id;
    SUPORT = 1;
    print_SUBCASE_AERO_STATIC(fid, case_id, '1g Longitude', 'SAERO', DESSUB, TRIM_1g_id, SPC_long_id, SUPORT, 'ALL', 'NONE', 'NONE');
end
% 2.5g static
if(flight_cases('2.5g'))
    case_id = case_id + 1;
    DESSUB = DCONADD_25g_id;
    SUPORT = 1;
    print_SUBCASE_AERO_STATIC(fid, case_id, '2.5g Longitude', 'SAERO', DESSUB, TRIM_25g_id, SPC_long_id, SUPORT, 'ALL', 'NONE', 'ALL');
end
% roll static
if(flight_cases('roll'))
    case_id = case_id + 1;
    DESSUB = DCONADD_roll_id;
    SUPORT = 2;
    print_SUBCASE_AERO_STATIC(fid, case_id, 'roll', 'SAERO', DESSUB, TRIM_roll_id, SPC_lat_id, SUPORT, 'NONE', 'NONE', 'NONE');
end
% flutter
if(flight_cases('flutter'))
    case_id = case_id + 1;
    DESSUB = DCONADD_flutter_id;
    print_SUBCASE_FLUTTER(fid, case_id, 'flutter', 'FLUTTER', DESSUB, 3, 3, SPC_elas_id);
end
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'INCLUDE ''opt_parameter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);
%% 创建分析算例(sol200b)
fid=fopen('SOL200b.bdf','wt');
DESOBJ = DRESP1_WEIGHT_id;
DESGLB = [];
if thick_monotonic
    DESGLB = DCONADD_monotonic_id;
end
print_SOL200(fid, DESOBJ, DESGLB, 0);
case_id = 0;
% roll static
if(flight_cases('roll'))
    case_id = case_id + 1;
    DESSUB = DCONADD_roll_id;
    SUPORT = 2;
    print_SUBCASE_AERO_STATIC(fid, case_id, 'roll', 'SAERO', DESSUB, TRIM_roll_id, SPC_lat_id, SUPORT, 'NONE', 'NONE', 'NONE');
end
% flutter
if(flight_cases('flutter'))
    case_id = case_id + 1;
    DESSUB = DCONADD_flutter_id;
    print_SUBCASE_FLUTTER(fid, case_id, 'flutter', 'FLUTTER', DESSUB, 3, 3, SPC_elas_id);
end
% 2.5g static
if(flight_cases('2.5g'))
    case_id = case_id + 1;
    DESSUB = DCONADD_25g_id;
    print_SUBCASE_STATICS(fid, case_id, 'airloads_form_AS1', 'STATICS', DESSUB, LOAD_id, SPC_elas_id, 'ALL', 'NONE', 'ALL');% 2.5g static
end
fprintf(fid,'BEGIN BULK\n');
fprintf(fid,'INCLUDE ''structure.dat''\n');
fprintf(fid,'INCLUDE ''static_loads.dat''\n');
fprintf(fid,'INCLUDE ''constrain.dat''\n');
fprintf(fid,'INCLUDE ''aero.dat''\n');
fprintf(fid,'INCLUDE ''trim.dat''\n');
fprintf(fid,'INCLUDE ''flutter.dat''\n');
fprintf(fid,'INCLUDE ''opt_parameter.dat''\n');
fprintf(fid,'ENDDATA\n');
fclose(fid);