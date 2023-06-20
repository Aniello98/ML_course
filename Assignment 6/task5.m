clc 
clear all
close all

% Load data
A = load('boston_housing.csv');

% Extract features and normalize them
X = A(1:end-1,:)';
X = normalize(X);

% Extract output variable and normalize it
y = A(end,:)';
y = normalize(y);

% Number of boosting rounds
M = 5;

[selected, w_selected, cost_history] = boostedFeatureSelection(X,y,M);



% Plot the result (not mandatory, but beneficial)
figure

subplot(211)
plot( 0:M, cost_history )
xticks( 0:M )
xticklabels( selected - 1 )
xlim([-0.5 M+0.5])
ylim([0 1.1*max(cost_history)])
title('LS cost at each round of boosting')
xlabel('Selected feature')


subplot(212)
bar( 0:M, w_selected )
xticks( 0:M )
xticklabels( selected - 1 )
xlim([-0.5 M+0.5])
ylim([min(w_selected)-0.1 max(w_selected)+0.1])
title('Weight values learnt by boosting')
xlabel('Selected feature')
