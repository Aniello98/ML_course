clc
close all
clear all

% Load the data from the file named 'ellipse_2class_data.csv'
A = load('ellipse_2class_data.csv');

% Form the feature matrix from the first and second row of the data
X = A(1:2,:)';

% Form the class column vector from the last row in the data
y = A(3,:)';

% Call your training function
w = fitNonlinearSoftmax(X,y);