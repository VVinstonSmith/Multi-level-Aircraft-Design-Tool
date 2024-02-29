function y = print_FLFACT(fid, SID, dens_rate, mach, velocity)

y = 0;
if isempty(dens_rate) == 0
    fprintf(fid,'$ DENS_RATE\n');
    fprintf(fid,'FLFACT   ');
    fprintf(fid,'%-7d ',SID(1));
    row_num = 3;
    for ii= 1:length(dens_rate)
        fprintf(fid,'%-7.2f ',dens_rate(ii));
        row_num = row_num + 1;
        if row_num==10
            if ii==length(dens_rate)
                break;
            end
            row_num = 2;
            fprintf(fid,'\n');
            fprintf(fid,'         ');
        end
    end
    fprintf(fid,'\n');
    fprintf(fid,'$\n');
end

if isempty(mach) == 0
    fprintf(fid,'$ MACH\n');
    fprintf(fid,'FLFACT   ');
    fprintf(fid,'%-7d ',SID(2));
    row_num = 3;
    for ii= 1:length(mach)
        fprintf(fid,'%-7.2f ',mach(ii));
        row_num = row_num + 1;
        if row_num==10
            if ii==length(mach)
                break;
            end
            row_num = 2;
            fprintf(fid,'\n');
            fprintf(fid,'         ');
        end
    end
    fprintf(fid,'\n');
    fprintf(fid,'$\n');
end

if isempty(velocity) == 0
    fprintf(fid,'$ Velocity\n');
    fprintf(fid,'FLFACT   ');
    fprintf(fid,'%-7d ',SID(3));
    row_num = 3;
    for ii= 1:length(velocity)
        fprintf(fid,'%-7.2f ',velocity(ii));
        row_num = row_num + 1;
        if row_num==10
            if ii==length(velocity)
                break;
            end
            row_num = 2;
            fprintf(fid,'\n');
            fprintf(fid,'         ');
        end
    end
    fprintf(fid,'\n');
    fprintf(fid,'$\n');
end

end
    
