function betas= computeWeights(y)
    
    tbl=tabulate(y);
    w = 1./tbl(:,2);

    betas=ones(size(y));
    betas(y==-1) = w(1);
    betas(y==1) = w(2);
    
end