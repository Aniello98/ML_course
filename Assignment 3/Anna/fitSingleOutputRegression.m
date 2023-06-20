% The main function to do the non-linear fitting
function [theta, cost_history, theta_history] = fitSingleOutputRegression( X, y, theta0, alpha, max_iter )

    % Initialize variables
    P=size(X,1);
    g=@(theta) (1/P)*sum((model(X,theta)-y).^2);

    % Solve the weights using GD with AD, call [...] = gradientDescentAD(...)
    [gw, w, cost_history, theta_history] = gradientDescentAD(g, theta0, alpha, max_iter);
    % Return the best solution, and the histories
    [~, idx]=min(cost_history);
    theta=theta_history(idx,:);

    % This function computes the least squares cost function
    % NOTE: As a nested function, it can use X and y directly and needs only the parameter vector theta
     function c = cost(theta)
         c = (1/P) * sum((model(X,theta)-yp').^2)
     end
 
end