

function [BW_data]=preprocess_feature(data)

size_data=size(data,1);
%Binarization and Noise Cleaning
BW_data=zeros(size_data,28,28);
for i=1:size_data
I=data(i,:);
disp(i);
level = graythresh(I); %find threshold value
BW = im2bw(I,level);
BW2 = bwmorph(BW,'clean',1);clc %clean noise
BW_data(i,:,:)=reshape(BW2,28,28);
end