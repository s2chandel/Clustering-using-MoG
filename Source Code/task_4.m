load('PB_data.mat')
load('PB12.mat')
k = 3;  

%function Exp_Max is called and given arguments X,k. The function will return learnt parameters - mean, covariance matrix and probability of k Gaussian.
[mu_1,s2_1,p_1] = Exp_Max(X1,k);
[mu_2,s2_2,p_2] = Exp_Max(X2,k);

%Creating the grid of points that spans the two datasets
X_min1 = min([X1(:,1);X2(:,1)]);
X_min2 = min([X1(:,2);X2(:,2)]);
X_max1 = max([X1(:,1);X2(:,1)]);
X_max2 = max([X1(:,2);X2(:,2)]);

%Initializing M
M = zeros(X_max1 -X_min1,X_max2-X_min2);

for i = X_min1:X_max1
   for j =X_min2:X_max2
      %function predict is called to compute the probability of the data point belonging to each cluster of the given class
      [p_test_1] = predict([i,j],k,p_1,mu_1,s2_1);
      [p_test_2] = predict([i,j],k,p_2,mu_2,s2_2);
      % Classification: If the probability of Phoneme1 is greater than Phoneme2, it is given Class 1 otherwise Class2
        if p_test_1>p_test_2
            M(i-X_min1+1,j-X_min2+1) =1;
        else
            M(i-X_min1+1,j-X_min2+1) =2;
        end 
       
   end
end

% Displaying Classification Matrix M
imagesc(M);
