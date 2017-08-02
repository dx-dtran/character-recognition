clear; clc; close all;

load('characterDataset.txt');

num_rows = size(characterDataset, 1);
ordering = randperm(num_rows);
new_dataset = characterDataset(ordering, :);

outputFile = fopen('randomized_dataset.txt', 'wt');

for i = 1:num_rows
    fprintf(outputFile, '%d ', new_dataset(i,:));
    fprintf(outputFile, '\n');
end