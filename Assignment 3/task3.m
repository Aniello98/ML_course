clear all
close all
clc

% Load the data set from the file 'student_debt_data.csv'
A=load('student_debt_data.csv')
N=size(A,2)-1 
x=A(:,1:N)
X=ones(length(x),N+1)
X(:,2:N+1)=x'
y=A(:,N+1)
p=length(x)

% Construct the cost function
g = @(w) (1/p)*sum((X*w'-y).^2)' % << COMPLETE THE ANONYMOUS FUNCTION! >>

% Set the step size
ALPHA = 0.5e-7

% Set the upper limit of iterations
MAX_ITER = 500

% Set the starting point of iteration
w0 = [-15 20]

% Solve the weights using GD with AD
[gw, w, g_history, w_history] = gradientDescentAD( g, w0, ALPHA, MAX_ITER );

% Plot the result (not mandatory, but beneficial)
figure
subplot(211)
plot( g_history )
title('Cost history', 'r' )
xlabel('Iteration number')
ylabel('Cost (g(w))')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')

subplot(212)
f = @(x,y) g([x y]); 
fcontour(@(x,y) arrayfun(f,x,y), [-1000 1000 -100 100])
hold on
plot( w_history(:,1), w_history(:,2), 'r' )
xlabel('w_1')
ylabel('w_2')
title('Cost contour and weight history')

