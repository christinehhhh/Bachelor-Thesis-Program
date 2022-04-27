function crossingOffChip = offChipCrossingNumber()

global relocatedRowIndex;
global relocatedColumnIndex;
global offChipCrossingOptimization;
global offChipCrossingRelocation;
global rowOriginalIndex;
global optimisedColumnIndex;

if isequal(rowOriginalIndex,relocatedRowIndex)
    crossingOffChip=offChipCrossingOptimization;
elseif isequal(relocatedRowIndex,relocatedColumnIndex)
    crossingOffChip=offChipCrossingOptimization;
elseif ~isequal(relocatedRowIndex,relocatedColumnIndex) && ~isequal(relocatedColumnIndex,optimisedColumnIndex)
    
%     这一段是后面改的
    for i=1:length(optimisedColumnIndex)-1
        for j=1:length(relocatedRowIndex)
            if isequal(optimisedColumnIndex(i),relocatedRowIndex(j))
                rightOfColumnElement=optimisedColumnIndex([i+1:length(optimisedColumnIndex)]);
                underOfRowElement=relocatedRowIndex([j+1:length(relocatedRowIndex)]);
                intersection=intersect(rightOfColumnElement,underOfRowElement);
                if isempty(intersection) || ~isequal(intersection,rightOfColumnElement)
                    offChipCrossingRelocation=offChipCrossingRelocation+length(rightOfColumnElement)-length(intersection);
                end
            end
        end
    end
    
%     for i=1:length(relocatedColumnIndex)-1
%         for j=1:length(relocatedRowIndex)
%             if isequal(relocatedColumnIndex(i),relocatedRowIndex(j))
%                 rightOfColumnElement=relocatedColumnIndex([i+1:length(relocatedColumnIndex)]);
%                 underOfRowElement=relocatedRowIndex([j+1:length(relocatedRowIndex)]);
%                 intersection=intersect(rightOfColumnElement,underOfRowElement);
%                 if isempty(intersection) || ~isequal(intersection,rightOfColumnElement)
%                     offChipCrossingRelocation=offChipCrossingRelocation+length(rightOfColumnElement)-length(intersection);
%                 end
%             end
%         end
%     end

    crossingOffChip=offChipCrossingOptimization+offChipCrossingRelocation;
else
    crossingOffChip=offChipCrossingOptimization+offChipCrossingRelocation;
end

disp('The off chip crossings number after optimization is: ')
disp(crossingOffChip);

end

