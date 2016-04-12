%This function takes in a filename containing the 
%test samples and an algorithm number and returns the predicted labels
%of the samples for that particular algorithm

function [outputlabel]=main_multiclass_offline(testData, decisionboundary)

%Initialize
load('mnist_modified.mat');
load(decisionboundary);

%Preprocess the test data by binarisation and cleaning
[BW_test]=preprocess_feature(testData);

%Compute Feature
[feature_test] = feature_template(BW_test);

%Compute Output Label
outputlabel=findLabel_multiclass(feature_test,a );

end