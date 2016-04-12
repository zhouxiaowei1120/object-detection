%This function takes as input the augmented negated data 
%and returns the solution vector using Batch Perceptron
%It takes as input the processed data,margin and stopping criteria

%on hit and trial
%b=44
%initialise eta with .5
%update eta by a factor of .9

function [a]=BatchRelaxation(dataAug,b,n)

[size_data,size_feature] = size(dataAug);

% Initialize
count1=1;
a = rand(1,size_feature);
aprev=zeros(1,size_feature);
%aprev=zeros(1,size_feature);
flag=1;
theta=.0001;

%Algorithm
%loop until the criterion function is satisfied or 
%all sample is correctly classified
while (flag && pdist([a;aprev])>theta)
   flag = 0;
   sum_yk=zeros(1,size_feature);
   
   %find the sum of all the misclassified samples
   %multiply each misclassified sample with a factor
   for k=1:size_data
      yk = dataAug(k,:);
      if a*yk'<=b
         factor = (b-(a*yk'))/power(pdist([zeros(1,size_feature);yk]),2);
         sum_yk=sum_yk+factor*yk;
         flag = 1;
      end
   end
   
   %update a,update eta
   if flag==1
     aprev=a;
     a = a + n*sum_yk;
     count1=count1+1;
     n=n*.9;
     disp (count1)
   end 
end

end
