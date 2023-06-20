% The main function to do the non-linear fitting
function [theta, cost_history, theta_history] = fitSingleOutputRegression( X, y, theta0, alpha, max_iter )

    % << IMPLEMENT THE FUNCTION BODY! TYPICAL STEPS ARE GIVEN IN COMMENTS BELOW >>
    
    p=size(X,1);
    % Initialize variables
    

    g=@(theta) (1/p)*sum((model(X,theta)-y).^2);
    % Solve the weights using GD with AD, call [...] = gradientDescentAD(...)

    [gw, theta, cost_history, theta_history] = gradientDescentAD( g, theta0, alpha, max_iter );
    [gw,i]=min(cost_history)
    gw
    %cost_history
    last_theta=theta
    theta=theta_history(i,:)

    function c = cost(theta)
         c = (1/p) * sum((model(X,theta)-y).^2)
     end
   

    

    % Return the best solution, and the histories
    
    % This function computes the least squares cost function
    % NOTE: As a nested function, it can use X and y directly and needs only the parameter vector theta
%     function c = cost(theta)
%         c = % << IMPLEMENT using the model function! >>
%     end

end % End of function fitSingleOutputRegression

% Local helper functions below

% This function transforms the features x non-linearly using the parameters v
function z = feature_transform( x, v )
    t=ones(length(x),2);
    t(:,2)=x';
    z= sin(t*v');
    
end

% This function applies the model specified by the parameters theta to the data x
function y = model(x, theta)
    v=[theta(1) theta(2)];
    w=[theta(3) theta(4)];
    
    f=feature_transform(x,v);
    F1=ones(length(x),2);  %not a dl array!
    F1(:,2)=f;
    F1
    pause

    F=[ones(length(x),1) f];  %this is a dl array!
    F
    pause
    
   
    y=F*w';
end
