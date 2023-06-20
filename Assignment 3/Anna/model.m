% This function applies the model specified by the parameters theta to the data x
function y = model(x, theta)
    w =[theta(3) theta(4)];
    v = [theta(1) theta(2)];

    f = feature_transform(x,v);

    y = [ones(length(x),1) f]*w';
    
    % calculating the linear combination 
end
