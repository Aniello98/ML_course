clc
clear all
close all

% Load the data set
A = load('diagonal_stripes.csv');

% The features are on the first two rows
X = A(1:end-1,:)';

% The class labels are on the last row
y = A(end,:)';
% A handle to the model function for Grader tests
modelFun = @model;

K=5;

% Set Gradient Decent AD parameters
theta0 = ones(1,K);
ALPHA = 5e-2;        % << Set the step size >>
MAX_ITER = 3000;     % << Set limit on number of iterations >>
LAMBDA = 1e-3;       % << Set a suitable regularization parameter >>

% Call the training function that uses GD AD on the nonlinearized and regularized Softmax cost
[theta, cost_history, theta_history] = trainPerceptronNonlinear(X, y, @model, theta0, ALPHA, MAX_ITER, LAMBDA);

% Do classification and compute the accuracy percentage
c = classify(X, theta, @model);
accuracy = 100 * sum( c==y ) / length(c);

% Plot the result (not mandatory, but beneficial)
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

figure
scatter( X(:,1), X(:,2), 25, y, 'filled' )
hold on
scatter( X(:,1), X(:,2), 60, c )
xlabel('x_1')
ylabel('x_2')
title( sprintf('Classification accuracy = %.2f %%', accuracy ))
legend('true class', 'predicted class')


% << FUNCTIONS TO BE DEFINED BY YOU >>
% The input matrix X contains the feature values in the original space. Samples on rows, feature values on columns.
% The input row vector theta contains both the linear combination weights of the dot product, and the internal parameters of the feature transform
% The output column vector y contains the model output for each row of X, i.e. the dot product of the nonlinearly transformed features
function y = model(X, theta)
    N=size(X,2);
    P=size(X,1);
    v = theta(end-N:end);
    w= theta(1:end-N-1);
    aug_F= [ones(P,1) feature_transform(X, v)];
    y = aug_F * w';% << Compute the nonlinear model output. Use the nonlinearly transformed features in the linear dot product >>
    
end
% The model function that maps the original features into transformed features, it is used by the model function
% The input matrix X contains the feature values in the original space. Samples on rows, feature values on columns.
% The input row vector v is a part of the theta vector you pass here as internal parameters of the transformation
% The output matrix F contains the feature values in the transformed space. Samples on rows, feature values on columns.
function F = feature_transform( X, v )
    P=size(X,1);
    % << Compute the nonlinear features from original ones using parameters v to define the transformation properties >>
    t = [ones(P,1) X];
    F= sin(t*v');
end

