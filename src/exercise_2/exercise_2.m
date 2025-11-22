% Pattern Recognition Exercises Practice Sheet 2


% a.
% Write a function show_data(im_num) (-> I used digit) with one input parameter that uses two
% for-loops to display im_num example images for each digit. Use the command
% pause to wait before showing the next digit.
%
% Example: Calling show_data (4) displays 4 example images
% for each of the 10 digits.
%
% Hint: To build the filename for a specific digit you may use string
% concatenation (cf. Octave documentation) and the command int2str.

% showData(2)

% b.
% Write a script show_mean_and_variance.m which plots the mean and variance of
% each pixel as two new images (see lecture, Chapter 1).

for digit = 0:9
    showMeanAndVariance(digit);
end

% c.
% Write a script show_pixel_distr.m which plots the gray value distribution of
% pixel number 297 (using the vector representation of the image for indexing)
% for all given images of digit 3. The pixel is located at the white dot shown
% in Figure 2.

# technically its pixel index 459
[row, column] = ind2sub([28, 28], 297);
[mean_matrix, variance_matrix] = showMeanAndVariance(3);
showPixelDistr(3, mean_matrix, column, row);

% d.
% Extend the tool in exercise c. to sequentially analyze the images of a given
% digit at 10 different interesting pixel positions. The current pixel must be
% adequately illustrated.

% based on mean
showPixelDistr(3, mean_matrix, 12, 15);
showPixelDistr(3, mean_matrix, 1, 1);
showPixelDistr(3, mean_matrix, 8, 7);
showPixelDistr(3, mean_matrix, 23, 19);
showPixelDistr(3, mean_matrix, 13, 15);

% based on variance
showPixelDistr(3, variance_matrix, 23, 9);
showPixelDistr(3, variance_matrix, 1, 1);
showPixelDistr(3, variance_matrix, 8, 7);
showPixelDistr(3, variance_matrix, 23, 19);
showPixelDistr(3, variance_matrix, 13, 15);
