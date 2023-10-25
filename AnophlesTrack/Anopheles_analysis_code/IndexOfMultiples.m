function Ind = IndexOfMultiples(A)
T   = true(size(A));
off = false;
A   = A(:);
for iA = 1:numel(A)
  if T(iA)          % if not switched already
    d = (A(iA) == A);
    if sum(d) > 1   % More than 1 occurrence found
       T(d) = off;  % switch all occurrences
    end
  end
end
Ind = find(~T);
end