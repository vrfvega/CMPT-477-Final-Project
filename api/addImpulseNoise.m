function corrupted_image = addImpulseNoise(image, corruption_rate)
    % Get the dimensions of the image
    [rows, cols, channels] = size(image);

    % Create a copy of the image to corrupt
    corrupted_image = image;

    % Total number of pixels
    total_pixels = rows * cols;

    % Number of pixels to corrupt
    num_corrupted_pixels = round(corruption_rate * total_pixels);

    % Randomly select pixel indices to corrupt
    pixel_indices = randperm(total_pixels, num_corrupted_pixels);

    % Convert linear indices to row, col format
    [row_indices, col_indices] = ind2sub([rows, cols], pixel_indices);

    % Apply the noise
    for i = 1:num_corrupted_pixels
        r = row_indices(i);
        c = col_indices(i);

        % Random impulse noise: Assign random values in the range [0, 255]
        corrupted_pixel_value = randi([0, 255], 1, 1, channels);
        corrupted_image(r, c, :) = corrupted_pixel_value;
    end
end
