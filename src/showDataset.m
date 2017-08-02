clear; clc; close all;

load('randomized_dataset.txt');

for i = size(randomized_dataset, 1):-1:1
     displayImage(randomized_dataset(i, 1:900));
     fprintf('Letter: %s\n', vectorToLetter(randomized_dataset(i, 901:end)));
     pause(0.5);
end