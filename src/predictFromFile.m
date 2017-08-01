clear; clc; close all;

load('weights1.mat');
load('weights2.mat');

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
    % fprintf('Second Guess: %s\n\n', char(pred2 + 96));
   
end