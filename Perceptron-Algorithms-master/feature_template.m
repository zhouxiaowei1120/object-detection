%Template matching, the feature vector is same as that of the data

function [feature] = feature_template(BW_data)

size_data = size(BW_data,1);
feature=zeros(size_data,784);
for i=1:size_data
    feature(i,:)=reshape(BW_data(i,:,:),1,784);
end

end
