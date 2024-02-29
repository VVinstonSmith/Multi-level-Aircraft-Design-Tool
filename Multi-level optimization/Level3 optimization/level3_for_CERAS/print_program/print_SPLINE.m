function y = print_SPLINE(fid, EID, CAERO, CAERO_num, AELIST, SET_num, SET, method, FPS_num)

y = 0;
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$SPLINE4 EID     CAERO   AELIST          SETG    DZ      METH    USAGE\n');
fprintf(fid,'$        NELEM   MELEM\n');
%
fprintf(fid,'SPLINE4  ');
fprintf(fid,'%-7d ',EID);
fprintf(fid,'%-7d ',CAERO);
fprintf(fid,'%-7d ',AELIST);
fprintf(fid,'        ');
fprintf(fid,'%-7d ',SET_num);
fprintf(fid,'        ');

if strcmp(method,'FPS')
    fprintf(fid,'FPS     ');
    fprintf(fid,'BOTH\n');
    fprintf(fid,'         ');
    fprintf(fid,'%-7d ',FPS_num(1));
    fprintf(fid,'%-7d\n',FPS_num(2));
else
    fprintf(fid,'IPS     ');
    fprintf(fid,'BOTH\n');
end

fprintf(fid,'AELIST   ');
fprintf(fid,'%-7d ',AELIST);
row_num = 3;
for ii= 1:CAERO_num
	fprintf(fid,'%-7d ',CAERO+ii-1);
    row_num = row_num + 1;
    if row_num==10
        if ii==CAERO_num
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

if SET~=0
    fprintf(fid,'SET1     ');
    fprintf(fid,'%-7d ',SET_num);
    row_num = 3;
    for ii= 1:length(SET)
        fprintf(fid,'%-7d ',SET(ii));
        row_num = row_num + 1;
        if row_num==10
            if ii==length(SET)
                break;
            end
            row_num = 2;
            fprintf(fid,'\n');
            fprintf(fid,'         ');
        end
    end
    fprintf(fid,'\n');
end


end
    
