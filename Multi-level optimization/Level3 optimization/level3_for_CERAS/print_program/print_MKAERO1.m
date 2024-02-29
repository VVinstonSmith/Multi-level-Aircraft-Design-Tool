function y = print_MKAERO1(fid, MACH, K)

y = 0;
fprintf(fid,'MKAERO1  ');

for ii = 1:length(MACH)
    fprintf(fid,'%-7.2f ',MACH(ii));
end
fprintf(fid,'\n');
fprintf(fid,'         ');
for ii = 1:length(K)
    fprintf(fid,'%-7.4f ',K(ii));
end
fprintf(fid,'\n');

end
    
