function [p, c, p2] = predict(Weights1, Weights2, image)
%PREDICT Predict the handwritten letter in image.
% This uses a feedforward neural network

image_size = size(image, 1);

h1 = logisticFunction([ones(image_size, 1) image] * Weights1');
h2 = logisticFunction([ones(image_size, 1) h1] * Weights2');

[~, idx] = sort(h2, 2, 'descend');

[c, p] = max(h2, [], 2);
p2 = idx(:, 2);

end