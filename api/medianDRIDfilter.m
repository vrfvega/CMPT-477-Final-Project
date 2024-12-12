function filtered_image = applyMedianFilterWithDRID(noisy_image)
    % Detect impulses using the Differential Rank Impulse Detector (DRID)
    impulse_mask = dridDetector(noisy_image);

    % Create a copy of the noisy image for filtering
    filtered_image = noisy_image;

    % Pad the image to handle edge pixels
    padded_image = padarray(noisy_image, [1, 1], 'symmetric');

    % Iterate over each pixel in the image
    [rows, cols] = size(noisy_image);
    for i = 2:rows+1
        for j = 2:cols+1
            % If the pixel is detected as an impulse
            if impulse_mask(i-1, j-1)
                % Extract a 3x3 window around the pixel
                window = padded_image(i-1:i+1, j-1:j+1);
                
                % Apply a median filter to the window and assign the result
                % to the corresponding pixel in the filtered image
                filtered_value = median(window(:));
                filtered_image(i-1, j-1) = filtered_value;
            end
        end
    end
end