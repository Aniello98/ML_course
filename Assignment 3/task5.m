clear all
close all
clc

% Load the data set from the file 'student_debt_data.csv'
A = load('linear_2output_regression.csv');

% Input variables as a matrix with samples on rows
X = A(1:2,:)';

% Output variables as a matrix with samples on rows
Y = A(3:end,:)';

% Call your fitting function
W = fitMultipleOutputRegression( X, Y )


% Plot the result (not mandatory, but beneficial)

% Initialize a regular mesh to plot the fitted plane
xx = 0:0.1:1;           % Span of mesh data
[XX,YY] = meshgrid(xx); % Create the mesh

% Number of output variables 
C = size(Y,2);

% Make the figures
figure
for i = 1:C
    
    subplot(C,1,i)

    scatter3( X(:,1), X(:,2), Y(:,i), 'filled', 'k' )
    view(25,25) 
    xlabel('x_1')
    ylabel('x_2')
    zlabel(sprintf('y_%d', i))
    title(sprintf('Plot of output %d samples and the fitted plane', i))
    
    hold on
    
    ZZ = arrayfun( @(x,y) [1 x y] * W(:,i) , XX, YY );
    surf(XX,YY,ZZ)
    alpha(0.5)
    
end
