function finished = algorithm(A)

tic;

global divided;
global dividedMatrix;
global sizeMatrix;
global efficientGroup;
global inefficientGroup;
global middleEfficientGroup;
global cannotBeOptimisedGroup;
global exchangeBothGroup;
global optimizableGroup;

efficientGroup={};
inefficientGroup={};
middleEfficientGroup={};
cannotBeOptimisedGroup={};
exchangeBothGroup={};
optimizableGroup={};

sizeMatrix=size(A);
divided=fix(sizeMatrix(1)/2);

% Step 3: Division
dividedMatrix=division(A);

% Step 4: Check the efficiency of every block
for i=1:divided
    for j=1:divided
        cell=dividedMatrix{i,j};
        optimization(cell);
        efficientTest(cell);
    end
end

% Step 5: Relocation the matrix for optimization
relocated=relocationMatrix(A);

% Step 6: Optimise the entire matrix
disp('The optimised matrix is:')
optimisedMatrix=optimiseEntireMatrix(relocated);

% Step Count crossings number
disp('The on chip crossings number after optimization is:')
onchipCrossing=countCrossingNumber(optimisedMatrix);
offChipCrossing=offChipCrossingNumber();
disp('The original crossing number in the Matrix is: ')
originalCrossing=countCrossingNumber(A);
disp('The current total crossing number of the matrix:')
totalCrossingNumber=onchipCrossing+offChipCrossing;
disp(totalCrossingNumber);
improvedCrossing=100*(originalCrossing-totalCrossingNumber)/originalCrossing;

if improvedCrossing>0
    fprintf('The crossing number of this matrix is reduced by %.2f %%.\n',improvedCrossing);
else
    disp('The crossing number after optimization is higher than before, so we do not change the structure of the matrix.');
end

toc;

end