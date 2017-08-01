function matrix = displayImage(flatImage, imageWidth)
%DISPLAYIMAGE Display a flattened image.
%   im = displayImage(X) converts a 1D vector of pixels, X, into a 2D square
%   matrix, im.
%   im is then displayed in the GUI

if ~exist('imageWidth', 'var') || isempty(imageWidth)
    imageWidth = round(sqrt(size(flatImage, 2)));
end

% convert 1D flatImage vector into a 2D square matrix
flatImage = flatImage(:)';
matrix = zeros(imageWidth);
for row = 1:imageWidth
    for col = 1:imageWidth
        matrix(row, col) = flatImage((row - 1) * imageWidth + col);
    end
end

% create black border around matrix
paddedMatrix = zeros(size(matrix) + 2);
paddedMatrix(2:end - 1, 2:end - 1) = matrix;    

image = mat2gray(paddedMatrix);
imshow(image, 'InitialMagnification', 2000);
    
end