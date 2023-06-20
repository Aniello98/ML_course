function s = fib(n)

    % COMMENTS BELOW SHOW TYPICAL STEPS YOU MIGHT TAKE IN YOUR SOLUTION

    % 1. Initialize correct size return variable vector for speed
    s=zeros(1,n)
    
    if(n==0)
        return;
    end
    
    % 2. First element initialization
    s(1)=0;
    if(n==1)
        return;
    end
    % 3. Second element initialization
    s(2)=1;
    if(n==2)
        return;
    end

    % 4. Fill in the remaining elements
    s(1:n-1)=fib(n-1);
    s(n)=s(n-2)+s(n-1);
    

end