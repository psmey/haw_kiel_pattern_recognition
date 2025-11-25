function showCorrelation(digit, column, row)
    image_dir = "./figures/correlation";

    mean_matrix = calculateMean(digit);

    imagesc(mean_matrix);
    print([image_dir "/digit" int2str(digit) ".png"], "-dpng");

    highlightPixel(digit, mean_matrix, row, column, image_dir)
end
