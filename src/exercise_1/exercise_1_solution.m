%Exercise 1
N = 100;

%Fix Rand value
rand("seed", 50);
randn("seed", 50);

% fix for A because the decimal value to go to nearest integer. Round for B because the decimal point value is important in Normal Distribution

% Generate a matrix that is uniformly distributed from interval [0,10)
A = fix(rand(N,N) * 10);

% Generate a matrix that is normally distributed with mean of 0 and standard diviation of 10
mu= 0;
std_B = 10;
B = round(mu + std_B * randn(N,N));

% calculate the min and max for A and B

amin = min(A(:));
amax = max(A(:));

bmin= min(B(:));
bmax= max(B(:));


% find frequency of each element in Matrix A
Afrequencies = [];
Bfrequencies = [];

% we get all the unique elements in Matrix A and then we linearize the matrix
unique_A = unique(A(:));
for elementA = unique_A'
  indices = find(A == elementA);
  frequency = length(indices);
  Afrequencies = [Afrequencies, frequency];
end

%disp("Frequency of each element in A:");
%disp(Afrequencies);

figure(1)
bar(unique(A), Afrequencies);
title('Frequency Distribution for Matrix A');
xlabel('Values');
ylabel('Frequency');
hold on;

mean_a = mean(A(:));

% Plot the mean as a horizontal line
line(xlim, [mean_a, mean_a], 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Labeling and title
title('Frequency Distribution for Matrix A with Mean Line');
xlabel('Values');
ylabel('Frequency');
legend('Frequency Distribution', 'Mean Line');


% find frequency of each element in Matrix B
Bfrequencies = [];

% we get all the unique elements in Matrix B and then we linearize the matrix
unique_B= unique(B(:));
for elementB = unique_B'
  indices = find(B == elementB);
  frequency = length(indices);
  Bfrequencies = [Bfrequencies, frequency];
end

%disp("Frequency of each element B");
%disp(Bfrequencies);

figure(2)
bar(unique(B), Bfrequencies);
title('Frequency Distribution for Matrix B');
xlabel('Values');
ylabel('Frequency');


% Calculate relative frequencies (probabilities)
prob_a = Afrequencies / sum(Afrequencies);
prob_b = Bfrequencies / sum(Bfrequencies);


% Figure 3: Probability distribution for Matrix A
figure(3);
bar(unique(A), prob_a);
title('Probability Distribution for Matrix A');
xlabel('Values');
ylabel('Probability');

% Figure 4: Probability distribution for Matrix B
figure(4);
bar(unique(B), prob_b);
title('Probability Distribution for Matrix B');
xlabel('Values');
ylabel('Probability');
hold on;

abscissa_values = bmin:0.1:bmax;

line(abscissa_values, interp1(unique(B(:)), prob_b, abscissa_values, 'linear', 'extrap'), 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Title and labels
title('Probability Distribution for Matrix B with Probability Function');
xlabel('Values');
ylabel('Probability');

% Check if probabilities sum up to 1
disp(['Sum of probabilities for matrix B: ', num2str(sum(prob_b))]);

lower_limit = mu - std_B;
upper_limit = mu + std_B;


 disp(['Interval [ -s, s]: [', num2str(lower_limit), ', ', num2str(upper_limit), ']']);


% Plot histogram for matrix B with the interval [ -s, s]
figure;
hist(B(:), 20); % Use 20 bins for the histogram
hold on;

% Plot vertical lines for the interval [ -s, s]
line([lower_limit, lower_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
line([upper_limit, upper_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Title and labels
title('Histogram for Matrix B with [ -s, s] Interval');
xlabel('Values');
ylabel('Frequency');

% 95.5% of all elements in B lie in the interval [ -2s, 2s]

lower_limit = 2 * (mu - std_B);
upper_limit =2  * (mu + std_B);

 disp(['Interval [ -s, s]: [', num2str(lower_limit), ', ', num2str(upper_limit), ']']);


% Plot histogram for matrix B with the interval [ -s, s]
figure;
hist(B(:), 20); % Use 20 bins for the histogram
hold on;

% Plot vertical lines for the interval [ -s, s]
line([lower_limit, lower_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
line([upper_limit, upper_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Title and labels
title('Histogram for Matrix B with [ -s, s] Interval');
xlabel('Values');
ylabel('Frequency');


% 99.7% of all elements in B lie in the interval [ -2s, 2s]

lower_limit = 3 * (mu - std_B);
upper_limit =3  * (mu + std_B);

 disp(['Interval [ -s, s]: [', num2str(lower_limit), ', ', num2str(upper_limit), ']']);


% Plot histogram for matrix B with the interval [ -s, s]
figure;
hist(B(:), 20); % Use 20 bins for the histogram
hold on;

% Plot vertical lines for the interval [ -s, s]
line([lower_limit, lower_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);
line([upper_limit, upper_limit], ylim, 'Color', 'red', 'LineStyle', '--', 'LineWidth', 2);

% Title and labels
title('Histogram for Matrix B with [ -s, s] Interval');
xlabel('Values');
ylabel('Frequency');

