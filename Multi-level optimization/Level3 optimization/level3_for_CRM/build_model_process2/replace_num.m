function A = replace_num(A,a,b)
% b replace a in A

for ii = 1:length(A)
    if A(ii) == a
        A(ii) = b;
        break;
    end
end


end

