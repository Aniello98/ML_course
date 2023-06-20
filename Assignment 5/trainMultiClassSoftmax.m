function W = trainMultiClassSoftmax(X,y,C)

    N=size(X,2); %should be 2
    P=size(X,1); %should be 30
    % << COMPLETE THE FUNCTION BODY! TYPICAL SOLUTION STEPS ARE GIVEN IN COMMENTS. >>

    rng(32);
    %w0=initializeGlorot([1 C*(N+1)],1,N+1)
    w0=rand(1,C*(N+1))
    alpha=2e-1;
    max_iter = 2000;

    % Initialize variables
    g=@(w) cost_softmax(w);
    
    % Perform gradient descent on the cost_softmax function

    [gw, w, g_history, w_history] = gradientDescentAD(g, w0, alpha, max_iter)

    plot(g_history)
       
    % Return the best weight vector but in matrix form

    W=[];
    W=reshape(w,C,N+1);
        
   
 
    
    % Nested cost function
    function c = cost_softmax(w)

        Xp=[ones(size(X,1),1) X];
        Wc=[];
        Wc=reshape(w,C,N+1);

        esponente = Xp * Wc';
        term= exp(esponente);
        part1= sum(term,2);
        part1=log(part1);
        

        
        Xw_yp=ones(P,1);
        Xw_yp = Xp .* Wc(y+1,:);
        Xw_yp = sum(Xw_yp,2);
        


        % Evaluate the Multi-Class Perceptron cost
        c = 1/P* sum( part1 - Xw_yp );

    end

end
