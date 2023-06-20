function [w,gmin,alpha_opt]= searchAlgorithm_Ass6(X,y,alpha)

    w_vect=[];
    g=[];
    for i=1:length(alpha)

        [w,gmin]=regularizedFeatureSelection_search(X,y,0.004,alpha(i));
        w_vect=[w_vect; w];
        g= [g; gmin];
    end

    [gmin,idx] = min(g);
    w=w_vect(idx,:);
    alpha_opt=alpha(idx);

end