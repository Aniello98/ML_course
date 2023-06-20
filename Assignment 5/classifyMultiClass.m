function c = classifyMultiClass( W, X )

    % IMPLEMENT FUNCTION BODY
    Xp=[ones(size(X,1),1) X];

    temp=Xp*W';
    
    [nn,argmax]=max(temp,[],2);
    
    c=argmax-1;
    
    
end