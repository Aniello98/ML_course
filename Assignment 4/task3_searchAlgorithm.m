clear all
close all
clc

% Load X and y from 'spambase_data.mat'
A = load('spambase_data.mat');

X=A.X;
y=A.y;

alpha=linspace(0.0001,1,50); %alpha_opt=12.3

[w,gmin,alpha_opt]=searchAlgorithm(X,y,alpha)
% Call your training function




P=size(X,1);

y_test=[ones(size(X,1),1) X]*w';

y_test(y_test>=0)=1;
y_test(y_test<0)=-1;

misclassifications=P-sum(y_test==y)

accuracy=1-misclassifications/P