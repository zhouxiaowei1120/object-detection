%This function augments and negates the data
%The input arguments are data, label and the class which we
%want to negate.It returns the augmented data

function [dataAug]= preProcess (data,label,class_a)

size_data = size(data,1);

% Augment data
dataAug= [ones(size_data,1) data];

%Negation of class
index = find(label==class_a);
dataAug(index,:)=-dataAug(index,:);

end
