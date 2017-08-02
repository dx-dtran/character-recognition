clear; clc; close all;

fprintf('Starting...\n');

load('randomized_dataset.txt');

num_rows = size(randomized_dataset, 1);
ordering = randperm(num_rows);
new_dataset = randomized_dataset(ordering, :);

outputFile = fopen('randomized_dataset.txt', 'wt');

for i = 1:num_rows
    fprintf(outputFile, '%d ', new_dataset(i,:));
    fprintf(outputFile, '\n');
end

fprintf('Done\n');