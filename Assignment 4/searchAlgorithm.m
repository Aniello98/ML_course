function [w,gmin,alpha_opt]= searchAlgorithm(X,y,alpha)

    w_vect=[];
    g=[];
    for i=1:length(alpha)

        [w,gmin]=trainPerceptronNormalized_search(X,y,alpha(i));
        w_vect=[w_vect; w];
        g= [g; gmin];
    end

    [gmin,idx] = min(g);
    w=w_vect(idx,:);
    alpha_opt=alpha(idx);

end