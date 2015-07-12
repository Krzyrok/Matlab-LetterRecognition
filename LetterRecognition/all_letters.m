clear all 
close all 
clc

load arial32.mat
letter = 'A';
sizeOfAlphabet = 'Z'-'A' + 1;
partOfName=' binAr_';
for i=1:sizeOfAlphabet

    operation = [partOfName,letter,' = (-2) * ', partOfName, letter, ' + ones(size(', partOfName, letter, ', 1), size(', partOfName, letter, ', 2));']; % change 1 on -1 and 0 on 1
    eval(operation);
    
    operation = ['letters(:,:,', int2str(i),') =', partOfName, letter, '(:,:);']; % put 2D matrix to the 3D matrix
    eval(operation);
    
    letter = letter + 1;
    letter = cast(letter, 'char');
end

load times32.mat
letter = 'A';
sizeOfAlphabet = 'Z'-'A' + 1;
partOfName=' binTi_';
for i=1:sizeOfAlphabet

    operation = [partOfName,letter,' = (-2) * ', partOfName, letter, ' + ones(size(', partOfName, letter, ', 1), size(', partOfName, letter, ', 2));']; % change 1 on -1 and 0 on 1
    eval(operation);
    
    operation = ['distorted_letters(:,:,', int2str(i),') =', partOfName, letter, '(:,:);']; % put 2D matrix to the 3D matrix
    eval(operation);
    
    letter = letter + 1;
    letter = cast(letter, 'char');
end
   
save all_letters letters distorted_letters
