clear all
close all
clc

% Load the data set
A = load('breast_cancer_data.csv');

% Form the feature matrix. The first 8 rows in the data set are features.
X = A(1:end-1,:)';

% Form the class label vector. The last row in the data set is the class.
y = A(end,:)';

% Call your training function
w = trainPerceptron(X,y);


P=size(X,1);

y_test=[ones(size(X,1),1) X]*w';

y_test(y_test>=0)=1;
y_test(y_test<0)=-1;

misclassifications=P-sum(y_test==y)



