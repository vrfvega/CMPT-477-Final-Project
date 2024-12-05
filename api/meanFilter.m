function filtered_img = meanFilter(img, window_size)
    % Validate input
    if mod(window_size, 2) == 0
        error('Window size must be an odd integer');
    end

    % Convert the input image to double precision
    img = double(img);

    % Determine if the input is grayscale or RGB
    [rows, cols, channels] = size(img);
    filtered_img = zeros(size(img));

    % Padding size
    pad_size = floor(window_size / 2);

    % Process each channel independently
    for c = 1:channels
        % Pad the current channel
        padded_channel = padarray(img(:,:,c), [pad_size, pad_size], 'symmetric');
        
        % Apply the mean filter
        for i = 1:rows
            for j = 1:cols
                % Extract the neighborhood
                neighborhood = padded_channel(i:i+window_size-1, j:j+window_size-1);
                % Compute the mean of the neighborhood
                filtered_img(i, j, c) = mean(neighborhood(:));
            end
        end
    end

    % Convert the filtered image back to the original data type
    filtered_img = cast(filtered_img, 'like', img);
end
