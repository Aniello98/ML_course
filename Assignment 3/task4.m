clear all
close all
clc

% Load the data set
A = load('noisy_sin_sample.csv');

% Step size
ALPHA = 1e-1;


% Upper limit of iterations
MAX_ITER = 2000;

% Initial point
theta0 = [2 -4 1 2];

[theta, cost_history, theta_history] = fitSingleOutputRegression( A(:,1), A(:,2), theta0, ALPHA, MAX_ITER  );

%Plot the result (not mandatory, but beneficial)
figure
subplot(211)
plot( cost_history )
title('Cost history', 'r' )
xlabel('Iteration number')
ylabel('Cost (g(w))')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')

subplot(212)
plot( theta_history )
title('Theta history', 'r' )
xlabel('Iteration number')
ylabel('Parameter value')

