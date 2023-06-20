function [W, cost_history] = regularizedFeatureSelection(X,y,lambdas)

    % Initialize variables
    W=[];
    cost_history=[];
    
    % Number of regularization parameters lambda to test
    L = length( lambdas );
    
    % Go through all the lambdas
    for i = 1:L

        % Call the local function
        lambdas(i)
        [w, g_min] = trainPerceptron1(X,y,lambdas(i));

        W=[W ; w];
        cost_history = [cost_history; g_min];
        
    end
    
end




