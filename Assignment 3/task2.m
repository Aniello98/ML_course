clear all
close all
clc

% Load the data set into matrix A from 'student_debt_data.csv' using the load function
A = load('student_debt_data.csv')

% Construct the design matrix X with augmented ones
N=size(A,2)-1 %number of input variables
x=A(:,1:N)
X=ones(length(x),N+1)
X(:,2:N+1)=x'
p=length(x)


% Construct the expected outcome vector y
y=A(:,N+1)

% Solve the weights using Pseudoinverse
X_inv = pinv(X)
w = X_inv*y %[-1.607290452536108e+02;0.080324417472089]

% Use the model to extrapolate year 2030 debt
x2030=[1 2030]
y2030 = x2030*w
% 
% cost_LS = @(w) (1/p)*sum((X*w'-y).^2)
% cost_LS_wLS = cost_LS(w)
