function [p_test]= predict(x,k,p,mu,s2)
% Here, the learnt parameters from Training dataset are used to predict probability of the test data belonging to each cluster of the given class
[n D] = size(x);

for i=1:k
  s2(:,:,i) = cov(x)./k;      % initially set to fraction of data covariance
end

set(gcf,'Renderer','zbuffer');
clear Z;
%Calculate the sum of probability of the data point belonging to each cluster of a given class 
    for i=1:k
      Z(:,i) = p(i)*det(s2(:,:,i))^(-0.5)*exp(-0.5*sum((x'-repmat(mu(:,i),1,n))'*inv(s2(:,:,i)).*(x'-repmat(mu(:,i),1,n))',2));
    end
  Z=sum(Z,2);
  p_test =Z;
end