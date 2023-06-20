function f = featureTransform(x,m)

    X=[];


    m;
    for i=1:m
        X = [X x.^i];
    end

    f = [ones(size(x,1),1) X];

end