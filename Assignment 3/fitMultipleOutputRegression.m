function W = fitMultipleOutputRegression( X, Y )

    [P N] = size(X);
    C=size(Y,2);
    aug_X= [ones(P, 1) X];
    max_iter=100;
    alpha=0.05;
    w0=ones(1,N+1);
    w0=w0./norm(w0);
    

    
    % Solve subproblems separately in a loop
    for i = 1:C

        g = @(w) (1/P)*sum(abs(aug_X*w'-Y(:,i)));
        g(w0)
        
    
        % Use gradientDescentAD for the subproblem i
        [gmin, w, g_history, w_history] = gradientDescentAD(g, w0, alpha, max_iter);

        [g_min,idx]=min(g_history);
        g_min
        w=w_history(idx,:);
        
        % Store the result in the corresponding column of the output weight matrix
        G(:,i) = g_min;
        W(:,i) = w;
        
    end
    G
    % If necessary, define nested helper functions below

end

% If necessary, define local helper functions below


