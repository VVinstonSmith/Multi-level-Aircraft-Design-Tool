function y = print_RBAR(fid, EID, GRID_A, GRID_B, CNA, CNB)
y = 0;
fprintf(fid,'RBAR     ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',GRID_A);
fprintf(fid,'%-7d ',GRID_B);
if CNA~=0
    fprintf(fid,'%-7d ',CNA);
end
if CNB~=0
    fprintf(fid,'%-7d ',CNB);
end
fprintf(fid,'\n');

end
