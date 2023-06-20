function [ W, best_lambda_ind ] = regularizedL1CrossValidation( y_train, y_validate, lambdas )

    N=size(y_train,2);
    L=size(lambdas,2);

    % Initialize variables
    W=zeros(L,N);
    cost_history=zeros(L,1);

    % Go through all the lambdas, using parfor for speed instead of for
    parfor i = 1:L
        % Train the model with ith value in lambdas and store weights into correct row of W
        [W(i,:), cost_history(i)] = regularizedL1Fitting( y_train, lambdas(i) );
    end

    % Determine the best crossvalidation cost and select that model:
    % Compare each model to y_validate in LS cost sense and select least value one
    
    costs = 1/N* sum((W-y_validate).^2,2);
    
    % Return the index of the best lambda in lambdas as best_lambda_ind
    [c_min, best_lambda_ind] = min(costs);

    c_min
    
end

function [w, cost] = regularizedL1Fitting(y_train, lambda)
    
    N=size(y_train,2);

    % Use output value y as a starting point
    w0 = y_train;

    % Initialize other parameters
    
    % Step size
    ALPHA = 0.1; % Determine suitable value for fast convergence
    
    % Upper limit on iterations
    MAX_ITER = 1000; % Determine suitable value, keep it low enough

    g=@(w) costfun(w);
   
    
    % Perform gradient descent
    [~, ~, g_history, w_history]= gradientDescentAD(g,w0, ALPHA, MAX_ITER);
    

    [cost,idx]=min(g_history);

    cost = cost

    w=w_history(idx,:)

        
    % The cost function
    function c = costfun(w)
        
        %e=ones(N,1);
        D2 = [eye(N-2) zeros(N-2,2)] -2*[zeros(N-2,1) eye(N-2) zeros(N-2,1)] + [zeros(N-2,2) eye(N-2)];
        %D2 = spdiags([e -2*e e],[-1 0 1],N-2,N);
        
        % LS cost regularized with the L1 norm of Delta^2 w
        c = 1/N * (sum((w-y_train).^2) )+lambda * sum(abs(D2 * w')); % Compute
        
    end

end
