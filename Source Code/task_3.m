% Simple script to do EM for a mixture of Gaussians.
% -------------------------------------------------
%  based on code from  Rasmussen and Ghahramani
% (http://www.gatsby.ucl.ac.uk/~zoubin/course02/)

% Initialise parameters
load('PB12.mat')
[n D] = size(X1); 

%Spliting Data into Training & Test
tr_index = floor(0.8*n);
xtr1=X1(1:tr_index,:);
xtr2=X2(1:tr_index,:);

X1_test = X1(tr_index+1:end,:);
X2_test = X2(tr_index+1:end,:);
X_test =[X1_test;X2_test];
Y1_test = ones(size(X1_test,1),1);
Y2_test = ones(size(X2_test,1),1)*2;
Y_test = [Y1_test;Y2_test];

k = 6;     % number of components

% A new function Exp_Max is called and given arguments Xtr,k. The function will return learnt parameters - mean, covariance matrix and probability of k Gaussians.
[mu_1,s2_1,p_1] = Exp_Max(xtr1,k);
[mu_2,s2_2,p_2] = Exp_Max(xtr2,k);

% A new function predict is called and given arguments Xtest,k,mean,covariance matrix and probability of k Gaussian. The function will return probability vector for respective phonemes
[p_test_1] = predict(X_test,k,p_1,mu_1,s2_1);
[p_test_2] = predict(X_test,k,p_2,mu_2,s2_2);

% Classification: If the probability of Phoneme1 is greater than Phoneme2, it is given Class 1 otherwise Class2
class =zeros(size(X_test,1),1);
for i = 1:size(X_test,1)
    if p_test_1(i) > p_test_2(i)
        class(i) =1;
    else
        class(i) =2;
    end
end


% Determining Accuracy:
counter =0.0; 
for i =1:size((X_test),1)
    if class(i) == Y_test(i)
        counter = counter+1;
    end
end
Accuracy = counter/size(X_test,1)