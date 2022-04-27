function restrained = oneZeroLaw(A)

sizeA=size(A);

for i=1:sizeA(1)
    zeroRow=find(A(i,:)==0);
    if length(zeroRow)>1
        error('There can only be one zero in each row.');
    end
end
 
for i=1:sizeA(2)
    zeroColumn=find(A(:,i)==0);
    if length(zeroColumn)>1
        error('There can only be one zero in each column.');
    end
end
end

