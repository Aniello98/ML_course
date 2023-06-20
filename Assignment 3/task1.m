close all 
clear all 
clc

% Load the data from 'regression_outliers.csv' using the load function
A = load('regression_outliers.csv');
N=size(A,1)-1 %number of input variables
x=A(1,:)
y=A(2,:)
X=ones(length(x),N+1)
X(:,2)=x'


% Load the weights from 'problem1.mat' using the load function
w_LAD=load('problem1.mat','w_LAD').w_LAD
w_LS=load('problem1.mat','w_LS').w_LS
p=length(x)

% % Construct the Least Squares cost function
cost_LS = @(w) (1/p)*sum((X*w-y').^2)  % Complete the anonymous function

% 
% % Construct the Least Absolute Deviations cost function
cost_LAD = @(w) (1/p)*sum(abs(X*w-y'))% Complete the anonymous function
% 
% % Compute the LS cost on weights w_LS and w_LAD
cost_LS_wLS = cost_LS(w_LS)  % Evaluate cost_LS at w_LS
cost_LS_wLAD = cost_LS(w_LAD) % Evaluate cost_LS at w_LAD

% 
% % Compute the LAD cost on weights w_LS and w_LAD
cost_LAD_wLS = cost_LAD(w_LS) % Evaluate cost_LAD at w_LS
cost_LAD_wLAD = cost_LAD(w_LAD)% Evaluate cost_LAD at w_LAD
% 
% % Create 100 evenly spaced grid of points between -2 and 2 (inclusive) for model evaluation and plotting. Create a column vector
x = linspace(-2,2,100)' % [-2.0000;   -1.9596;   -1.9192; ...; 2.0000]
X=ones(length(x),2)
X(:,2)=x
%     
% % Evaluate the LS model at x, i.e. use w_LS to calculate output at the points in x. Create a column vector of results
y_LS = X*w_LS
% 
% % Evaluate the LAD model at x, i.e. use w_LAD to calculate output at the points in x.  Create a column vector of results
y_LAD = X*w_LAD
 
 % Plot the result
 figure
 scatter( A(1,:), A(2,:) )
 hold on
 plot( x, y_LS )
 plot( x, y_LAD, '--' )
 legend('data','Least Squares', 'Least Absolute Deviations','Location','NorthWest')
 axis([-2 2 -5 12 ])
 xlabel('x')
 ylabel('y')



