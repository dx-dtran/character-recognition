function image = processImage(imageFileName)
%PROCESSIMAGE Process an image containing a handwritten letter.
% Returns a 1x900 binary-thresholded row vector representing the letter

% read the image
image = imread(imageFileName);
image = image(:,:,1)';

% invert image colors
image = imcomplement(image);

% remove whitespace surrounding letter
image(~any(image,2),:) = [];
image(:,~any(image,1)) = [];

% resize the image down to 30x30 pixels
image = imresize(image, [30, 30]);

% perform a binary threshold
image = double(thresholdImage(image, 0));

% convert 30x30 image matrix to a row vector
image = image(:)';

end