function optimisedMatrix = optimiseEntireMatrix(A)

global relocatedColumnIndex;
global relocatedRowIndex;
global optimisedColumnIndex;
global optimisedRowIndex;
global offChipCrossingOptimization;

sizeA=size(A);
rows=sizeA(1);
columns=sizeA(2);

offChipCrossingOptimization=0;
optimisedColumnIndex=relocatedColumnIndex;
optimisedRowIndex=relocatedRowIndex;

for o=1:rows
    for i=1:rows
        for p=1:columns
            for j=1:columns
                if isequal(A(o,p),0) && isequal(A(i,j),0)
                    if (o<i && p>j) || (o>i && p<j)
                        if ismember(0,A([o],:))
                            zeroOnRow=A([o],:);
                            indexZero=find(zeroOnRow==0);
                            A(:,[indexZero o])=A(:,[o indexZero]);
                            optimisedColumnIndex([indexZero o])=optimisedColumnIndex([o indexZero]);
                        end
                    end
                end
            end
        end
    end
end 

if ~isequal(relocatedColumnIndex,optimisedColumnIndex)
    for i=1:length(optimisedColumnIndex)-1
        for j=1:length(relocatedRowIndex)
            if isequal(optimisedColumnIndex(i),relocatedRowIndex(j))
                rightOfColumnElement=optimisedColumnIndex([i+1:length(optimisedColumnIndex)]);
                underOfRowElement=relocatedRowIndex([j+1:length(relocatedRowIndex)]);
                intersection=intersect(rightOfColumnElement,underOfRowElement);
                if isempty(intersection) || ~isequal(intersection,rightOfColumnElement)
                    offChipCrossingOptimization=offChipCrossingOptimization+length(rightOfColumnElement)-length(intersection);
                end
            end
        end
    end
end
% 
% disp('optimised column Index');
% disp(optimisedColumnIndex);
% disp('optimised row Index');
% disp(optimisedRowIndex);
% 
% disp('off chip crossing after optimization')
% disp(offChipCrossingOptimization);

optimisedMatrix=A;
disp(optimisedMatrix);

end

