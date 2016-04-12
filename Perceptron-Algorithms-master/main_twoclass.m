%This function takes in a variable containing the test samples 
%and an algorithm number and returns the predicted labels
%of the samples for that particular algorithm

function [outputlabel]=main_twoclass(testData, algo)

load('MS2CD_modified.mat');


if algo==1 %Single Sample Perceptron without Margin
    functionName=@singleSamplePerceptron;
    b=0;
    n=5;
elseif algo==2 %Single Sample Perceptron with margin
    functionName=@singleSamplePerceptron;
    b=8;
    n=5;
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
    b=44;
    n=0.5;
else %incorrect input
    disp('Incorrect Choice')
end

%Compute Solution Vector
[dataAug]= preProcess (trainData,trainLabel,0)
a= functionName(dataAug,b,n);

%Compute Output Label
outputlabel=findLabel_singleClass(testData,0,a);

end