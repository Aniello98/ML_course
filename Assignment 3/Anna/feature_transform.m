% transforms features x non-linearly using the parameters v 
function z = feature_transform(x,v)
    x = [ones(length(x),1) x];
    z = sin(x*v');
end