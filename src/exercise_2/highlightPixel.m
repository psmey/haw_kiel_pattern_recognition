function highlightPixel(digit, matrix, row, column, image_dir)
    highlight_matrix = matrix * 0.75;
    highlight_matrix(row, column) = 255;

    pixel_index = sub2ind([28, 28], row, column);

    imagesc(highlight_matrix);
    title(['Highlight pixel ' int2str(pixel_index) ' in digit ' int2str(digit)]);

    print([image_dir '/digit' int2str(digit) ...
        '_pixel_' int2str(pixel_index) ...
        '_r' int2str(row) '_c' int2str(column) ...
        '_highlighted.png'], '-dpng');
end
