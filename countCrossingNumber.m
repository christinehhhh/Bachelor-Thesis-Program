function crossingNumber = countCrossingNumber(A)

global sizeMatrix;

rows=sizeMatrix(1);
columns=sizeMatrix(2);
lastPosition=A(rows,columns);
nsRow=A([rows],:);
nmColumn=A(:,[columns]);

edges=unique(A);
edge=size(edges);
counts=histc(A(:),edges);

edgesNsRow=unique(nsRow);
nsCounts=histc(nsRow(:),edgesNsRow);

edgesNmColumn=unique(nmColumn);
nmCounts=histc(nmColumn(:),edgesNmColumn);

oneZeroLaw(A);

if isequal(edge(1),1) && ismember(-1,edges)
    naNumber=numel(A);
    zeroNumber=0;
elseif isequal(edge(1),1) && ismember(1,edges)
    zeroNumber=0;
    naNumber=0;
end

for i =1:size(edges)
    if ~ismember(-1,edges)
        naNumber=0;
    elseif ~ismember(0,edges)
        zeroNumber=0;
    elseif ~ismember(1,edges)
    end 
end

for i =1:size(edges)
    if isequal(edges(i),-1)
        naNumber=counts(i);
    elseif isequal(edges(i),0)
         zeroNumber=counts(i);
    elseif isequal(edges(i),1) 
    end
end

if isequal(lastPosition,0)
    zeroLastPosition=1;
    naLastPosition=0;
elseif isequal(lastPosition,-1)
    naLastPosition=1;
    zeroLastPosition=0;
elseif isequal(lastPosition,1)
    zeroLastPosition=0;
    naLastPosition=0;
end

naNsRow=0;
for i = 1:size(edgesNsRow)
    if isequal(edgesNsRow(i),-1)
        naNsRow=nsCounts(i);
    end
end

naNmColumn=0;
for i = 1:size(edgesNmColumn)
    if isequal(edgesNmColumn(i),-1)
        naNmColumn=nmCounts(i);
    end
end


crossings1=zeroNumber+naNumber-zeroLastPosition-naLastPosition;

if isequal(lastPosition,-1)
    crossings2=naNsRow+naNmColumn-2;
else
    crossings2=naNsRow+naNmColumn;
end

crossings3=0;
for o=1:rows
    for i=1:rows
        for p=1:columns
            for j=1:columns
                if isequal(A(o,p),0) && isequal(A(i,j),0)
                    if o<i && p>j
                        crossings3=crossings3+1;
                    end
                end
            end
        end
    end
end

crossings4=0;
naOnLastColumn=find(nmColumn==-1);
if ismember(rows,naOnLastColumn)
    indexEdgeRow=length(naOnLastColumn);
    naOnLastColumn(indexEdgeRow)=[];
end
rowWithLastNa=A([naOnLastColumn],:);
rowsWithLastNaCell={};
rowsWithLastNaCell(end+1)={rowWithLastNa};
rowsWithLastNa=cell2mat(rowsWithLastNaCell);
sizeRowsWithLastNa=size(rowsWithLastNa);
if ~isequal(0,sizeRowsWithLastNa(1))
    sequenceRow=zeros(sizeRowsWithLastNa(1),columns);
    rowDist=ones(1,sizeRowsWithLastNa(1));
    sequenceRowCell=mat2cell(sequenceRow,rowDist);
    numNaSequence1=zeros(1,sizeRowsWithLastNa(1));
    for i=1:sizeRowsWithLastNa(1)
        q1=diff([0 rowsWithLastNa([i],:) 0]==-1);
        findMinusOne1=find(q1==-1);
        findOne1=find(q1==1);
        sizeFindMinusOne1=size(findMinusOne1);
        sizeFindOne1=size(findOne1);
        findMinusOne1(1:sizeFindMinusOne1(2)-1)=[];
        findOne1(1:sizeFindOne1(2)-1)=[];
        v1=findMinusOne1-findOne1;
        if v1>1
            sequenceRowCell(i)=mat2cell(rowsWithLastNa([i],:),1);
            crossings4=crossings4+v1-1;
            numNaSequence1(i)=v1;
        end
        sequenceRow=cell2mat(sequenceRowCell);
        sizeSequenceRow=size(sequenceRow);
    end
end

crossings5=0;
naOnLastRow=find(nsRow==-1);
if ismember(columns,naOnLastRow)
    indexEdgeColumn=length(naOnLastRow);
    naOnLastRow(indexEdgeColumn)=[];
