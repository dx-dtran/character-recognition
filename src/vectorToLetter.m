function letter = vectorToLetter(vector)

[empty, index] = max(vector, [], 2);
letter = char(index + 96);

end