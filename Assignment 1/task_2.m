v=[
     8
     4
     5
     6
    10
     5
     9
     5
     2
     3
     9
     4
     1
     6
     6
     1
     6
     9
    10
     2
     1
     3
     3
     9
     2
     1
     6
    10
     2
     4
     7
     6
     1
     9
    10
     3
     2
     4
     7
     6
     4
     4
    10
     6
     1
    10
    10
     5
     5
     3
     9
     7
     3
     1
     3
     3
     6
     6
    10
     2
     3
     4
     9
     3
     3
    10
     2
     6
     4
     2
     6
     2
     5
     1
     6
     5
     9
    10
     2
    10
     5
     2
     6
     4
     3
     8
     3
     7
     9
     2
     5
     6
     7
     4
     4
     2
     5
    10
     5
     1]



% Write a for loop that computes the sum of the elements in v, and stores it to the variable 's'
s=0;
for (i=1:length(v))
    s=s+v(i);
end
s


% Calculate the same sum using the 'sum' function instead of a loop, and store the result into 'ss'
ss=sum(v)


% Calculate the sum of squares of the elements in v using the 'sum' function and the element-wise power operator (.^) instead of a loop. Store the result into 'ss2'
ss2=sum(v.^2)

% Make another for loop that goes through the elements of v, and creates a same size vector called 'w' containing -1 for odd, and +1 even valued element indexes of v.
% Use the if-else construct to choose which one (-1 or +1) to pick for each element
w=zeros(size(v))

for (i=1:length(v))
    if(floor(v(i)/2)==v(i)/2)
        w(i)=1;
    else
        w(i)=-1;
    end
end
 
    w


% Similarly to previous but instead of a for loop, create the vector 'w2' by artihmetically manipulating the output of the modulo function ('mod') on the whole vector v
w2=mod(v,2).*(-2)+1

% Find the maximum value of the elements of v and store it into variable 'v_max'
v_max=max(v)

% Find the index (not the value) of the minimum valued element of v into variable 'v_min_loc'. In case of multiple minima, store only the location of the first one.

[m,v_min_loc]=min(v)



