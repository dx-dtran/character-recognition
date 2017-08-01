function letter = vectorToLetter(vector)
%LETTERTOVECTOR Convert a vector where the index i of 1 is the ith letter of the alphabet
%   to a lowercase ASCII character.

[~, index] = max(vector, [], 2);
letter = char(index + 96);

end