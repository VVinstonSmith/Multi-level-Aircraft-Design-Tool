function y = print_AESURF(fid, SID, NAME, CREF, SREF, RANGE, Coord_1, AELIST_1, CAERO_1, Coord_2, AELIST_2, CAERO_2)
fprintf(fid,'$ Control Device: %s\n',NAME);
y = 0;
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$AESURF  ID      LABEL   CID1    ALID1   CID2    ALID2   EFF     LDW \n');
fprintf(fid,'$        CREFC   CREFS   PLLM    PULM \n');
fprintf(fid,'AESURF   ');
fprintf(fid,'%-7d ',SID);
fprintf(fid,'%-7s ',NAME);
fprintf(fid,'%-7d ',Coord_1);
fprintf(fid,'%-7d ',AELIST_1);
if AELIST_2 ~= 0
    fprintf(fid,'%-7d ',Coord_2);
    fprintf(fid,'%-7d ',AELIST_2);
end

fprintf(fid,'\n');
fprintf(fid,'         ');
fprintf(fid,'%-7.2f ',CREF);
fprintf(fid,'%-7.2f ',SREF);
fprintf(fid,'%-7.2f ',RANGE(1));
fprintf(fid,'%-7.2f\n',RANGE(2));

fprintf(fid,'AELIST   ');
fprintf(fid,'%-7d ',AELIST_1);
row_num = 3;
for ii= 1:length(CAERO_1)
	fprintf(fid,'%-7d ',CAERO_1(ii));
    row_num = row_num + 1;
    if row_num==10
        if ii==length(CAERO_1)
            break;
        end
        row_num = 2;
        fprintf(fid,'\n');
        fprintf(fid,'         ');
    end
end
fprintf(fid,'\n');

if AELIST_2 ~= 0
    fprintf(fid,'AELIST   ');
    fprintf(fid,'%-7d ',AELIST_2);
    row_num = 3;
    for ii= 1:length(CAERO_2)
        fprintf(fid,'%-7d ',CAERO_2(ii));
        row_num = row_num + 1;
        if row_num==10
            if ii==length(CAERO_2)
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
    
