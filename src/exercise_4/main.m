% Exercises Practice Sheet 4

load "./data/a.mat"
load "./data/x.mat"

plot(x(1:1000, 1), x(1:1000, 2), "r.")
hold on;
plot(x(1:1000, 1), x(1:1000, 2), "b.")

xlabel('x')
ylabel('y')
title('Data Overview')

print('./figures/data_overview.png', '-dpng')
close all

% Data set a
% Independent components

points = -2:0.1:15;

mean_1 = mean(x(:, 1))
mean_2 = mean(x(:, 2))
standard_deviation_1 = sqrt(var(x(:, 1)))
standard_deviation_2 = sqrt(var(x(:, 2)))

probability_1 = exp(-0.5 * ((points - mean_1) ./ standard_deviation_1) .^ 2) ./ (standard_deviation_1) * sqrt(2 * pi)
probability_2 = exp(-0.5 * ((points - mean_2) ./ standard_deviation_2) .^ 2) ./ (standard_deviation_2) * sqrt(2 * pi)

probability_1_2 = probability_1' * probability_2

subplot(2, 2, 1);
plot(x(1:end, 1), x(1:end, 2), ".")
hold on;
contour(points, points, probability_1_2)
xlabel("x1")
ylabel("x2")
title('2D with Independent Components')

subplot(2, 2, 3);
mesh(points, points, probability_1_2);
xlabel("x1")
ylabel("x2")
zlabel("p(x1, x2)")
title('3D with Independent Components')

% Dependent components
mu = [mean_1, mean_2];
covariances = cov(x);
[X1, X2] = meshgrid(points, points);
X_grid = [X1(:) X2(:)];

% 2. Calculate Dependent Probability Matrix
X_centered = X_grid - mu;
inv_cov = inv(covariances);
exponent = sum((X_centered * inv_cov) .* X_centered, 2);
prob_dep_vec = exp(-0.5 * exponent) / (2 * pi * sqrt(det(covariances)));
probability_dependent = reshape(prob_dep_vec, size(X1));

% 3. Plot Dependent results on the right side
subplot(2, 2, 2);
plot(x(:, 1), x(:, 2), ".");
hold on;
contour(points, points, probability_dependent);
xlabel("x1"); ylabel("x2");
title('2D with Dependent Components');

subplot(2, 2, 4);
mesh(points, points, probability_dependent);
xlabel("x1"); ylabel("x2"); zlabel("p(x1, x2)");
title('3D with Dependent Components');

print('./figures/data_x.png', '-dpng')
close all

k_means_clustering(x)
