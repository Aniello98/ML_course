close all
clear all
clc

% Load the data
load('problem4.mat')

% Set up a range of lambda values
LAMBDAS = 10.^(-3:.25:-1.25);

% Find the best model across LAMBDAS
[ W, best_lambda_ind ] = regularizedL1CrossValidation( y_noisy, y_validate, LAMBDAS );

best_lambda_ind %has to be 5


% Plot the result (not mandatory, but beneficial)
figure

subplot(211)
plot( x, y_true )
hold on;
plot( x, y_noisy, 'x' )
plot( x, y_validate, 'd')
plot( x, W' )
title('All the models')

subplot(212)
plot( x, y_true )
hold on;
plot( x, y_noisy, 'x' )
plot( x, y_validate, 'd')
plot( x, W(best_lambda_ind,:)', 'LineWidth', 3 )
title('The selected model')
