function W = trainMultiClassPerceptron(X,y,C)

    N=size(X,2); %should be 2
    P=size(X,1); %should be 30
    % << COMPLETE THE FUNCTION BODY! TYPICAL SOLUTION STEPS ARE GIVEN IN COMMENTS. >>

    rng(32);
    %w0=initializeGlorot([1 C*(N+1)],1,N+1)
    w0=rand(1,C*(N+1))
    alpha=2e-1;
    max_iter = 1000;
    g=@(w) cost_perceptron(w);

    %g(w_test);
    
    
    % Perform gradient descent on the cost_perceptron function
    
    [gw, w, g_history, w_history] = gradientDescentAD(g, w0, alpha, max_iter)

    plot(gw)
       
    % Return the best weight vector but in matrix form

    W=[];
    W=reshape(w,C,N+1);
 
    
    % Nested cost function
    function c = cost_perceptron(w)

        Xp=[ones(size(X,1),1) X];
        Wc=[];
        Wc=reshape(w,C,N+1);

        [max_x_w, ~]=classifyMultiClass(Wc,X);
        Xw_yp=ones(P,1);

%         for i = 1:P
%             Xw_yp(i)=Xp(i,:)*Wc(y(i)+1,:)';
%         end

        Xw_yp = Xp .* Wc(y+1,:);
        Xw_yp = sum(Xw_yp,2);
        
%         Xw_yp
%         max_x_w
%         w
%         Wc

        % Evaluate the Multi-Class Perceptron cost
        c = 1/P* sum( max_x_w - Xw_yp );

    end
    
   

end


function [MAX, c] = classifyMultiClass( W, X )

    % IMPLEMENT FUNCTION BODY
    Xp=[ones(size(X,1),1) X];

    temp=Xp*W';
    
    [MAX,argmax]=max(temp,[],2);
    
    c=argmax-1;
    
    
end

function [gw, w, g_history, w_history] = gradientDescentAD_ADS( g, w0, alpha, max_iter )


    % Dimension of the problem
    N = size(w0,2);

    %transform in matrix the wheights and normalize
    C=3;
    N=2;
    Wc=[];
    Wc=reshape(w0,C,N+1);
    Wc=normalize_ADS(Wc);
    w0=reshape(Wc,1,C*(N+1));

    % Initial point and the function value at it. These are the estimates of the minimum, updated at each iteration.
    %w0=normalize_ADS(w0)
    
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
        gradval_mtx;
        
        dlw=dlw-alpha.*(gradval_mtx);
        
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
        dlw=extractdata(dlw);
        
        %transform in matrix the wheights and normalize
        Wc=reshape(dlw,C,N+1);
        Wc=normalize_ADS(Wc);
        dlw=reshape(Wc,1,C*(N+1));
        %dlw=normalize_ADS(dlw);
        dlw=dlarray(dlw);
        
        
    end
    
    w=w_history(end-(size(w0,1)-1):end,:);
    gw=g_history(end-(size(w0,1)-1):end,:);
end


function [fval,gradval]=wrapper(f,x)

    fval=f(x)
    pause
    gradval = dlgradient(fval,x);
    
end


function w_norm = normalize_ADS(W)

    % Normalize weights
    W_c = W(:,2:end);
    n = vecnorm(W_c,2,2);
    w_norm=bsxfun(@rdivide,W,n(:));

end

function [gw, w, g_history, w_history] = normalized_gradientDescentAD(g, w0, alpha, max_iter)

    C=3;
    N=2;
    Wc=[];
%     Wc=reshape(w0,C,N+1);
%     Wc=normalize_ADS(Wc);
%     w0=reshape(Wc,1,C*(N+1));
    w0=normalize_ADS(w0);
    g_h=[];
    w_h=[];
    w=w0;
    for i=1:max_iter
        [gw, w, g_history, w_history] = gradientDescentAD(g, w, alpha, 1);
        g_h=[g_h ; g_history];
        w_h=[w_h ; w_history];
        
%         Wc=reshape(w,C,N+1);
%         Wc=normalize_ADS(Wc);
%         w=reshape(Wc,1,C*(N+1));
        w=normalize_ADS(w);
       
    end

    g_h
    w_h
end


function weights = initializeGlorot(sz,numOut,numIn)

Z = 2*rand(sz,'single') - 1;
bound = sqrt(6 / (numIn + numOut));

weights = bound * Z;

end
