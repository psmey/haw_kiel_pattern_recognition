function show_correlation (digit, pix_x, pix_y)

% For the specified digit and pixel: Show the correlation coefficient
% with all image pixels as grey level image.

% Parameters:
%
%   digit    the digit which is analyzed
%   pix_x    x value of the base pixel (i.e. the pixel which is compared
%            to all others)
%   pix_y    y value of base pixel
%
% Author: Hauke Schramm
%
% Testcall: show_correlation(8, 22, 6)
%

close all;
pkg load image;

filebase = "/home/hsc/PAT/Lab/Exercises/2/data/digit";

filename = [filebase int2str(digit) '.txt'];
D = load (filename);

close all;

% analyze the following pixel (get x and y IDs from data cursor)
%x = 20;
%y = 15;
pixel=(pix_y-1)*28+pix_x;

% show, which pixel is analyzed
Z = zeros(28,28);
Z(pix_y,pix_x) = 1;
figure(1);
imshow(Z);

if var(D(:,pixel)) == 0
    disp('This pixel has variance zero. Correlation is NaN.');
    return;
else
    corrIm = [];
    for i=1:784
        if var(D(:,i)) == 0
            corrIm = [corrIm 0];
        else
            corrIm = [corrIm corr(D(:,pixel),D(:,i))];
        end
    end
end
figure(2);
colormap('gray');
corrIm = reshape(corrIm,28,28);
corrIm = imrotate(corrIm,270);
corrIm = fliplr(corrIm);
corrIm = corrIm*128+128;  % scaling to [0,255]
min(corrIm(:));
max(corrIm(:));
imshow(corrIm,[min(corrIm(:)), max(corrIm(:))]);




