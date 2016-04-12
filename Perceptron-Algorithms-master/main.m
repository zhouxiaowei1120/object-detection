%This function takes in a filename containing the test samples and an algorithm number and returns the predicted labels
%of the samples for that particular algorithm

function [outputlabel]=main(filename, algo)

%Initialize
x=load(filename);
C=struct2cell(x);
testData=cell2mat(C);
load('mnist_modified.mat');

%Preprocess the training data by binarisation and cleaning
[BW_train]=preprocess_feature(double(trainData));
[BW_test]=preprocess_feature(double(testData));

%Compute Feature
[feature_train] = feature_template(BW_train);
[feature_test] = feature_template(BW_test);

if algo==1 %Single Sample Perceptron without Margin
    functionName=@singleSamplePerceptron;
    b=0;
    n=0.9;
elseif algo==2 %Single Sample Perceptron with margin
    functionName=@singleSamplePerceptron;
    b=6;
    n=0.9;
elseif algo==3 %Batch Perceptron without margin
    functionName=@BatchPerceptron;
    b=0;
    n=0.01;
elseif algo==4 %Batch Perceptron with margin
    functionName=@BatchPerceptron;
    b=5;
    n=0.01;
elseif algo==5 %Batch Relaxation
    functionName=@BatchRelaxation;
    b=5;
    n=0.1;
else %incorrect input
    disp('Incorrect Choice')
end

%Compute Solution Vector
a= multiclass(feature_train, trainLabel, functionName,b,n);

%Compute Output Label
outputlabel=findLabel_multiclass(feature_test,a );

end