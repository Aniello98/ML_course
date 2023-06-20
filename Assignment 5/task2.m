clear all
close all
clc

% Load the data set from the file '3class_data.csv'
A = load('3class_data.csv');

% Form the feature matrix starting from the first row upto second last
X = A(1:end-1,:)';

% Form the class column vector from the last row in the data
y = A(end,:)';

% Number of classes
C = 3;

% Call the training function
W = trainOneVsAll( X, y, C )
