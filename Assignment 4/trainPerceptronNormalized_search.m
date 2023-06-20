function [w,g_min] = trainPerceptronNormalized_search(X,y,alpha)

    [P ,N ] = size(X);
    % << IMPLEMENT THE FUNCTION BODY! SAMPLE SOLUTION STRUCTURE SHOWN IN THE COMMENTS BELOW. >>

    w0=ones(1,N+1);
    w0=w0./norm(w0);

    %alpha=10; 
    max_iter=300;

    X_ag=[ones(P,1) X];

    X_norm = normalize(X);
    % Initialize variables and set up the problem: initial parameters, cost function etc.
    g=@(w) softmaxCostFun(w,X_norm,y);
    

    % Solve the problem using gradientDescentAD
    [gw,w,g_history,w_history]= gradientDescentAD(g,w0,alpha,max_iter);

    [g_min,idx]=min(g_history);
    g_min
    w=w_history(idx,:)
% 
%     figure
%     subplot(211)
%     plot( g_history )
%     title('Cost history', 'r' )
%     xlabel('Iteration number')
%     ylabel('Cost (g(w))')
%     set(gca, 'XScale', 'log')
%     set(gca, 'YScale', 'log')
%     
%     subplot(212)
%     plot( w_history )
%     title('w history', 'r' )
%     xlabel('Iteration number')
%     ylabel('Parameter value')
    
    % If necessary, define nested helper functions below

end

% If necessary, define local helper functions below
