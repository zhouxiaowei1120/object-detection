%This function takes as input the augmented negated data
%and returns the solution vector using single Sample Perceptron
%It takes as input the processed data and margin and the value 
%for stopping criteria

%on hit and trial
%b=0/8
%initialise eta with 5
%update eta by a factor of count
%for two class eta=5

function [a]=singleSamplePerceptron (dataAug,b,n)

[size_data, size_feature] = size(dataAug);

% Initialize
a = rand(1,size_feature);
aprev=zeros(1,size_feature);
flag = 1;
count1=1;
theta=.0001;

    
%Algorithm
%loop until the criterion function is satisfied or 
%all sample is correctly classified
while (pdist([a;aprev])>= theta && flag && count1 < 1000000)
   flag = 0;
   
   %find a misclassified sample and update a, n
   for k=1:size_data 
      yk = dataAug(k,:);      
      if a*yk'<=b
         aprev=a;
         a = a + n*yk;
         flag=1;
%          disp(count1);
         count1=count1+1; 
         break;
      end
   end
  
end

end
