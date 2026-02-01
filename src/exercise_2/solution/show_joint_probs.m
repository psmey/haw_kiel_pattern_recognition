function show_joint_probs(digit, min_grey, max_grey)

% Show the conditional joint probability distribution 
%
%    P( min_grey <= grey value < max_grey | digit ) 
%
% for the given digit and each pixel as grey value image.
% 
%
% Parameters:
% 
% digit      digit to be analyzed
% min_grey   minimum grey value
% max_grey   maximum grey value
%

close all;
filebase = "/Users/hschramm/Dropbox/Uebungen/PAT/2020/Exercise2/Practical/data/digit";

filename = sprintf('%s%d.txt', filebase, digit);
D = load (filename);

% A is a logical matrix identifying pixels with gray values in the given range
A = (D >= min_grey & D < max_grey);
s = size(A);

% sum(A) computes the sum over each column. Division by the number of
% images provides the required probability estimate.
P = sum(A)/s(1);

% now convert the probability vector into a matrix for visualization
P = reshape(P, 28, 28);
P = P';

% show the probability image
imshow(P, []);
