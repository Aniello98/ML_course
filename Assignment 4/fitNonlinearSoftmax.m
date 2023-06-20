function theta = fitNonlinearSoftmax( X, y )

   % << IMPLEMENT THE FUNCTION BODY! SAMPLE SOLUTION STRUCTURE SHOWN IN THE COMMENTS BELOW. >>

    [P,N] = size(X);

    % Initialize variables and set up the problem: initial parameters, cost function etc.

    theta0=ones(1,N+1);
    alpha=2e-2; 
    max_iter=4000;
    theta0=theta0./norm(theta0);

    g=@(theta) cost(theta);

    % Solve the problem using gradientDescentAD
    [gw,w,g_history,theta_history]= gradientDescentAD(g,theta0,alpha,max_iter);

    [g_min,idx]=min(g_history);
    g_min
    theta=theta_history(idx,:)

        %Plot the result (not mandatory, but beneficial)
    figure
    subplot(211)
    plot( g_history )
    title('Cost history', 'r' )
    xlabel('Iteration number')
    ylabel('Cost (g(w))')
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
    
    subplot(212)
    plot( theta_history )
    title('w history', 'r' )
    xlabel('Iteration number')
    ylabel('Parameter value')
    
    % This function computes the Softmax cost function on nonlinear model
    % NOTE: As a nested function, it can use X and y directly and needs only the parameter vector theta
    function c = cost(theta)
        E= exp(-y.*(model(X,theta)));
        c = 1/P*(sum(log(1+E)));
    end

end

% Local helper functions below

% This function transforms the features X non-linearly using the parameters v
function z = feature_transform( X, ~ )
    f=X.^2;
    z = [ones(size(X,1),1) f];
end

% This function applies the model specified by the parameters theta to the data X
function y = model(X, theta)
    N=size(X,2);
    P=size(X,1);
    w= theta;
    aug_F=  feature_transform(X);
    y = aug_F * w';% << Compute the nonlinear model output. Use the nonlinearly transformed features in the linear dot product >>
    
end
