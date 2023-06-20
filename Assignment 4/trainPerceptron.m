function w = trainPerceptron(X,y)

    % << IMPLEMENT THE FUNCTION BODY! SAMPLE SOLUTION STRUCTURE SHOWN IN THE COMMENTS BELOW. >>

    [P,N] = size(X);
    aug_X=[ones(size(X,1),1) X];

    % Initialize variables and set up the problem: initial parameters, cost function etc.

    w0=ones(1,N+1);
    alpha=2e-2; 
    max_iter=4000;
    lambda=0.02;

    w0=w0./norm(w0);

    g=@(w) costFun(w,X,y,lambda);

    % Solve the problem using gradientDescentAD
    [gw,w,g_history,w_history]= gradientDescentAD(g,w0,alpha,max_iter);

    [g_min,idx]=min(g_history);
    g_min
    w=w_history(idx,:)
    % If necessary, define nested helper functions below


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
    plot( w_history )
    title('w history', 'r' )
    xlabel('Iteration number')
    ylabel('Parameter value')

end


% If necessary, define local helper functions below

function g=costFun(w,X,y,lambda)
    P=size(X,1);
    aug_X=[ones(size(X,1),1) X];
    
    
    E= exp(-y.*(aug_X*w'));
    cost_term=1/P*(sum(log(1+E)));
%     w=extractdata(w);
%     reg_term=lambda*norm(w')^2;
%     reg_term=dlarray(reg_term);
    g=cost_term%+reg_term
    
end