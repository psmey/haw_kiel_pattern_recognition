function showPixelDistr(digit, pixel_index)
    assets_dir = './assets';
    image_dir = './figures';

    load([assets_dir '/digit' int2str(digit) '.mat']);

    pixel_values = D(:,pixel_index);

    hist(pixel_values, 0:255);
    xlabel('Gray value');
    ylabel('Frequency');
    title(['Gray value distribution of pixel ' int2str(pixel_index) ' for digit ' int2str(digit)]);
    print([image_dir "/gray_value_distribution_digit" int2str(digit) '_pixel_' int2str(pixel_index) ".png"], "-dpng");
end
