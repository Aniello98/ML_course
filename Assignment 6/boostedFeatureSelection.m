function [selected, w_selected, cost_history] = boostedFeatureSelection(X,y,M)

    % << IMPLEMENT THE FUNCTION BODY >>
    
    % Initialize variables
    P = size(X,1);
    N = size(X,2);
    X_train = [ones(P,1) X];
    % Initially select only the bias and solve the corresponding weight
    res = y;
    x_m = ones(P,1);
    %x_inv = pinv(x);
    bias = x_m\res;
    %bias = x_inv*y
    selected = [1];
    w_selected = [bias];
    cost = 1/P* sum((x_m*w_selected - y).^2);
    cost_history = [cost];
    
    
    % Perform M rounds of boosting
    for i = 1:M
        
        % Form the residual for the previous round model
        x_m = X_train(:, selected);
        res = computeResidual(x_m, y, w_selected);
        boosting_cost = inf*ones(1,N+1);
        boosting_w = zeros(1,N+1);
        
        % Compare all unselected feature candidates one-by-one:
            % Fit it to residual to determine the optimal weight, and the resulting cost
        for j = 1:N+1
            
            if isempty(selected(selected==j))
                x = X_train(:,j);
                w_temp = x\res;
                boosting_cost(j) = 1/P* sum((x*w_temp - res).^2);
                boosting_w(j) = w_temp;
            end

        end
        
        % After going through all the candidates:
        
            % Find and select the best from candidates
            [best,idx] = min(boosting_cost);
            % Store the cost of the selected
            cost_history = [cost_history ; best];
            % Store the weight for the selected
            selected = [selected; idx];
            w_selected = [w_selected; boosting_w(idx)];
            
        
    end 




    end