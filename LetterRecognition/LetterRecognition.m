clear all 
close all 
clc
load all_letters.mat

HOW_MANY_COLUMNS = 4; %How many columns for plots

sizeOfFirstDimension = size(letters,1);
sizeOfSecondDimension = size(letters,2);
sizeOfThirdDimensionOriginal = size(letters,3);
mulFirstDimAndSecond = sizeOfFirstDimension * sizeOfSecondDimension;
HOW_MANY_ROWS_FOR_ORIGINAL =  double(uint16(sizeOfThirdDimensionOriginal/HOW_MANY_COLUMNS));

sizeOfThirdDimensionDistorted = size(distorted_letters,3);
HOW_MANY_ROWS_FOR_DISTORTED = double(uint16(sizeOfThirdDimensionDistorted/HOW_MANY_COLUMNS));

%plotting the original (correct) digits 
figure('name','Original letters'); 
colormap([1 1 1; 0 0 0]) 
for i=1:sizeOfThirdDimensionOriginal
    subplot(HOW_MANY_ROWS_FOR_ORIGINAL, HOW_MANY_COLUMNS, i),
    imagesc(letters(:,:,i));
    title(i);
end

%plotting the distorted letters 
figure('name','Distorted letters'); 
colormap([1 1 1; 0 0 0]) 
for i=1:sizeOfThirdDimensionDistorted
    subplot(HOW_MANY_ROWS_FOR_DISTORTED, HOW_MANY_COLUMNS, i),
    imagesc(distorted_letters(:,:,i));
    title(i);
end

 %creating the input (training) matrix
X=zeros(mulFirstDimAndSecond, sizeOfThirdDimensionOriginal);
for i=1:sizeOfThirdDimensionOriginal
    x_temp=letters(:,:,i);
    X(:,i)=x_temp(:);
end


%%%%%%%%%%%%%%%%%%Hebb rule%%%%%%%%%%%%%%%% 
%creating auto-associative memory using Hebb rule
W=(X*(X.') - sizeOfThirdDimensionDistorted * eye( mulFirstDimAndSecond )) / mulFirstDimAndSecond;
% %processing through the neural network for distorted digits 
Y=zeros(mulFirstDimAndSecond, sizeOfThirdDimensionDistorted);
Y_previous=zeros(mulFirstDimAndSecond, sizeOfThirdDimensionDistorted);
Y_sub=ones(mulFirstDimAndSecond, sizeOfThirdDimensionDistorted);
zeroes = zeros(mulFirstDimAndSecond, sizeOfThirdDimensionDistorted);
while (~isequal(Y_sub,zeroes))
    for i=1:sizeOfThirdDimensionDistorted
        x_temp=distorted_letters(:,:,i);
        Y(:,i)=sign(W*x_temp(:));
    end
    Y_sub = Y - Y_previous;
    Y_previous = Y;
end

%plotting reconstructed digits 
%figure;
figure('name','Recognized letters using Hebb rule'); 
colormap([1 1 1; 0 0 0]) 
for i=1:sizeOfThirdDimensionDistorted
    subplot(HOW_MANY_ROWS_FOR_DISTORTED, HOW_MANY_COLUMNS, i),
    imagesc(reshape(Y(:,i), sizeOfFirstDimension, sizeOfSecondDimension));
    title(i);
end


%%%%%%%%%%%%%%%%%%Pseudoinverse%%%%%%%%%%%%%%%% 
%creating auto-associative memory using pseudoinverse 
X_pseudoinverse = pinv(X);
W=X*X_pseudoinverse;

%processing through the neural network for distorted digits
Y=zeros(mulFirstDimAndSecond, sizeOfThirdDimensionDistorted);
for i=1:sizeOfThirdDimensionDistorted
    x_temp=distorted_letters(:,:,i);
    Y(:,i)=sign(W*x_temp(:));
end

%plotting reconstructed digits 
%figure;
figure('name','Recognized letters using pseudoinversion rule'); 
colormap([1 1 1; 0 0 0]) 
for i=1:sizeOfThirdDimensionDistorted
    subplot(HOW_MANY_ROWS_FOR_DISTORTED, HOW_MANY_COLUMNS, i),
    imagesc(reshape(Y(:,i), sizeOfFirstDimension, sizeOfSecondDimension));
    title(i);
end

save pseudoInverseMatrix X_pseudoinverse