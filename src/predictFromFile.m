% This script repeatedly prompts the user for a image file containing a 
% handwritten character. It predicts the letter written in the file and
% prints its confidence level. Finally, it prompts user for the correct
% letter and appends the image data to an output file.

clear; clc; close all;

% load pre-computed weights
load('weights1.mat');
load('weights2.mat');

% append any input images to outputFile
outputFile = fopen('randomized_dataset.txt', 'a+');

while 1
    
    file = input('\nEnter a file name or press q to quit: ', 's');
    if file == 'q'
        close all;
        break;
    end
    
    try
        image = processImage(file);
    catch
        fprintf('\nThat is not a valid file name.\n');
        fprintf('Make sure it is in the current directory\n\n');
        continue
    end
    
    displayImage(image);
    
    [pred, confidence, pred2] = predict(weights1, weights2, image);
    
    fprintf('\nComputer Prediction: %s\n', char(pred +96));
    fprintf('Confidence: %0.2f%%\n', confidence * 100);
    fprintf('Second Guess: %s\n\n', char(pred2 + 96));
   
    % append processed image file data to outputFile
    letter = input('What was the correct letter? ', 's');
    fprintf(outputFile, '%d ', image);
    fprintf(outputFile, '%d ', letterToVector(letter));
    fprintf(outputFile, '\n');

end