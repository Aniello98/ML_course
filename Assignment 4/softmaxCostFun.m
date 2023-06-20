function g=softmaxCostFun(w,X,y)
    P=size(X,1);
    aug_X=[ones(size(X,1),1) X];
    
    
    E= exp(-y.*(aug_X*w'));
    cost_term=1/P*(sum(log(1+E)));
%     w=extractdata(w);
%     reg_term=lambda*norm(w')^2;
%     reg_term=dlarray(reg_term);
    g=cost_term;%+reg_term
    
end