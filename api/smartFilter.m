function filtered_img = smartFilter(input_image, kernel)
    % Check if the kernel is 3x3
    if ~isequal(size(kernel), [3, 3])
        error('Filter kernel must be a 3x3 matrix');
    end
    
    % Check if the input is grayscale or RGB
    [rows, cols, channels] = size(input_image);
    
    % Convert the input image to double for processing
    input_image = double(input_image);
    
    % Calculate global variance across all channels
    global_var = var(input_image(:));
    
    % Preallocate the output image
    filtered_img = zeros(size(input_image));
    
    % Pad the image
    padded_image = padarray(input_image, [1 1], 'symmetric');
    
    % Apply the smart filter to each channel independently
    for c = 1:channels
        for i = 1:rows
            for j = 1:cols
                % Extract the 3x3 neighborhood
                neighborhood = padded_image(i:i+2, j:j+2, c);
                
                % Apply the kernel to the neighborhood
                local_mean = sum(neighborhood(:) .* kernel(:)) / sum(kernel(:));
                
                % Calculate local variance
                local_var = var(neighborhood(:));
                
                % Calculate the blending weight
                k = local_var / (local_var + global_var);
                
                % Apply the smart filter
                filtered_img(i, j, c) = k * input_image(i, j, c) + (1 - k) * local_mean;
            end
        end
    end
    
    % Convert back to uint8
    filtered_img = uint8(filtered_img);
end
