function [p, c, p2] = predict(Weights1, Weights2, X)

trainingExamples = size(X, 1);

h1 = logisticFunction([ones(trainingExamples, 1) X] * Weights1');
h2 = logisticFunction([ones(trainingExamples, 1) h1] * Weights2');

[~, idx] = sort(h2, 2, 'descend');

[c, p] = max(h2, [], 2);
p2 = idx(:, 2);

end