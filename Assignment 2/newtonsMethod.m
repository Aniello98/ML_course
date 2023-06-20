function [gw, w, g_history, w_history] = newtonsMethod(g, g_grad, g_hessian, w0, max_iter, epsilon )

   
    % Dimension of the problem
    N = size(w0,2);

    % Initial point and the function value at it. These are the estimates of the minimum, updated at each iteration.
    w = w0;% << SET TO INITIAL POINT >>
    gw = g(w0);% << COMPUTE g AT THE INITIAL POINT >>
    
    %nargout is a global variable which corresponds to the number of
    %argument in output, it is already initialized in the grader
    nargout=4;
    I=eye(N);

    % Initialize search history, if requested
    if nargout > 2
        w_history = [w];
        g_history = [gw];
    end
    
    % Perform gradient descent
    for i = 1:max_iter
        g_hessian(w)
        g_grad(w)
        den=g_hessian(w)+epsilon*I
        d=linsolve(den, g_grad(w)')
        
        w=w-d'

        gw=g(w);

        
        if nargout > 2  % Store history if requested    
            
            g_history = [g_history; gw];
            w_history = [w_history; w];
        end
        
    end
    
    
end
