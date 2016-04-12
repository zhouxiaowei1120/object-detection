%This function is used to compute the solution vector for multi class
%The function takes as input the training feature vector as data, 
%the label of the training data set, the function name, the margin and
%theta (the stopping criteria). It returns the vector solution vector a 
%for all the classes

function [a]= multiclass(data, label, functionName,b,n)

%initialisation
[size_feature]=size(data,2);
a=zeros(10,(size_feature+1));

%calculate a
for i=1:10
    disp(i)
    dataAug=preProcess (data,label,i-1);%augment andnegate the class i
    a(i,:)=functionName (dataAug,b,n);%call the function
end
end