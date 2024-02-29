function y = print_DTABLE(fid, LABL, VALU)

fprintf(fid,'$\n');
y = 0;

fprintf(fid,'DTABLE   ');

for ii = 1:length(LABL)
    fprintf(fid,'%-7s ',LABL{ii});
    if VALU(ii) > 10000
        [front, back] = getmydata(VALU(ii));
        fprintf(fid,'%4.2f+',front);
        fprintf(fid,'%02d ',back);
    elseif VALU(ii)<10
        fprintf(fid,'%-7.4f ',VALU(ii));
    else
        fprintf(fid,'%-7.2f ',VALU(ii));
    end
    if mod(ii,4)==0 && ii~=length(LABL)
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

end
    
