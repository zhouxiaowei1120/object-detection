%This function takes as input the augmented negated data 
%and returns the solution vector using Batch Perceptron
%It takes as input the processed data margin and the value 
%for stopping criteria

%on hit and trial
%b=5 or 0
%initialise eta with .01
%update eta by a factor of .9

function [a]=BatchPerceptron (dataAug,b,n)

[size_data,size_feature] = size(dataAug);

% Initialize
a = rand(1,size_feature);
aprev=zeros(1,size_feature);
count1=1;
flag=1;
theta=.0001;

%Algorithm
%loop until the criterion function is satisfied or 
%all sample is correctly classified
while (pdist([a;aprev])>= theta && flag)
   flag = 0;
   sum_yk=zeros(1,size_feature);
   
   %find sum of misclassified samples
   for k=1:size_data
      yk = dataAug(k,:);
      if a*yk'<= b
         sum_yk=sum_yk+yk;
         flag = 1;
      end
   end
   
   %update a, update eta
   if flag==1
     aprev=a;
     a = a + n*sum_yk;
     if(~b)
      n=n*0.9;
     end
     count1=count1+1;
     disp (count1)
   end 
end

end
