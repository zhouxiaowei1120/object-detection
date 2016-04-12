%This function takes as input the actual data points, labels and 
%the solution vectors and gives as output the plot of 
%decision boundary aling with the data points

function [h]=plotdecisionboundary(a,data,label)

%plot data points
%gscatter(data(:,1),data(:,2),label);

hold on

%plot the decision boundary
a0=a(1,1);
a1=a(1,2);
a2=a(1,3);
m=-a1/a2;
b=-a0/a2;
h=ezplot(@(x)m*x+b,[-3,18,-3,18]);
end

