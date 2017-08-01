function image = processImage(imageFileName)

image = imread(imageFileName);
image = image(:,:,1)';

image = imcomplement(image);

image(~any(image,2),:) = [];
image(:,~any(image,1)) = [];

image = imresize(image, [30, 30]);

image = double(thresholdImage(image, 0));

image = image(:)';

end