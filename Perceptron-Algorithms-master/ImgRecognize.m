% [dataAug]= preProcess (train_data,train_lab,0);
% [a]=singleSamplePerceptron (dataAug,6,0.9);
% a= multiclass(train_data, train_lab, @singleSamplePerceptron,6,0.9);
% outputlabel=findLabel_multiclass(test_data,a );

function [RegTime,label_calculate] = ImgRecognize(i,id)
load random_test_data
switch id
    case 1
        load devide1
    case 2
        load devide2
    case 3
        load devide3
    case 4
        load devide4
    case 5
        load devide5
    otherwise
        errordlg('Error, please close the program!','Error');
        return;
end

tic;
[label_calculate]=findLabel_singleClass(test_random_data(i,:),0,a);
RegTime = toc;