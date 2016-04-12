function AllScores = DTWScores(rMatrix,N)


%Vectors to hold DTW scores
Scores1 = zeros(1,N);                
Scores2 = zeros(1,N);
Scores3 = zeros(1,N);
Scores4 = zeros(1,N);
Scores5 = zeros(1,N);

%Load the refernce templates from file
s1 = load('Vectors1.mat');
fMatrixall1 = struct2cell(s1);
s2 = load('Vectors2.mat');
fMatrixall2 = struct2cell(s2);
s3 = load('Vectors3.mat');
fMatrixall3 = struct2cell(s3);
s4 = load('Vectors4.mat');
fMatrixall4 = struct2cell(s4);
s5 = load('Vectors5.mat');
fMatrixall5 = struct2cell(s5);

%Compute DTW scores for test template against all reference templates
for i = 1:N
    fMatrix1 = fMatrixall1{i,1};
    fMatrix1 = CMN(fMatrix1);
    Scores1(i) = myDTW(fMatrix1,rMatrix);
end

for j = 1:N
    fMatrix2 = fMatrixall2{j,1};
    fMatrix2 = CMN(fMatrix2);
    Scores2(j) = myDTW(fMatrix2,rMatrix);
end

for m = 1:N
    fMatrix3 = fMatrixall3{m,1};
    fMatrix3 = CMN(fMatrix3);
    Scores3(m) = myDTW(fMatrix3,rMatrix);
end

for p = 1:N
    fMatrix4 = fMatrixall4{p,1};
    fMatrix4 = CMN(fMatrix4);
    Scores4(p) = myDTW(fMatrix4,rMatrix);
end

for q = 1:N
    fMatrix5 = fMatrixall5{q,1};
    fMatrix5 = CMN(fMatrix5);
    Scores5(q) = myDTW(fMatrix5,rMatrix);
end

AllScores = [Scores1,Scores2,Scores3,Scores4,Scores5];

