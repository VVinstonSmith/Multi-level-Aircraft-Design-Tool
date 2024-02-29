function y = print_FORCE(fid, SID, G, CID, F, N)
% G: GRID_id
% CID: Coordinate
% F: Force
% N: [N1,N2,N3]

y = 0;
fprintf(fid,'FORCE    ');
fprintf(fid,'%-7d ',SID);
fprintf(fid,'%-7d ',G);
fprintf(fid,'%-7d ',CID);
print_form_number(fid,F);
fprintf(fid,'%-7.2f ',N(1));
fprintf(fid,'%-7.2f ',N(2));
fprintf(fid,'%-7.2f\n',N(3));

end
    
