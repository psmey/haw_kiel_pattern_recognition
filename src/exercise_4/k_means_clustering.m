function k_means_clustering(a)
    % --- Manual K-Means Clustering for Dataset a ---
    k = 3;                % Number of clusters (splits)
    iterations = 15;      % Number of iterations to reach convergence

    % 1. Initialization: Pick k random points from the data as starting centers
    rand_idx = randperm(size(a, 1), k);
    centers = a(rand_idx, :);

    % 2. Iterative Optimization Loop
    for iter = 1:iterations
        % Step A: Assignment Phase
        % Calculate Euclidean distance from every point to every center
        dist = zeros(size(a, 1), k);
        for i = 1:k
            % sum((point - center)^2)
            dist(:, i) = sum((a - centers(i, :)).^2, 2);
        end

        % Find the index of the closest center for each point
        [~, idx] = min(dist, [], 2);

        % Step B: Update Phase
        % Move centers to the mean position of their assigned points
        for i = 1:k
            if sum(idx == i) > 0  % Only update if the cluster is not empty
                centers(i, :) = mean(a(idx == i, :));
            end
        end
    end

    % 3. Visualization of the result
    figure(1);
    colors = lines(k); % Generate k distinct colors
    hold on;
    for i = 1:k
        % Plot points belonging to cluster i
        plot(a(idx == i, 1), a(idx == i, 2), '.', 'Color', colors(i, :), 'MarkerSize', 1);
    end

    % Plot the final cluster centers as large red X's
    plot(centers(:,1), centers(:,2), 'rx', 'MarkerSize', 12, 'LineWidth', 3);

    xlabel('x1'); ylabel('x2');
    title(['Manual K-Means Clustering (k=', num2str(k), ', ', num2str(iterations), ' iterations)']);
    grid on;

    filename = ['./figures/k_means_result_k', num2str(k), '.png'];
    print(filename, '-dpng');
    close all

    % --- NEW: Mixture Density Modeling ---
    % 4. Probability Grid Setup
    points = -2:0.1:15;
    [X1, X2] = meshgrid(points, points);
    X_grid = [X1(:), X2(:)];
    p_mixture = zeros(size(X1));

    % 5. Compute Gaussian for each cluster and sum them (Joint Probability)
    for i = 1:k
        cluster_data = a(idx == i, :);
        mu_k = centers(i, :);
        Sigma_k = cov(cluster_data);
        weight_k = size(cluster_data, 1) / size(a, 1); % Proportional weight

        % Multivariate Normal formula components
        X_centered = X_grid - mu_k;
        inv_Sigma = inv(Sigma_k);
        det_Sigma = det(Sigma_k);

        % Calculation of probability for this specific peak
        exponent = sum((X_centered * inv_Sigma) .* X_centered, 2);
        prob_k = exp(-0.5 * exponent) / (2 * pi * sqrt(det_Sigma));

        % Add the weighted cluster density to the total surface
        p_mixture = p_mixture + reshape(weight_k * prob_k, size(X1));
    end

    % 6. Visualization Phase 2: Mixture Density
    figure(2);
    % 2D Contour
    subplot(1, 2, 1);
    plot(a(:, 1), a(:, 2), '.', 'Color', [0.8 0.8 0.8], 'MarkerSize', 1); hold on;
    contour(X1, X2, p_mixture, 15);
    title('Mixture Density Contours');

    % 3D Mesh
    subplot(1, 2, 2);
    mesh(X1, X2, p_mixture);
    title(['3D Mesh: p(X) with k=', num2str(k)]);
    xlabel('x1'); ylabel('x2'); zlabel('p(x1, x2)');

    print(['./figures/mixture_density_k', num2str(k), '.png'], '-dpng');

end
