function matrix = displayImage(flatImage, imageWidth)

if ~exist('imageWidth', 'var') || isempty(imageWidth)
    imageWidth = round(sqrt(size(flatImage, 2)));
end

flatImage = flatImage(:)';
matrix = zeros(imageWidth);
for row = 1:imageWidth
    for col = 1:imageWidth
        matrix(row, col) = flatImage((row - 1) * imageWidth + col);
    end
end

paddedMatrix = zeros(size(matrix) + 2);
paddedMatrix(2:end - 1, 2:end - 1) = matrix;

image = mat2gray(paddedMatrix);
imshow(image, 'InitialMagnification', 2000);
    
end