function y = print_PSHELL(fid, PID, MID1, thick, MID2, MID3, NSM, hs_rate)
y = 0;

fprintf(fid,'PSHELL   ');
fprintf(fid,'%-7d ',PID);
fprintf(fid,'%-7d ',MID1);
fprintf(fid,'%-7.5f ',thick);
fprintf(fid,'%-7d ',MID2);
fprintf(fid,'        ');
fprintf(fid,'%-7d ',MID3);
fprintf(fid,'        ');
fprintf(fid,'%-7.2f\n',NSM);
%
hs = hs_rate * 0.5*thick;
fprintf(fid,'        ');
fprintf(fid,'%-7.5f ',hs);
fprintf(fid,'%-7.5f\n',hs);
end

