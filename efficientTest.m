function blockEfficiency=efficientTest(A)

global optimizableGroup;
global cannotBeOptimisedGroup;

B=rand(2,2);
if ~isequal(size(A),size(B))
    message='The input matrix should be a 2*2 matrix.';
    disp(message);
end

edges=unique(A);
edge=size(edges);
counts=histc(A(:),edges);

if isequal(edge(1),1) && ismember(-1,edges)
    naNumber=4;
    zeroNumber=0;
    adfNumber=0;
elseif isequal(edge(1),1) && ismember(1,edges)
    adfNumber=4;
    zeroNumber=0;
    naNumber=0;
end

for i =1:size(edges)
    if ~ismember(-1,edges)
        naNumber=0;
    elseif ~ismember(0,edges)
        zeroNumber=0;
    elseif ~ismember(1,edges)
        adfNumber=0;
    end 
end

for i =1:size(edges)
    if (isequal(edges(i),-1)) 
        naNumber=counts(i);
    elseif isequal(edges(i),0)
         zeroNumber=counts(i);
    elseif isequal(edges(i),1) 
        adfNumber=counts(i);
    end
end

if isInCell(optimizableGroup,A) || isInCell(cannotBeOptimisedGroup,A)
    if isequal(A(1,2),0) && isequal(A(2,1),0) && isequal(A(2,2),1) && isequal(zeroNumber,2)
        blockEfficiency=inefficient(A);
    
    elseif isequal(zeroNumber,1) && isequal(adfNumber,3) && ~isequal(A(2,2),0)
        blockEfficiency=inefficient(A);
     
    elseif ~isequal(A(1,1),1) && isequal(zeroNumber,1) && isequal(adfNumber,2) && isequal(A(2,2),1) 
        blockEfficiency=inefficient(A);

    elseif isequal(A(1,1),-1) && isequal(adfNumber,3)
        blockEfficiency=inefficient(A);
       
    elseif isequal(naNumber,2) && isequal(A(1,1),-1) && isequal(A(2,2),-1)
        blockEfficiency=middleEfficient(A);
    
    elseif isequal(A(1,1),0) && ~isequal(A(2,2),1) && adfNumber>=1
        blockEfficiency=middleEfficient(A);
    
    elseif naNumber>=1 && isequal(A(2,2),1) && (isequal(A(1,2),0)||isequal(A(2,1),0))
        blockEfficiency=middleEfficient(A);
    
    elseif isequal(A(1,1),-1) && isequal(A(2,2),0) && isequal(adfNumber,2)
        blockEfficiency=middleEfficient(A);
    end
    
else
    blockEfficiency=efficient(A);
end
end


function isEfficient=efficient(A)

global efficientGroup;

efficientGroup(end+1)={A};
isEfficient=efficientGroup;

end

function isInefficient=inefficient(A)

global inefficientGroup;

inefficientGroup(end+1)={A};
isInefficient=inefficientGroup;

end

function isMiddleEfficient=middleEfficient(A)

global middleEfficientGroup;

middleEfficientGroup(end+1)={A};
isMiddleEfficient=middleEfficientGroup;

end

function R = isInCell(A, b)
R = false;
for k = 1:numel(A)
  if isequal(A{k}, b)
    R = true;
    return;
  end
end
end
