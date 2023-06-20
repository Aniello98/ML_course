clc
clear all
close all

% The function to be minimized
f = @(w) w(:,1).^2 + w(:,2).^2 + 2;

% Starting point for the descent
x0 = [3 4];


% Upper limit of iterations
MAX_ITER = 10;

% Call the coordinateSearch function
[g_min, w_min, g_history, w_history] = coordinateSearch( f, x0, MAX_ITER )

% Plot the result (not mandatory, but beneficial)
figure
plot( g_history )
title('Cost history')
xlabel('Iteration number')
ylabel('Cost (g(w))')