% Exercise L-1.1 (Octave basics, random variables and statistics)

% a.
% Generate two N x N matrices A and B containing integer random values (set N = 100).
% The numbers in A must be uniformly distributed in the interval [0,10) and in B normally
% distributed with mean 0 and standard deviation s = 10. Utilize the Octave functions rand,
% randn, fix and round. For the generation of A you need fix and for B round. Why?

N = 100
% rand(N) generates a matrix of the size N x N with numbers uniformly distributed in [0,1)
% To scale this to [0,10), multiply this by 10
% To get integers instead of floats use fix which truncates the decimal part (rounds down)
% round would round up or down which could lead to a value of 10
A = fix(10 * rand(N))
B = round(10 * randn(N))

% b.
% Determine the minimum and maximum element of A and B (functions min and max).
% Store the results in amin, amax, bmin and bmax
amin = min(A(:))
amax = max(A(:))
bmin = min(B(:))
bmax = max(B(:))

% c.
% Determine the frequency of each matrix element in A (respectively B) and store it as
% follows in vector a (resp. b): The first element of a (b) contains the frequency of the
% smallest element in A (B) and the last element of a (b) contains the frequency of the largest
% element in A (B).
% Hints:
%   i. For this task you may use the functions find and length and work with a for-loop.
%   ii. A == i  returns a N x N logical matrix with values 1 only at elements in A which equal i.
%   iii. You may append a number x as follows to a vector a:  a = [a  x];
a = [];
for i = amin:amax
    frequency = length(find(A(:) == i));
    a = [a frequency];
end
asum = sum(a)
a

b = [];
for i = bmin:bmax
    frequency = length(find(B(:) == i));
    b = [b frequency];
end
bsum = sum(b)
b

% d.
% Draw the frequency distributions in vector a and b into two separate figures (Figure 1 and
% Figure 2) using the functions bar and figure. Label them appropriately. Note that this
% graphical representation of the distribution of data is called a histogram.
% Useful commands: title, xlabel, ylabel, axis

% --- Plot for A ---
bar(amin:amax, a)
title('Frequency Distribution of Matrix A')
xlabel('Value')
ylabel('Frequency')
axis([amin-1 amax+1 0 max(a)*1.1])
print('../figures/exercise_1/frequency_a.png', '-dpng')
close all

% --- Plot for B ---
bar(bmin:bmax, b)
title('Frequency Distribution of Matrix A')
xlabel('Value')
ylabel('Frequency')
axis([bmin-1 bmax+1 0 max(b)*1.1])
print('../figures/exercise_1/frequency_b.png', '-dpng')
close all

% e.
% Since the data in matrix A is uniformly distributed, all components of vector a should have
% similar values which must be evenly distributed around the mean frequency value.
% Illustrate this fact by plotting the mean of all components in a as horizontal line into Figure
% 1. Use the command "hold on" to retain the current figure when plotting a new object.
% Useful commands: line, hold on

% --- Plot for A ---
bar(amin:amax, a)
title('Frequency Distribution of Matrix A')
xlabel('Value')
ylabel('Frequency')
axis([amin-1 amax+1 0 max(a)*1.1])
hold on
mean_a = mean(a);
line([amin amax], [mean_a mean_a], 'color', 'r', 'LineWidth', 2)
hold off
print('../figures/exercise_1/frequency_a_with_mean.png', '-dpng')
close all

% --- Plot for B ---
bar(bmin:bmax, b)
title('Frequency Distribution of Matrix A')
xlabel('Value')
ylabel('Frequency')
axis([bmin-1 bmax+1 0 max(b)*1.1])
hold on
mean_b = mean(b);
line([bmin bmax], [mean_b mean_b], 'color', 'r', 'LineWidth', 2)
hold off
print('../figures/exercise_1/frequency_b_with_mean.png', '-dpng')
close all

% f.
% Generate probability distributions from the histograms using relative frequencies and plot
% them into Figure 3 (vector a) and 4 (vector b). Show that the probabilities in each
% distribution sum up to 1.
total = N^2;

% probability distribution for A
pa = a / total;
sum_pa = sum(pa)
 % probability distribution for B
pb = b / total;
sum_pb = sum(pb)

% --- Probability distribution for A ---
bar(amin:amax, pa)
title('Probability Distribution of Matrix A')
xlabel('Value')
ylabel('Probability')
axis([amin-1 amax+1 0 max(pa)*1.1])
print('../figures/exercise_1/probability_distribution_a.png', '-dpng')
close all

% --- Probability distribution for B ---
bar(bmin:bmax, pb)
title('Probability Distribution of Matrix B')
xlabel('Value')
ylabel('Probability')
axis([bmin-1 bmax+1 0 max(pb)*1.1])
print('../figures/exercise_1/probability_distribution_b.png', '-dpng')
close all

% g.
% The data in matrix B is normally distributed with mean value μ = 0 and standard deviation
% s = 10. Its probability in Figure 3 can be described by the following function:
%   (function)
% Draw this function as red line into Figure 4, using for the abscissa a stepsize of 0.1
% between the end points bmin and bmax.

x = bmin:0.1:bmax;

mu = 0
sigma = 10
probability_function = exp(-(x - mu).^2 / (2 * sigma^2)) / sqrt(2 * pi * sigma^2);

bar(bmin:bmax, pb)
hold on
plot(x, probability_function, 'r', 'LineWidth', 2)
title('Probability Distribution of Matrix B with Theoretical Normal Curve')
xlabel('Value')
ylabel('Probability')
axis([bmin-1 bmax+1 0 max([pb probability_function])*1.1])
hold off
print('../figures/exercise_1/probability_distribution_b_with_normal_curve.png', '-dpng')
close all

% h.
% Check the following statements in your program:
%   a. 68.3% of all elements in B lie in the interval [ -s, s]
%   b. 95.5% of all elements in B lie in the interval [ -2s, 2s]
%   c. 99.7% of all elements in B lie in the interval [ -3s, 3s].

% [-s, s]
count_1s = sum(B(:) >= -sigma & B(:) <= sigma);
percentage_1s = count_1s / (N^2)
% [-2s, 2s]
count_2s = sum(B(:) >= -2*sigma & B(:) <= 2*sigma);
percentage_2s = count_2s / (N^2)
% [-3s, 3s]
count_3s = sum(B(:) >= -3*sigma & B(:) <= 3*sigma);
percentage_3s = count_3s / (N^2)
