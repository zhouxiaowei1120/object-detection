function []=Finetune(label,i)
load random_test_data
switch i
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
end
[dataAug]= preProcess (test_random_data(i,:),tst_random_lab(i,:),0);
[a]=singleSamplePerceptron_online (dataAug,6,0.9,a);
filename=['Perceptron-Algorithms-master/devide' num2str(i) '.mat'];
save(filename,'a');