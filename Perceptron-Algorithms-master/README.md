Perceptron-Algorithms
=====================

This repository consists of the project done as part of the course  Statistical Methods in AI- Monsoon 2013. The course was instructed by [Dr. Anoop Nambodiri](http://faculty.iiit.ac.in/~anoop/)  

A detailed report is available <a href="https://drive.google.com/file/d/0B87x7EOOS4ztVzJtWVdUNW1qbzA/edit?usp=sharing", target="blank">here</a>  

##Requirements  
Matlab R2012a

##Problem
In this project we classify two class and multiclass data using various perceptron algorithms on MS2CD and MNIST database respectively. The problem of classification is old and was also done using K-NN but K-NN is computationally expensive and hence in order to overcome the high time and space complexity we come up with Perceptron Algorithms. Various perceptron algorithms have been implemented.

The src folder consists of the following:

##2 class classifier
* preProcess.m:
In this step all the training samples of the MS2CD dataset are augmented with one and then for one class they are negated. A typical function call will look like:  
**[dataAug]= preProcess (data,label,class_a)**  
where data and label are the respective training samples and class_a is the class which we want to negate. The function returns the augmented and negated training samples in the matrix dataAug
 
* singleSamplePerceptron.m  
* BatchPerceptron.m
* BatchRelaxation.m  

In this step we find the decision boundary using the preprocessed training samples. The training can be done using a variety of ways.In this experiment I have included five algorithms:  
1)Single Sample Perceptron without margin  
2)Single Sample Perceptron with margin  
3)Batch Perceptron without margin  
4)Batch Perceptron with margin  
5)Batch Relaxation with margin  
The functions takes in the augmented training data, the value of the margin (zero in case of without margin) and the value of theta determining the difference between the solution vector in two consecutive iterations. They return the d dimensional solution vector 'a', where d is the same as the size of each training sample.  
For example,  
**[a]=singleSamplePerceptron (dataAug,8,0)**  
calls the Single Sample Perceptron algorithm with a margin of 8 units and eta 0.  

Similarly,  
**[a]=BatchPerceptron (dataAug,0,0)**  
calls the Batch Perceptron algorithm without margin where the value of eta is 0.

Likewise,  
**[a]=BatchRelaxation(dataAug,4,0)**  
calls the Batch Relaxation algorithm with a margin of 4 and where the value of eta is 0.

* calculateAccuracy.m  
In this step we find the accuracy of the classifier by calling the following function:  
**[accuracy]=calculateAccuracy(data,label,classNegative,a)**  
where we input the test data, labels, the class which we had negated to ease calculation and the solution vector obtained from the previous step.The function returns the accuracy expressed in percentage

* plotdecisionboundary.m  
Alternatively, we can plot the samples and the decision boundary to check the accuracy graphically. It can be dome by calling the following function:  
**[h]=plotdecisionboundary(a,data,label)**

where a is the solution vector, data is the testing data and label is the testing label. Also, in order to compare with 1-KNN we need to call the following:  
**[accuracy]=knnclassifier(k,feature_train,feature_test,BW_train,BW_test,label_train,label_test)**  
where k=1, BW_train and feature_train are same in this case and so for test. label_train and label_test are the test and train data labels

##Multiclass Classifier
The Perceptron Algorithms for multi-class classifier are implemented as follows:

A typical call to this function is as follows:
[output label]= main(filename, algonumber)

In this experiment I have included five algorithms.The function names are given against each algorithm:

The algonumber for the corresponding algorithm are as follows:  
1-Single Sample Perceptron without margin-@singleSamplePerceptron  
2-Single Sample Perceptron with margin-@singleSamplePerceptron(pass a non zero margin as argument)  
3-Batch Perceptron without margin-@BatchPerceptron  
4-Batch Perceptron with margin-@BatchPerceptron(pass a non zero margin as argument)  
5-Batch Relaxation with margin=@BatchRelaxation(pass a non zero margin as argument)

It takes as input the filename for testing and the algorithm number and returns the output label
