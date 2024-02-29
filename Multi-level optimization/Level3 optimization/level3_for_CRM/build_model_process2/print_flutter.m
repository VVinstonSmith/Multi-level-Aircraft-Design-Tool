
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
% print_EIGRL(fid, ID, ND, MSGLVL)
print_EIGRL(fid, 3, 15, 0);

% print_AERO(fid, not_half, RHO, ACSID, CREF)
print_AERO(fid, 1, RHO_air2, 0, C_A_wing);

K = [0.001, 0.01, 0.1, 0.3, 0.5, 1.0];
print_MKAERO1(fid, Ma2, K);

% print_FLFACT(fid, SID, dens_rate, mach, velocity)
FLFACT_rho = 1.0;
FLFACT_Ma = Ma2;
FLFACT_V =  160:20:240;
print_FLFACT(fid, [FLFACT_rho_id, FLFACT_Ma_id, FLFACT_V_id],...
    FLFACT_rho, FLFACT_Ma, FLFACT_V);

% print_FLUTTER(fid, SID, METH, DENS_id, MACH_id, PFREQ_id, IMETH, NVALUE)
print_FLUTTER(fid, 3, 'PK', 1, 2, 3, 0, 15);


%
LMODES = 15;
fprintf(fid,'PARAM    ');
fprintf(fid,'LMODES  ');
fprintf(fid,'%-7d\n',LMODES);
%
OPPHIPA = 1;
fprintf(fid,'PARAM    ');
fprintf(fid,'OPPHIPA ');
fprintf(fid,'%-7d\n',OPPHIPA);

