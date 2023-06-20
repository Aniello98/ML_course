function g=softmaxCostFun_weighted(w,X,y,betas)
    P=size(X,1);
    aug_X=[ones(size(X,1),1) X];
    
    
    E= exp(-y.*(aug_X*w'));
    cost_term=1/P*(sum((betas .* log(1+E))));
    g=cost_term;%+reg_term
    
end