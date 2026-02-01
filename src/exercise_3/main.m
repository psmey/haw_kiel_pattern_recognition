% Exercise 3

% Task 1

% meas
load "/workspaces/haw_kiel_pattern_recognition/src/exercise_3/data/iris_data.mat"
% species
load "/workspaces/haw_kiel_pattern_recognition/src/exercise_3/data/iris_species.mat"

% Check variables in the current scope
whos

% strcmp = String Comparison
is_setosa = strcmp(species, 'setosa');
is_versicolor = strcmp(species, 'versicolor');
is_virginica = strcmp(species, 'virginica');

setosa = meas(is_setosa, :);
versicolor = meas(is_versicolor, :);
virginica = meas(is_virginica, :);

% cat = concatenate
% cat(1, ...) stack them vertically (making a very long list).
% cat(2, ...) stack them horizontally (making a very wide list).
% cat(3, ...) creates depth.

iris_matrix = cat(3, setosa, versicolor, virginica);

% verify
iris_matrix(1:5, 1, 3)

% Task 2
iris_cell = cell(51, 5, 3)

observation_count = size(setosa, 1)
observation_names = strcat({'observation_'}, num2str((1:observation_count)'), '%d')

% repmat
% [1 1 3]
% 1 row
% 1 column
% 3 pages

% set observation names for first columns
iris_cell(2:end, 1, :) = repmat(observation_names, [1 1 3])

headings = {"SepalLength", "SepalWidth", "PetalLength", "PetalWidth"}
iris_cell(1, 2:end, :) = repmat(headings, [1 1 3])

iris_cell(2:end, 2:end, 1) = num2cell(setosa)
iris_cell(2:end, 2:end, 2) = num2cell(versicolor)
iris_cell(2:end, 2:end, 3) = num2cell(virginica)

iris_cell(1, 1, 1) = "Setosa"
iris_cell(1, 1, 2) = "Versicolor"
iris_cell(1, 1, 3) = "Virginica"

iris_cell(:)

% Task 3

print_cell(iris_cell)

% Task 4

setosa_data = reshape([iris_cell{2:end, 2:end, 1}], 50, 4)
versicolor_data = reshape([iris_cell{2:end, 2:end, 2}], 50, 4)
virginica_data = reshape([iris_cell{2:end, 2:end, 3}], 50, 4)

% verify
virginica_data(end-2:end, :)

% Task 5

versicolor_means = mean(versicolor)
versicolor_variances = var(versicolor)

versicolor_mean_variance = cell(3, 5)

versicolor_mean_variance(1, 2:end) = headings
versicolor_mean_variance(2, 1) = "mean"
versicolor_mean_variance(2, 2:end) = num2cell(versicolor_means)
versicolor_mean_variance(3, 1) = "variance"
versicolor_mean_variance(3, 2:end) = num2cell(versicolor_variances)

print_cell(versicolor_mean_variance)

% Task 6
figure(1)
hold on;
plot(setosa_data(:, 1), setosa_data(:, 2), 'bo')
plot(versicolor_data(:, 1), versicolor_data(:, 2), 'r*')
plot(virginica_data(:, 1), virginica_data(:, 2), 'gx')

xlabel('Sepal Length');
ylabel('Sepal Width');
title('Iris Sepal Analysis');

print('./figures/plot.png', '-dpng')
close all
