function y = print_MKAERO2(fid, MACH, K)
fprintf(fid,'$MACH, K\n');
y = 0;
fprintf(fid,'MKAERO2  ');

for ii = 1:length(K)
    fprintf(fid,'%-7.2f ',MACH(ii));
    fprintf(fid,'%-7.4f ',K(ii));
    if mod(ii,4) == 0 && ii~= length(K)
        fprintf(fid,'\n');
        fprintf(fid,'MKAERO2  ');
    end
end
fprintf(fid,'\n');

end
    
