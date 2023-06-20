close all
clear all
clc

% Load the data from the file '2d_classification_data_v1_entropy.csv' using the load function
A = load("2d_classification_data_v1_entropy.csv")

% Initialize problem variables using the matrix A
P = size(A,2);            % Number of samples
x = A(1,:)';            % Sample x-values as a column vector
y = A(2,:)';            % Sample y-values (the class 0 or 1) as a column vector

% x_test=[1 2; 3 5]; %NxP
% y_test=[0 0];
% w_test=[1 1 1];
% P_test=2;
% N_test=2;
% x=x_test;
% y=y_test;
% P=P_test;
% Define the step function, for t=0 return 1. Return value in the same data type as t or a double
step = @stepFun;            % IMPLEMENT THE ANONONYMOUS FUNCTION
% step(x)
% pause
% Define the step model function using the step function
model_step = @modelStep;     % IMPLEMENT THE ANONONYMOUS FUNCTION

% model_step(x_test,w_test)
% pause
% Define the step cost function using the model_step
cost_step_LS = @(w) cost_step_LS_Fun(w,x,y,P)';    % IMPLEMENT THE ANONONYMOUS FUNCTION

% cost_step_LS(w_test)
% pause
% Define the sigmoid function
sigmoid = @(x) sigmoidFun(x);         % IMPLEMENT THE ANONONYMOUS FUNCTION
% sigmoid(x_test)
% pause
%sigmoid=sigmoid([2; 2])

% Define the Logistic regression model using sigmoid function
model_logit = @(x,w) modelLogit(x,w)    % IMPLEMENT THE ANONONYMOUS FUNCTION

%model_logit([2 2],[2 2])

% Define the Logistic regression Least Squares cost function
cost_logit_LS = @(w) 1/P*sum((model_logit(x,w)-y).^2)';   % IMPLEMENT THE ANONONYMOUS FUNCTION
%res=model_logit(x,[2 2])-y'
%cost_logit_LS=cost_logit_LS([2 2])

% Define the Logistic regression Cross-Entropy cost function
cost_logit_CE = @(w) -1/P*sum((y.*log(model_logit(x,w))+(1-y).*log(1-model_logit(x,w))))';   % IMPLEMENT THE ANONONYMOUS FUNCTION

% log(model_logit(x,[2 2]))
% cost_logit_CE=cost_logit_CE([2 2])


% Plot the result (not mandatory, but beneficial)

% Initialíze a regular rectangular 2D grid of points to evaluate the cost functions on
% Create 100 equidistantly spaced samples from -20 to +20 (limits inclusive)
w_range = linspace(-20,20,100);
% Use 'w_range' to construct a 2D mesh using the meshgrid function
[XX,YY] = meshgrid( w_range );

% (Almost) optimally picked weights
w_opt = [ -10.38 10.03 ];
% (Clearly) unoptimally picked weights
w_unopt = [ -1.5 2 ];
% Range of x-values from -1 to 6; to evaluate the model outputs
x_range = linspace(-1,6,100)';

% Plot data together with both the optimal and unoptimal step and logit models 
figure
scatter( A(1,:), A(2,:) )
axis([-1 5 -1 2])
hold on
plot( x_range, model_step( x_range, w_opt ) )
plot( x_range, model_logit( x_range, w_opt ) )
plot( x_range, model_step( x_range, w_unopt ), '--' )
plot( x_range, model_logit( x_range, w_unopt ), '--' )
xlabel('x')
legend('Data', 'Step opt.', 'Logit opt.', 'Step unopt.', 'Logit unopt.' )
title('Classification regression problem')

% Plot the cost function surfaces in 3D
cost_functions = { cost_step_LS, cost_logit_LS, cost_logit_CE };
cost_function_names = { 'Step LS cost', 'Logit LS cost', 'Logit CE cost' };
M = length( cost_functions );
v = [-152 42];
figure
for i = 1:M
    subplot(M,1,i)
    surface(XX,YY, arrayfun( @(x,y) cost_functions{i}( [x y] ), XX, YY ) )
    view(v)
    xlabel('w_0')
    ylabel('w_1')
	zlabel('cost')
    title( cost_function_names{i} )
end

function step = stepFun(x)
    step=zeros(size(x));
    step(x>=0)=1;;
end

function modelstep= modelStep(x,w)
    
    F=[ones(size(x,1),1) x]
    F=F*w'
    modelstep= stepFun(F);

end

function sigmoid=sigmoidFun(x)
    E=exp(-x);
    den=ones(size(x))+E;
    sigmoid=1./den;
end

function model_logit = modelLogit(x,w)
    L=[ones(size(x,1),1) x];
    L=L*w';
    model_logit=sigmoidFun(L);

end

function cost= cost_step_LS_Fun(w,x,y,P)
    diff=modelStep(x,w)-y
    diff_squared=diff.^2
    somma=sum(diff_squared)
    cost=1/P*somma
    %1/P*sum((model_step(x,w)-y').^2)'
end
