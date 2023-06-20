% Load the data
A = load('credit_dataset.csv');

% Features are on the rows; upto the second last
X = A(1:end-1,:)';

% Normalize the data for learning
X = normalize(X);

% Class label is on the last row
y = A(end,:)';

% The set of regularization parameters to test
LAMBDAS = [0 0.01 0.02 .04]';
alphas= linspace(0.8,10,50)

% Perform l1-regularized softMax training
[W, cost_history, alpha_opt] = searchAlgorithm_Ass6(X,y,alphas)


% Plot the result (not mandatory, but beneficial)
N = size(X,2);          % Number of features
L = length(LAMBDAS);    % Number of lambdas
h = [];
figure
for i = 1:L
    h(i) = subplot(L,1,i);
    bar( 0:N, W(i,:) )
    xticks( 0:N+1 )
    title( sprintf('Weight values at lambda %.2f', LAMBDAS(i)), sprintf('Cost = %.2f', cost_history(i) ) )
end
linkaxes(h)