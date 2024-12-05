function filtered_image = rankOrderEVFilter(input_image, window_size)
    % Check if the input is grayscale or RGB
    [rows, cols, channels] = size(input_image);
    
    % Calculate standard deviation (EV) for the entire image
    ev = std(double(input_image(:)));
    
    % Padding size
    pad_size = floor(window_size / 2);
    
    % Preallocate the output image
    filtered_image = zeros(size(input_image), 'like', input_image);
    
    % Apply the filter to each channel independently
    for c = 1:channels
        % Pad the current channel
        padded_channel = padarray(input_image(:,:,c), [pad_size pad_size], 'symmetric');
        
        % Filter the channel
        for i = 1:rows
            for j = 1:cols
                % Extract the local window
                window = padded_channel(i:i+window_size-1, j:j+window_size-1);
                window_center = input_image(i, j, c); % Center pixel
                
                % Flatten the window and compute the EV set
                window = window(:);
                ev_set = window(abs(window - window_center) <= ev);
                
                % Use the mean of the EV set or fallback to the center pixel
                if isempty(ev_set)
                    filtered_image(i, j, c) = window_center;
                else
                    filtered_image(i, j, c) = mean(ev_set);
                end
            end
        end
    end
end
