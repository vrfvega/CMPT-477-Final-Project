function filtered_image = medianFilter(input_image, window_size)
    % Convert input image to double precision
    input_image = double(input_image);
    
    % Check if the input is grayscale or RGB
    [rows, cols, channels] = size(input_image);
    
    % Input validation for window size
    if mod(window_size, 2) == 0
        error('Window size must be odd');
    end
    
    % Padding size
    padding = (window_size - 1) / 2;
    
    % Preallocate the output image
    filtered_image = zeros(size(input_image));
    
    % Apply the median filter to each channel independently
    for c = 1:channels
        % Pad the current channel
        padded_channel = padarray(input_image(:,:,c), [padding padding], 'symmetric');
        
        % Filter the channel
        for i = 1:rows
            for j = 1:cols
                window = padded_channel(i:i+window_size-1, j:j+window_size-1);
                filtered_image(i, j, c) = median(window(:));
            end
        end
    end
    
    % Convert the filtered image back to the original data type
    filtered_image = cast(filtered_image, 'like', input_image);
end
