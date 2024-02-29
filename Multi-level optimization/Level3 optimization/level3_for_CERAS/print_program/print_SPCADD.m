function y = print_SPCADD(fid, SID, S)
y = 0;
fprintf(fid,'SPCADD   ');
fprintf(fid,'%-7d ',SID);

S_num = length(S);
for ii = 1:S_num
    fprintf(fid,'%-7d ',S(ii));
    
end
fprintf(fid,'\n');
end
