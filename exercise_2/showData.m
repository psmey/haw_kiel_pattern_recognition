function showData(digit)
    assets_dir = "./assets";
    image_dir = "./figures";

    load([assets_dir "/digit" int2str(digit) ".mat"]);

    for i = 1:size(D,1)
        I = D(i,:);
        I = reshape(I, [28,28]); % converts I to size to 28 x 28
        figure(1);
        imagesc(I);
        print([image_dir "/digit" int2str(digit) ".png"], "-dpng");
        pause(0.1);
    end
end
