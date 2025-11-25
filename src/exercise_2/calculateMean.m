function mean_matrix = calculateMean(digit)
    sum_matrix = zeros(28, 28);

    load(["./assets/digit" int2str(digit) ".mat"]);

    for i = 1:size(D,1)
        matrix = D(i,:);
        matrix = reshape(matrix, [28,28]);
        matrix = matrix';

        sum_matrix = sum_matrix + matrix;
    end

    mean_matrix = sum_matrix / size(D,1);
end
