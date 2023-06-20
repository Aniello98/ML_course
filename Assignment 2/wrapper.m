%computes the function value and the gradient iof any function given by
%the handle f at x
function [fval,gradval] = wrapper(f,x)

    fval=f(x)
    gradval=zeros(size(x));
    gradval=dlarray(gradval);
    
    for i = 1:size(x,1)
        
        
        f_i=fval(i)
        x_i=x(i,:)
        gradval(i,:)=dlgradient(f_i,x_i)
        
        

    end
%     x=x(1,:)
%     x
%     gradval = dlgradient(fval,x)
%     pause
    
end