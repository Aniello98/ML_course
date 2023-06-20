close all
clear all
clc

% Load the data from the file named '5class_data.csv'
A = load('5class_data.csv');

% Form the feature matrix starting from the first row upto second last
X = A(1:end-1,:)';

% Form the class column vector from the last row in the data
y = A(end,:)';

% Number of classes
C = 5;

% Call the training function
W = trainMultiClassSoftmax(X,y,C)

% This function is the one implemented in the first problem
c = classifyMultiClass( W, X );

accuracy = 100 * sum( c==y ) / length(c)

figure
scatter( X(:,1), X(:,2), 25, y, 'filled' )
hold on
scatter( X(:,1), X(:,2), 60, c )
axis([0 1 0 1])
xlabel('x_1')
ylabel('x_2')
title( sprintf('Classification accuracy %.2f %%', accuracy ) )
