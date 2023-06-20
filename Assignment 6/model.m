function mod = model(x,w,m)
    w=w';
    x;
    P=size(x,1);
    X=[];
%     product=zeros(P,m+1);

    m;
    for i=1:m
        X = [X x.^i];
    end

    aug_X = [ones(size(x,1),1) X];
    
    %w = extractdata(w)
    w;
%     product = bsxfun(@times, aug_X, w');
%     product = dlarray(product)
    %aug_X = dlarray(aug_X);
    for i=1:P
        product(i)=aug_X(i,:)*w;
        
    end
    product = product';
    
    mod = sum(product, 2);
%     mod = dlarray(mod)
    

end