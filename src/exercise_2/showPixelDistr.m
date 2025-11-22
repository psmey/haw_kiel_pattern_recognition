function showPixelDistr(digit, matrix, row, column)
    assets_dir = './assets';
    image_dir = './figures/pixel_distribution';

    load([assets_dir '/digit' int2str(digit) '.mat']);

    pixel_index = sub2ind([28, 28], row, column);
    pixel_values = D(:,pixel_index);

    hist(pixel_values, 0:255);
    xlabel('Gray value');
    ylabel('Frequency');
    title(['Gray value distribution of pixel ' int2str(pixel_index) ' for digit ' int2str(digit)]);
    print([image_dir '/digit' int2str(digit) ...
        '_pixel_' int2str(pixel_index) ...
        '_r' int2str(row) '_c' int2str(column) ...
        '_gray_value_distribution.png'], '-dpng');

    highlightPixel(digit, matrix, row, column, image_dir);
end
