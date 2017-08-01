function [vector] = letterToVector(character)
%LETTERTOVECTOR Convert a lowercase ASCII character to a vector,
%   where the index i of 1 is the ith letter of the alphabet.

vectorMatrix = eye(26);
index = double(character) - 96;
vector = vectorMatrix(index, :);

end