function [gw, w, g_history, w_history] = gradientDescentAD(g, w0, alpha, max_iter,X,y)
    
    % Initial point and the function value at it. These are the estimates of the minimum, updated at each iteration.
    % just like in the previous function
    w=dlarray(w0);
    alpha = dlarray(alpha);
    gw = dlarray(g(w0));
  
    % Initialize search history, if requested
    if nargout > 2
        w_history = [w];
        g_history = [gw];
    end

     h=@(x) wrapper(g,x);
    
    % Perform coordinate descent
    for i = 1:max_iter
        
        w_old=w; % save w^(k-1) in w_old
        [fval,gradval]=dlfeval(h,w_old); % compute the gradient

        w=w_old-alpha*gradval; % apply the method's formula, gradval is evaluated in w0
        w=w./sqrt(sum(w.^2)); % normalizing w
        gw=g(w); % evaluate the function in the new point found
                
        if nargout > 2  % Store history if requested           
            g_history = [g_history; gw]; % save the found values in the history
            w_history = [w_history; w];
        end
    end

    w_history=extractdata(w_history);
    g_history=extractdata(g_history);
    gw=extractdata(gw);
    w=extractdata(w);
end
