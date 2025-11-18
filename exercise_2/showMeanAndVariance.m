function showMeanAndVariance(digit)
    assets_dir = "./assets";
    image_dir = "./figures";

    load([assets_dir "/digit" int2str(digit) ".mat"]);

    sum_matrix = zeros(28, 28);

    for i = 1:size(D,1)
        I = D(i,:);
        I = reshape(I, [28,28]); % converts I to size to 28 x 28
        I = I'; % tranpose matrix (switching rows & columns)

        sum_matrix = sum_matrix + I;
    end

    mean_matrix = sum_matrix / size(D,1);

    imagesc(mean_matrix);
    print([image_dir "/mean/digit" int2str(digit) ".png"], "-dpng");

    difference_sum_matrix = zeros(28, 28);

    for i = 1:size(D,1)
        I = D(i,:);
        I = reshape(I, [28,28]);
        I = I';

        difference_matrix = I - mean_matrix;
        difference_sum_matrix = difference_sum_matrix + difference_matrix.^2;
    end

    variance_matrix = difference_sum_matrix / size(D,1)

    imagesc(variance_matrix);
    print([image_dir "/variance/digit" int2str(digit) ".png"], "-dpng");
end
