function [ w, c, W, C ] = fitKFoldPolynomial( x, y, K, M )
    
    % Initialize variables 
    C=zeros(M+1,K);
    W=zeros(M+1,M+1,K);
    P = size(x,1);
    
    % For all folds
    for k = 1:K
        x_val = [];
        x_train = [];
        y_val = [];
        y_train = [];
        
        % Select the fold data: validation and training
        
        if k==K
            x_val=x((k-1) * floor(P/K)+1 : end);
            x_train=x(1 : (k-1) * floor(P/K) );

            y_val=y((k-1) * floor(P/K)+1 : end);
            y_train=y(1 : (k-1) * floor(P/K) );
        else
            x_val=x((k-1) * floor(P/K)+1 : k*floor(P/K));
            y_val=y((k-1) * floor(P/K)+1 : k*floor(P/K));

            if k==1
                x_train = x(k*floor(P/K) + 1 : end);
                y_train = y(k*floor(P/K) + 1 : end);
            else
                x_train = [x(1 : (k-1)*floor(P/K)); x( k*floor(P/K)+1 :end)];
                y_train = [y(1 : (k-1)*floor(P/K)); y( k*floor(P/K)+1 :end)];
            end
            
        end
        

        % For all polynomial orders
        for m = 0:M


            % Train polynomial model on the training data

            
            d_X_train= featureTransform(x_train,m);
            pinv_X_train = pinv(d_X_train);
            w_opt=pinv_X_train*y_train;

            % Calculate LS cost of the trained model on the validation data

            Pc=size(x_val,1);
            d_X_val= featureTransform(x_val,m);
            cost_val = 1/Pc* sum((d_X_val*w_opt - y_val).^2);
            
            % Store weights and costs
            C(m+1,k) = cost_val;
            W_row= zeros(1,M+1);
            W_row(1,1:length(w_opt))=w_opt;
            W(m+1,:,k) = W_row;
            
            
        end

        
    end
    
  
    
    % Calculate average cost over folds taking into account last fold size
    avg_w = zeros(K,1) + floor(P/K)/P;
    avg_w(K) = size(x_val,1)/P;
    avg_C = C*avg_w;
    
    % Choose the polynomial order with least average LS cost
    
    [~,idx] = min(avg_C);
    best_order = idx-1;
    
    % Retrain model with all data, and evaluate the cost

    Pc=size(x,1);
    d_X= featureTransform(x,best_order)
    pinv_X = pinv(d_X)
    
    w_opt=pinv_X*y

    c = 1/Pc* sum((d_X*w_opt - y).^2);
    
    w=w_opt'
  

    
end



