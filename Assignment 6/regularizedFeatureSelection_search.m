function [W, cost_history] = regularizedFeatureSelection_search(X,y,lambdas,alpha)

    % Initialize variables
    W=[];
    cost_history=[];
    
    % Number of regularization parameters lambda to test
    L = length( lambdas );
    lambdas=0.04;
    
    % Go through all the lambdas
    for i = 1:L

        % Call the local function
        lambdas(i)
        [w, g_min] = trainPerceptron1_search(X,y,lambdas(i),alpha);

        W=[W ; w];
        cost_history = [cost_history; g_min];
        
    end
    
end




