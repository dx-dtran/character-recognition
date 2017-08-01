function image = thresholdImage(initialImage, threshold)
%THRESHOLDIMAGE Perform binary-thresholding on an image.
% Any pixels with color intensity greater than threshold are converted to
% 1.

image = sum(initialImage, 3) > threshold;

end