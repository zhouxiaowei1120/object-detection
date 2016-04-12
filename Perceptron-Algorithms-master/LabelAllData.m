function [index]=LabelAllData(id)
load huaweiUploadData

%[m1 n1] = size(train_data);
[m2 n2] = size(test_data);
%trn_lab = zeros(m1,1);
tst_lab = zeros(m2,1);
%pos1=find (train_lab== id);
pos2=find (test_lab== id);
%trn_lab(pos1) = 1;
tst_lab(pos2) = 1;
index=randperm(m2);
%index =sort(index);
test = [tst_lab,test_data];
test = test(index,:);
tst_random_lab = test(:,1);
test_random_data = test(:,2:end);
% test_random_data = test_data(index,:);
% tst_random_lab = tst_lab(index,:);
save('Perceptron-Algorithms-master/random_test_data.mat','test_random_data','tst_random_lab');