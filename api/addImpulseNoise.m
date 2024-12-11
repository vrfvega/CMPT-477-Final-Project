function corrupted_image = addImpulseNoise(image, noise_type, corruption_rate)
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

        if strcmp(noise_type, 'random')
            % Random impulse noise: Assign random values in the range [0, 255]
            corrupted_pixel_value = randi([0, 255], 1, 1, channels);
            corrupted_image(r, c, :) = corrupted_pixel_value;
        elseif strcmp(noise_type, 'salt-and-pepper')
            % Salt-and-pepper noise: Assign either 0 (pepper) or 255 (salt) randomly
            if rand < 0.5
                corrupted_image(r, c, :) = 0;  % Pepper noise
            else
                corrupted_image(r, c, :) = 255; % Salt noise
            end
        else
            error('Unknown noise type. Use "random" or "salt-and-pepper".');
        end
    end
end
