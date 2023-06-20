function [res] = computeResidual(X, y, w)
    model = model2(X,w);
    res = y - model;
end