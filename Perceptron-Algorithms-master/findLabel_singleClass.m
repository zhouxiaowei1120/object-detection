%This function calculates the labels for two class classifier

function [label_calculate]=findLabel_singleClass(data,classNegative,a)

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
end