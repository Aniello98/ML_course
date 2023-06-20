close all
clear all
clc

% Load data
A = load('galileo_ramp_data.csv');

% The first row contains the x-values
x = A(1,:)';

% The second row contains the y-values
y = A(2,:)';

% Number of folds
K = 6;

% Test polynomials upto order
M = 6;

% Call your function
[ w, c, W, C ] = fitKFoldPolynomial( x, y, K, M )
