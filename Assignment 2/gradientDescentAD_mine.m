function [gw, w_min, g_history, w_history] = gradientDescentAD_mine( g, w0, alpha, max_iter )


    % Initial point and the function value at it. These are the estimates of the minimum, updated at each iteration.
    w_history=[];
    g_history=[];
    w0=normalize(w0);
    dlw0=dlarray(w0);
    % << SET TO INITIAL POINT >>
    alpha=dlarray(alpha);
    gw = dlarray(g(w0));

    h= @(x) wrapper(g,x);

    if nargout > 2
        w_history = [dlw0];
        g_history = [gw];
    end

%     [gval,gradval] = dlfeval(h,dlw);
%     gw = extractdata(gval);% << COMPUTE g AT THE INITIAL POINT >>
%     w=extractdata(dlw);

    %nargout is a global variable which corresponds to the number of
    %argument in output, it is already initialized in the grader
    

%     % Initialize search history, if requested
%     if nargout > 2
%         w_history = [dlw0];
%         g_history = [gw];
%     end

    dlw=dlw0;

    % Perform gradient descent
    for i = 1:max_iter
        
        dlw_old=dlw;
        [gval,gradval] = dlfeval(h,dlw_old)

        dlw=dlw_old-alpha*gradval;

        %normalize dlw
%         w=extractdata(dlw);
%         w_norm=normalize(w)
%         dlw=dlarray(w_norm);

        gw=g(dlw)
        

        if nargout > 2  % Store history if requested    
            
            g_history = [g_history; gw];
            w_history = [w_history; dlw];

        end
        
        
    end


    g_history=extractdata(g_history);
    w_history=extractdata(w_history);
    w_min=w_history(end-(size(w0,1)-1):end,:);
    gw=g_history(end-(size(w0,1)-1):end,:);
    
end

function w_norm = normalize(W)

    % Normalize weights
    W_c = W(:,2:end);
    n = vecnorm(W_c,2,2);
    w_norm=bsxfun(@rdivide,W,n(:));

end