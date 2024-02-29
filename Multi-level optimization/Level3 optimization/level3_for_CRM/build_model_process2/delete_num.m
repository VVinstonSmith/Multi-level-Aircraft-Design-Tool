function A = delete_num(A,a)
% b replace a in A

for ii = 1:length(A)
    if A(ii) == a
        A(ii) = [];
        break;
    end
end


end

