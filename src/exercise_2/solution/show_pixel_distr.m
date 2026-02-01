% Show the grey value probability distribution of a specific pixel and
% illustrate the location of this pixel.
%
% Author: Hauke Schramm
%

%filebase = 'D:\bungen\ABS\Daten\Digits\MINIST\data\digitDIGITREPLACE.mat';
%filebase = 'D:\Uebungen\ABS\Daten\Digits\MINIST\data\testDIGITREPLACE.mat';

close all;
filebase = "/home/hsc/PAT/Lab/Exercises/2/data/digitDIGITREPLACE.txt"

% digit to be analyzed
digit = 4;

filename = strrep(filebase,'DIGITREPLACE',int2str(digit));
D = load (filename);
% This loads all variables from the .mat file. Since there is
% only one variable, only this (D) is loaded.
% Now the data is stored in variable D in the following way:
% each row has 784 entries and represents a whole image 
% (28 * 28 = 784 pixel)

for i = 350:2:784
    
    % illustrate, which pixel is analyzed
    I = zeros(28);
    I = reshape(I, 1, 784);
    I(i) = 255;
    I = reshape(I, 28, 28);
    figure(1);
    imshow(I);

    p = D(:,i);
    [N, X] = hist(p, 50);
    %bar(X(2:49), N(2:49))
    figure(2);
    bar(X,N);
    
    pause(1);
end

