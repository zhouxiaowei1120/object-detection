%This function computes the label of the multi class classifier
%It takes as input the test data and the n
%dimensional solution vector where n is the number of classes
%It returns the label of the test data

function [label_calculate]=findLabel_multiclass(data,a )

size_data=size(data,1);
correct=0;
incorrect=0;
undefined=0;
label_calculate=-ones(size_data,1);

%augment test data
data= [ones(size_data,1) data];


for i=1:size_data
   %calculate score for each class
   score=zeros(1,10);
   for j=1:10
        if  a(j,:)*data(i,:)'<0
            score(j)=a(j,:)*data(i,:)';
        end
   end
   %take the most suitable label
   [~,index]=min(score);
   label_calculate(i) = index-1;
end
end   