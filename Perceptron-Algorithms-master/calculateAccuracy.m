function [accuracy]=calculateAccuracy(data,label,classNegative,a)

%initialize
size_data=size(data,1);
correct=0;
incorrect=0;
classPositive=~(classNegative);

label_calculate= -ones(size_data,1);
%augment test data
data= [ones(size_data,1) data];

%find test labels as given by the system
for i=1:size_data
    if a*data(i,:)'> 0
        label_calculate(i)=classPositive;
    elseif a*data(i,:)'< 0
        label_calculate(i)=classNegative;
    end
end

 %find accuracy
 for i=1:size_data
     if label_calculate(i)==-1
         undefined=undefined+1;
     elseif label_calculate(i)== label(i)
         correct=correct+1;
     else
         incorrect=incorrect+1;
     end
 end
         
 %find accuracy
 total=correct+incorrect+undefined;
 accuracy=correct*100/total;
 undefined=undefined*100/total;      
    
end