end
columnWithLastNa=A(:,[naOnLastRow]);
columnsWithLastNaCell={};
columnsWithLastNaCell(end+1)={columnWithLastNa};
columnsWithLastNa=cell2mat(columnsWithLastNaCell);
sizeColumnsWithLastNa=size(columnsWithLastNa);
if ~isequal(0,sizeColumnsWithLastNa(2))
    sequenceColumn=zeros(rows,sizeColumnsWithLastNa(2));
    columnDist=ones(1,sizeColumnsWithLastNa(2));
    sequenceColumnCell=mat2cell(sequenceColumn,rows,columnDist);
    numNaSequence2=zeros(1,sizeColumnsWithLastNa(2));
    for i=1:sizeColumnsWithLastNa(2)
        q2=diff([0 (columnsWithLastNa(:,[i]))' 0]==-1);
        findMinusOne2=find(q2==-1);
        findOne2=find(q2==1);
        sizeFindMinusOne2=size(findMinusOne2);
        sizeFindOne2=size(findOne2);
        findMinusOne2(1:sizeFindMinusOne2(2)-1)=[];
        findOne2(1:sizeFindOne2(2)-1)=[];
        v2=findMinusOne2-findOne2;
        if v2>1
            sequenceColumnCell(i)=mat2cell(columnsWithLastNa(:,[i]),sizeColumnsWithLastNa(1));
            crossings5=crossings5+v2-1;
            numNaSequence2(i)=v2;
        end
        sequenceColumn=cell2mat(sequenceColumnCell);
        sizeSequenceColumn=size(sequenceColumn);
     end
end

crossings6=0;
if ~isequal(0,sizeRowsWithLastNa(1))
    if isequal(zeros(sizeSequenceRow),sequenceRow)
        for i=1:sizeRowsWithLastNa(1)
            if ismember(0,rowsWithLastNa([i],:))
                crossings6=crossings6+1;
            end
        end
    else
        for i=1:sizeRowsWithLastNa(1)
            for j=1:sizeSequenceRow(1)
                if ismember(0,rowsWithLastNa([i],:)) && isequal(sequenceRow([j],:),rowsWithLastNa([i],:)) && ~isequal(zeros(1,columns),rowsWithLastNa(:,[i]))
                    crossings6=crossings6+numNaSequence1(i);
                    rowsWithLastNa([i],:)=zeros(1,columns);
                end
            end
            if ismember(0,rowsWithLastNa([i],:)) && ~isequal(zeros(1,columns),rowsWithLastNa([i],:))
                crossings6=crossings6+1;
            end
        end
    end
end

crossings7=0;
if ~isequal(0,sizeColumnsWithLastNa(2))
    if isequal(zeros(sizeSequenceColumn),sequenceColumn)
        for i=1:sizeColumnsWithLastNa(2)
            if ismember(0,columnsWithLastNa(:,[i]))
                crossings7=crossings7+1;
            end
        end
    else
        for i=1:sizeColumnsWithLastNa(2)
            for j=1:sizeSequenceColumn(2)
                if ismember(0,columnsWithLastNa(:,[i])) && isequal(sequenceColumn(:,[j]),columnsWithLastNa(:,[i])) && ~isequal(zeros(rows,1),sequenceColumn(:,[j]))
                    crossings7=crossings7+numNaSequence2(i);
                    columnsWithLastNa(:,[i])=zeros(rows,1);
                end
            end
            if ismember(0,columnsWithLastNa(:,[i])) && ~isequal(zeros(rows,1),columnsWithLastNa(:,[i]))
                crossings7=crossings7+1;
            end
        end
    end
end

crossings8=0;
zeroOnLastColumn=find(nmColumn==0);
if ismember(rows,zeroOnLastColumn+1) || ismember(rows,zeroOnLastColumn)
    indexZeroEdgeRow=length(zeroOnLastColumn);
    zeroOnLastColumn(indexZeroEdgeRow)=[];
end
bellowZeroColumn=nmColumn;
bellowZeroColumn([1:zeroOnLastColumn])=[];
sizeBellowZeroColumn=length(zeroOnLastColumn+1:rows);
if isequal(-ones(sizeBellowZeroColumn,1),bellowZeroColumn)
    naBetweenColumn=rows-zeroOnLastColumn;
    crossings8=crossings8+naBetweenColumn;
%     不应该是加一，是加上中间的na的数量
end

crossings9=0;
zeroOnLastRow=find(nsRow==0);
if ismember(columns,zeroOnLastRow+1) || ismember(columns,zeroOnLastRow)
    indexZeroEdgeColumn=length(zeroOnLastRow);
    zeroOnLastRow(indexZeroEdgeColumn)=[];
end
RightZeroRow=nsRow;
RightZeroRow([1:zeroOnLastRow])=[];
sizeRightZeroRow=length(zeroOnLastRow+1:columns);
if isequal(-ones(1,sizeRightZeroRow),RightZeroRow)
    naBetweenRow=columns-zeroOnLastRow;
    crossings9=crossings9+naBetweenRow;
end

crossing10=0;



crossingNumber=crossings1-crossings2+crossings3-crossings4-crossings5+crossings6+crossings7-crossings8-crossings9-crossing10;
disp(crossingNumber);

end


