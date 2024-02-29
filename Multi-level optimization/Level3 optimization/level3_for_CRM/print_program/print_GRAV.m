function y = print_GRAV(fid, SID, CID, A, N)
% SID : GRAV_id
% CID: Coordinate
% A: accelerate
% N: [N1,N2,N3]

y = 0;
fprintf(fid,'GRAV     ');
fprintf(fid,'%-7d ',SID);
fprintf(fid,'%-7d ',CID);
print_form_number(fid,A);
fprintf(fid,'%-7.2f ',N(1));
fprintf(fid,'%-7.2f ',N(2));
fprintf(fid,'%-7.2f\n',N(3));

end
    
