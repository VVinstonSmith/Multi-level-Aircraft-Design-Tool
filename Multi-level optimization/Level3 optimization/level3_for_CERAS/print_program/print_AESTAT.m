function y = print_AESTAT(fid, ID, LABEL)
fprintf(fid,'$ Rigid Body Motion Trim Variables:\n');
y=0;
    
for ii = 1:length(ID)
    fprintf(fid,'AESTAT   ');
    fprintf(fid,'%-7d ',ID(ii));
    fprintf(fid,'%-7s\n',LABEL{ii});
end

end
    
