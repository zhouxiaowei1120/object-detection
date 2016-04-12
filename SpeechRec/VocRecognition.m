
function [result] = VocRecognition()
%clear all;
%close all;
result = 0;           %Default value is 0.
ncoeff = 13;          %Required number of mfcc coefficients
N = 2;                %Number of words in vocabulary
k = 3;                %Number of nearest neighbors to choose
fs=16000;             %Sampling rate 
duration1 = 0.15;     %Initial silence duration in seconds
duration2 = 2;        %Recording duration in seconds
G=2;                  %vary this factor to compensate for amplitude variations
NSpeakers = 5;        %Number of training speakers

fprintf('Press any key to start %g seconds of speech recording...', duration2); 
pause;
silence = wavrecord(duration1*fs, fs);
fprintf('Recording speech...'); 
speechIn = wavrecord(duration2*fs, fs); % duration*fs is the total number of sample points 
fprintf('Finished recording.\n');
fprintf('System is trying to recognize what you have spoken...\n');
speechIn1 = [silence;speechIn];                  %pads with 150 ms silence
speechIn2 = speechIn1.*G;
speechIn3 = speechIn2 - mean(speechIn2);         %DC offset elimination
speechIn = nreduce(speechIn3,fs);                %Applies spectral subtraction
rMatrix1 = mfccf(ncoeff,speechIn,fs);            %Compute test feature vector
rMatrix = CMN(rMatrix1);                         %Removes convolutional noise

Sco = DTWScores(rMatrix,N);                      %computes all DTW scores
[SortedScores,EIndex] = sort(Sco);               %Sort scores increasing
K_Vector = EIndex(1:k);                          %Gets k lowest scores
Neighbors = zeros(1,k);                          %will hold k-N neighbors

%Essentially, code below uses the index of the returned k lowest scores to
%determine their classes

for t = 1:k
    u = K_Vector(t);
    for r = 1:NSpeakers-1
        if u <= (N)
            break
        else u = u - (N);
        end
    end
    Neighbors(t) = u;
    
end

%Apply k-Nearest Neighbor rule
Nbr = Neighbors
%sortk = sort(Nbr);  
[Modal,Freq] = mode(Nbr);                              %most frequent value
%Word = strvcat('One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','Yes','No','Hello','Open','Close','Start','Stop','Dial','On','Off'); 
Word = strvcat('Yes','No'); 
if mean(abs(speechIn)) < 0.01
    fprintf('No microphone connected or you have not said anything.\n');
    result = 4;
elseif ((k/Freq) > 2)                                  %if no majority
    fprintf('The word you have said could not be properly recognised.\n');
    result = 3;
else
   fprintf('You have just said %s.\n',Word(Modal,:)); %Prints recognized word
    result = Modal;
end
