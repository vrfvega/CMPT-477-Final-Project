% Rank Order ER (Median) Filtering Function with a 3x3 window
function filtered_image = rankOrderERFilter(noisy_image, er)
    % Get the dimensions of the noisy image
    [rows, cols] = size(noisy_image);
    
    % Pad the image with a 1-pixel border to handle edge pixels
    padded_image = padarray(noisy_image, [1, 1], 'symmetric');
    
    % Preallocate the filtered image
    filtered_image = zeros(size(noisy_image));
    
    % Iterate over each pixel in the image
    for i = 2:rows+1
        for j = 2:cols+1
            % Extract a 3x3 window centered at the current pixel
            window = padded_image(i-1:i+1, j-1:j+1);
            
            % Sort the pixels in the window in ascending order
            sorted_window = sort(window(:));
            
            % Get the center pixel value and its rank in the sorted window
            center_value = padded_image(i, j);
            center_rank = find(sorted_window == center_value, 1, 'first');
            
            % Determine the indices of pixels within the ER range
            rank_indices = find(abs((1:numel(sorted_window)) - center_rank) <= er);
            
            % Extract the pixels within the ER range
            er_set = sorted_window(rank_indices);
            
            % Calculate the median of the ER set and assign it to the output pixel
            filtered_value = median(er_set);
            filtered_image(i-1, j-1) = filtered_value;
        end
    end
end