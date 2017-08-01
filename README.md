
# Character Recognition

## Introduction

This is an optical character recognition project written in MATLAB/Octave that predicts handwritten lowercase letters. It uses an artificial neural network to learn the alphabet from a 3600-character dataset and recognize unseen variations of characters.

## Table of Contents
1. [Installation](#how-to-install)
2. [How to run](#how-to-run-the-character-recognition-script)
3. [How it works](#how-it-works)
      * [Character Dataset](#making-the-character-dataset)
      * [Learning Letters](#neural-networks)
      * [Recognizing Letters](#recognizing-letters)
4. [Known Issues](#known-issues)

## How to install

At the command line (Windows Command Prompt, Mac/Linux Terminal, or Git BASH), navigate to a desired folder:
```
$ cd C:\Users\dx-dtran\Documents
```
Clone the repository to your folder:
```
$ git clone https://github.com/dx-dtran/character-recognition.git
```

## How to run the character recognition script

At the MATLAB or Octave command line, navigate to the folder where the source files are located:
```
>> cd 'C:\Users\dx-dtran\Documents\character-recognition\src'
```

#### MATLAB
Type into the command window:
```
>> predictFromFile
```
Alternatively, open predictFromFile.m in the text editor and either click ‘Run’ or press F5.

#### Octave
Type into the command line:
```
>> pkg load image
>> predictFromFile
```

Open a drawing app like Microsoft Paint and draw a single lowercase letter. Save it as a .png or .jpg file such as ‘letter.png.’ An example file called 'l.png' is included in the src directory.

Follow the prompt:
```
>> Enter a file name or press q to quit: letter.png
```
The script will display a processed version of the image file, a computer prediction of the handwritten letter, and its confidence level for the prediction:
```
Computer Prediction: y
Confidence: 95.92%
```
It will then ask for the correct letter and add the image to the dataset:
```
>> What was the correct letter? y
```
To submit another letter, simply erase the contents of letter.png, draw a new letter, save the file, and retype 'letter.png' at the prompt.

## How it works
Creating this project required three main steps:
1. Making a dataset of lowercase letters
2. Training a neural network to the learn the dataset
3. Having that neural network predict unseen characters

## Making the character dataset
The training dataset currently contains 3600 images of lowercase letters. 2600 examples come from screenshots of 100 different Microsoft Word fonts (100 fonts per letter). The remaining 1000 examples are handwritten submissions from four people.
Each letter image is processed using the ‘processImage.m’ script. It performs the following operations: 
1. Removes any whitespace surrounding the letter
2. Resizes image into a square 30 by 30 pixel image
3. Performs binary-thresholding so the image’s pixel intensity/color data is reduced to 1’s and 0’s: 1 for black, 0 for white
4. Flattens the image into a 1 by 900 vector. The first 30 elements represent the first row of the image’s pixels, the next 30 represent the second row, etc. 

These processed, flattened images are stored in a text file called ‘characterDataset.txt’. Each line in the file contains a 1 by 900 flattened character image, followed by a 1 by 26 vector signifying the image’s associated letter. 
```
1 0 0 0     # signifies ‘a’
0 1 0 0     # signifies ‘b’
0 0 1 0     # signifies ‘c’
...
```
The index of the number 1 determines the letter.
So, each line in the text file contains 926 elements: 900 elements for pixels, plus 26 elements to classify the letters. There are 3600 of these lines, making up a training set of 3600 letters.

## Neural Networks

This project uses an artificial neural network to both learn letters and recognize letters. The neural network is supposed to mimic a brain when transforming input values into output values.

### Learning Letters

To get a basic intuition of what the learning algorithm is doing, first imagine a 3-dimensional space filled with a bunch of a’s, b’s, c’s, and d’s. Because each letter has its own set of features or characteristics, such as different strokes or curves, each letter occupies its own region in the 3D space. 

In more mathematical terms, the letter ‘a’ has different x and y and z variable values than the other letters, and so if we were to plot a bunch of a’s, they would be grouped in their own unique location.

Now, for a computer to learn the difference between the four letters, it must create some mathematical functions that form boundaries around each letter’s grouping. That way, if we introduce a new glyph with similar characteristics or variable values to the letter ‘a’, it would hopefully fall inside the ‘a’ boundary, ensuring an accurate prediction of the letter ‘a’ and not some other letter. 

To start creating this boundary wall around ‘a’, we could first start off with a 3D plane (ax + by + cz + d= 0) initialized in a random position. However, the distance between the a’s and the random plane could potentially be quite large. We then need to modify the coefficients or weights of the plane equation to reorient the plane and minimize its distance between the a’s. 

```
distance = sigma i = 1 to 3600 (y_i * log(x_i) + (1 − y_i) * log(1 − p(x_i)))
```

This distance function is then minimized using a mathematical optimization algorithm called gradient descent.

The gradient descent algorithm returns a vector of coefficients/weights of the distance-minimized boundary plane. The weights orient the plane in such a way that it becomes a predictive model for the letter ‘a.’ We can repeat this process for b, c, and d and create boundaries for them as well. That way, we can discern four different letters.

Now, let’s say we introduce a bunch of additional handwritten a’s into our 3D space. Some of our new a’s might have new kinds of strokes and therefore might not fall inside the ‘a’ boundaries we created before. We now must adjust our boundary plane equations to account for the new variations of a’s, resulting in an improved model that can better discern the letter a.

This whole process of mapping mathematical functions to data and having the functions automatically improve with additional data is how the machine learns.

This project is a scaled-up implementation of these concepts. Whereas the 3D letter classification example above only involved 3 variables: x, y, and z, this project uses 900 variables: one for each of the 900 pixels in a glyph’s image. The color of each individual pixel in an image determines where the letter should be located in a 900-dimensional space. 

Then, hyper-dimensional planes are used to separate 26 letters from one another. The coefficients/weights of these hyperplanes are determined using a distance formula and gradient descent.

### Recognizing Letters

To recognize a handwritten letter from an image, a neural network must transform the image’s 1 by 900 pixel vector into a 1 by 26 letter classification vector. The index of the maximum value of this 1 by 26 vector represents the letter the computer thinks it is looking at. If the max value’s index is 1, the computer is predicting the letter ‘a’. If the max value’s index is 2, the computer is predicting ‘b’, and so on.

Here are scaled-down examples, where we want to transform a 40 pixel image into a 4 element vector to classify the letters a, b, c, and d.

If we have this pixel data for the letter ‘b’:
```
0 1 0 1 0 1 0 1 1 0 1 0 0 0 0 1 1 0 1 0 0 0 0 1 1 0 1 0 0 0 0 1 0 0 0 1 1 0 1 0
```
we want to figure out a way to transform it into:
```
0 1 0 0 
```
Likewise, if we have these pixels for the letter ‘d’:
```
0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 1 1 0 1 1 1 0 0 0 1 0 1 1 1 0 0 0 0
```
we want to transform it into:
```
0 0 0 1
```


This diagram is how computer scientists describe the transformation process a neural network performs. The red circles on the left are called “input neurons” and represent 3 input values. Those 3 inputs are transformed into 4 new neurons called “hidden neurons.” Then, these hidden neurons are transformed yet again to become 2 “output signals.” 

This project is a scaled-up version of this process. There are 900 input pixel values that are transformed into hidden neurons. Then, these hidden neurons are transformed again into 26 output values that determine the letter.

What’s really going on is that our neural network is performing a sequence of two linear transformations through two matrix multiplications. The network takes a 1 by 900 vector of pixels and multiplies it by a matrix of weights determined by the learning algorithm explained in the section above. This results in a new matrix called the hidden layer. The hidden layer is multiplied by another matrix of weights, which results in a 1 by 26 vector that describes the predicted letter. 

## Known Issues

1. predictFromFile script sometimes crashes if user draws a letter in a color other than black. processImage.m needs to be adjusted to ensure all colored images are converted to black and white.
2. Should find a substitute for imcomplement built-in function in processImage.m. This is only a built-in function for MATLAB and not Octave and requires user to run ‘pkg load image’ command in Octave.
3. When processImage.m removes whitespace surrounding a letter, letters such as i, l, or j get distorted.
4. When the predictFromFile script prompts user to confirm the drawn letter, the user must type a LOWERCASE ASCII character. Right now, there is no error checking for when a user types any other character.
5. Octave sometimes does not add a newline character when writing an image to the dataset. This results in multiple images per one row in the dataset, which is wrong formatting and definitely leads to program crash when the script is executed again.
