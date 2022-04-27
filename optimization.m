function statusOptimization=optimization(A)

global cannotBeOptimisedGroup;
global exchangeBothGroup;
global optimizableGroup;

B=rand(2,2);
if ~isequal(size(A),size(B))
    message='The input matrix should be a 2*2 matrix.';
    disp(message);
end

edges=unique(A);
edge=size(edges);
counts=histc(A(:),edges);

naPosition=find(A==-1);
zeroPosition=find(A==0);
adfPosition=find(A==1);

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

if isequal(naNumber+zeroNumber,2) && zeroNumber>=1 && ((isequal(A(1,1),1) && isequal(A(2,2),1)) || (isequal(A(1,2),1) && isequal(A(2,1),1)))
    cannotBeOptimisedGroup(end+1)={A};
    
% elseif isequal(adfNumber,4) || isequal(naNumber,4)
%     cannotBeOptimisedGroup(end+1)={A};
    
elseif isequal(naNumber,2) && isequal(A(1,1),-1) && isequal(A(2,2),-1)
    columnExchange(A);
    
elseif isequal(adfNumber,3) && (isequal(A(2,1),0) || isequal(A(2,1),-1))
    columnExchange(A);
    
elseif isequal(adfNumber,3) && (isequal(A(1,2),0) || isequal(A(1,2),-1))
    rowExchange(A);
    
elseif isequal(naNumber,3) && isequal(A(1,2),-1) && ~isequal(A(1,1),0)
    rowExchange(A);
    
elseif (isequal(A(1,1),-1) && isequal(A(2,2),1) && isequal(zeroNumber,2)) || (isequal(adfNumber,3) && isequal(A(1,1),0)) || (isequal(adfNumber,3) && isequal(A(1,1),-1))
    exchangeBothGroup(end+1)={A};
    optimizableGroup(end+1)={A};

elseif isequal(naNumber,2) && isequal(A(1,2),1) && isequal(A(2,2),1)
    columnExchange(A);

elseif isequal(adfNumber,1)
    if isequal(naNumber,2) && isequal(adfPosition,zeroPosition+1) && (isequal(naPosition(1),zeroPosition+2) || (isequal(naPosition(1),zeroPosition-2)))
        rowExchange(A);
    elseif isequal(naNumber,1) && isequal(adfPosition,zeroPosition(1)+1) && isequal(naPosition,zeroPosition(1)+2)
        rowExchange(A);
    elseif isequal(naNumber,2) && isequal(adfPosition,zeroPosition+2) && (isequal(naPosition(1),zeroPosition+1) || (isequal(naPosition(1),zeroPosition-1)))
        columnExchange(A);
    elseif isequal(naNumber,1) && isequal(adfPosition,zeroPosition(1)+2) && isequal(naPosition,zeroPosition(1)+1)
        columnExchange(A);
    end
    
elseif isequal(adfNumber,2)
    if isequal(naNumber,1) && (isequal(zeroPosition,adfPosition(1)-1) || isequal(zeroPosition,adfPosition(2)-1)) && (isequal(naPosition,zeroPosition+2) || (isequal(naPosition,zeroPosition-2)))
        rowExchange(A);
    elseif isequal(naNumber,1) && (isequal(zeroPosition,adfPosition(1)-2) || isequal(zeroPosition,adfPosition(2)-2)) && (isequal(naPosition,zeroPosition+1) || (isequal(naPosition,zeroPosition-1)))
        columnExchange(A);
    end
end
end

function exchangedRow=rowExchange(A)

global rowExchangeGroup;
global optimizableGroup;

optimizableGroup(end+1)={A};

rowExchangeGroup={};
rowExchangeGroup(end+1)={A};
exchangedRow=rowExchangeGroup;

end

function exchangedColumn=columnExchange(A)

global columnExchangeGroup;
global optimizableGroup;

optimizableGroup(end+1)={A};

columnExchangeGroup={};
columnExchangeGroup(end+1)={A};
exchangedColumn=columnExchangeGroup;

end


