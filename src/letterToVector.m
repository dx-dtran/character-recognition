function [vector] = letterToVector(character)

vectorMatrix = eye(26);
index = double(character) - 96;
vector = vectorMatrix(index, :);

end