  clear all
  close all
  clc



    w0=linspace(-50,50);
    y_g=ones(1,length(w0));
    g=@(w) cost_perceptron(w);
    for i=1:length(w0)
        y_g(i)=g(w0(i));
    end

    figure
    plot(w0,y_g)


% Nested cost function
    function c = cost_perceptron(w)

        
        A = load('3class_data.csv');
    
        % Form the feature matrix starting from the first row upto second last
        X = A(1,:)';
        y = A(end,:)';
        P=size(X,1)

        %N=2;
        %C=3;
        Xp=[ones(size(X,1),1) X];
        Wc=[];
        %Wc=reshape(w,C,N+1);
        Wc=w;

        max_x_w=classifyMultiClass(Wc,X);
        Xw_yp=ones(P,1);

        for i = 1:P
            Xw_yp(i)=Xp(i,:)*Wc(y(i)+1,:)';
        end
%         Xw_yp
%         max_x_w
%         w
%         Wc

        % Evaluate the Multi-Class Perceptron cost
        c = 1/P* sum( max_x_w - Xw_yp );

    end
