function [gw, w, g_history, w_history] = gradientDescentAD_ADS( g, w0, alpha, max_iter )


    % Dimension of the problem
    N = size(w0,2);

    % Initial point and the function value at it. These are the estimates of the minimum, updated at each iteration.
    w0=normalize(w0)
    dlw = dlarray(w0);% << SET TO INITIAL POINT >>
    h= @(x) wrapper(g,x);
    gradval_mtx=[];

    for i = 1:size(w0,1)
        [gval,gradval] = dlfeval(h,dlw(i,:));
        gw = extractdata(gval);% << COMPUTE g AT THE INITIAL POINT >>
        w=extractdata(dlw);
        gradval_mtx=[gradval_mtx ; gradval];
    
        %nargout is a global variable which corresponds to the number of
        %argument in output, it is already initialized in the grader
        
    
        % Initialize search history, if requested
        if nargout > 2
            w_history = [w];
            g_history = [gw];
        end
        
    end
    
    
    % Perform gradient descent
    for i = 1:max_iter
        
        dlw=dlw-alpha.*gradval_mtx;
        %dlw=dlw-alpha*gradval;
            gradval_mtx=[];
        for i = 1:size(w0,1)
            
            [gval,gradval] = dlfeval(h,dlw(i,:));
            gw = extractdata(gval);% << COMPUTE g AT THE INITIAL POINT >>
            w=extractdata(dlw);
            gradval_mtx=[gradval_mtx ; gradval];
            
            if nargout > 2  % Store history if requested    
            
            g_history = [g_history; gw];
            w_history = [w_history; w];
            end
          
        end
        
        
%         [gval,gradval] = dlfeval(h,dlw);
%         gw = extractdata(gval);% << COMPUTE g AT THE INITIAL POINT >>
%         w=extractdata(dlw);


        
%         if nargout > 2  % Store history if requested    
%             
%             g_history = [g_history; gw];
%             w_history = [w_history; w];
%         end
        
    end
    
    w=w_history(end-(size(w0,1)-1):end,:);
    gw=g_history(end-(size(w0,1)-1):end,:);
end


function [fval,gradval]=wrapper(f,x)

    fval=f(x);
    gradval = dlgradient(fval,x);
    
end


function w_norm = normalize(W)

    % Normalize weights
    W_c = W(:,2:end);
    n = vecnorm(W_c,2,2);
    w_norm=bsxfun(@rdivide,W,n(:));

end
