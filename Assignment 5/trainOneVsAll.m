function W = trainOneVsAll( X, y, C )

    % << IMPLEMENT FUNCTION BODY. SOME USUAL MAJOR STEPS ARE GIVEN IN THE COMMENTS BELOW >>

    % Initialize variables
    lambda=1e-3
    Xp=[ones(size(X,1),1) X];
    % Perform One-vs-All: Train each class against all the others one by one
    for i = 1:C
        
        % Form the two-class problem
        y_copy=y;
        y_copy(y==(i-1))=1;
        y_copy(y~=(i-1))=-1;
        y_copy
       
        
        % Use trainPerceptron on the two-class problem
        [w , cost_history, w_history] = trainPerceptron(X,y_copy,lambda);
        % Store the best weight
        W(i,:) = w; % pick the best weight here
        
    end

    % Normalize weights
    W_c = W(:,2:end);
    n = vecnorm(W_c,2,2);
    W=bsxfun(@rdivide,W,n(:));
    
end
