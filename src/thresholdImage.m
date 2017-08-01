function image = thresholdImage(initialImage, threshold)

image = sum(initialImage, 3) > threshold;

end