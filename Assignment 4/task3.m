clear all
close all
clc

% Load X and y from 'spambase_data.mat'
A = load('spambase_data.mat');

X=A.X;
y=A.y;

% Call your training function
w = trainPerceptronNormalized(X,y);

P=size(X,1);

y_test=[ones(size(X,1),1) X]*w';

y_test(y_test>=0)=1;
y_test(y_test<0)=-1;

misclassifications=P-sum(y_test==y)

accuracy=1-misclassifications/P