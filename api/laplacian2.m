function result = laplacian1_edge_detection(image, direction)
    % Define Laplacian 1 kernels for upward and downward jumps
    if strcmp(direction, 'upward')
        kernel = [-1 -1 -1;
                  -1 8 -1;
                  -1 -1 -1];
    elseif strcmp(direction, 'downward')
        kernel = [1 1 1;
                  1 -8 1;
                  1 1 1];
    else
        error('Direction must be either "upward" or "downward"');
    end

    % Apply the filter using convolution, taking care of boundary effects
    result = conv2(double(image), kernel, 'same');
end