% NA: -1
% 0: 0
% *: 1

function dividedMatrix=division(A)

global divided;
global sizeMatrix;

modulo=mod(size(A),2);
dim1Dist=ones(1,divided)*2;


if ~isequal(sizeMatrix(1),sizeMatrix(2)) || ~isequal(modulo(1),0)
    correction='The size of the matrix should be [2n,2n].';
    disp(correction);
    return;
end

dividedMatrix=mat2cell(A,dim1Dist,dim1Dist);

end

