% Shows a few images of each digit taken from the digit recognition corpus located in 
%
% Parameters:
%
% num_shown_images   Number of images that will be shown for each digit
%
% Author: H. Schramm
%

function im = show_data (number_of_shown_images)

close all;
pkg load image;
filebase = "/home/hsc/PAT/Lab/Exercises/2/data/digit";

for i = 0:9
    filename = sprintf('%s%d.txt', filebase, i);
    % or: filename = [filebase int2str(i) '.txt'];  
    D = load (filename);
    % Loads the matrix D which contains the images of current digit in the individual rows.
    % Each row has 784 entries and represents a whole image 
    % (28 * 28 = 784 pixel)

    fprintf('Number of test images for digit %d : %d\n', i, size(D,1));
    close all;
    for j = 20:(20+number_of_shown_images-1)  % show a few images, starting with image 20
        figure(j-20+1);
        I = D(j,:);              % I contains a vector with all pixels of image number j
        im = reshape(I, 28, 28); % 'im' contains a 28 * 28 matrix with the image pixels
        im = imrotate(im,270);   % rotate the image by 270 degree
        im = fliplr(im);         % flip left and right

        % display the image
        imshow(im, []);
        pause(1);  % press key to go on
    end
end
