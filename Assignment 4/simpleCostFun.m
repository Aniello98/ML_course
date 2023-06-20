function g=simpleCostFun(w,X,y)
    P=size(X,1);
    aug_X=[ones(size(X,1),1) X];

    yp_xp_w= -y .* (aug_X*w'); 
    g= (1/P)*sum(max([zeros(P,1) yp_xp_w],[],2));

end