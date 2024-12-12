function result = sobel_edge_detection(image)
    % Define Sobel kernels for horizontal and vertical edges
    kernel_x = [-1 0 1; -2 0 2; -1 0 1];
    kernel_y = [-1 -2 -1; 0 0 0; 1 2 1];
    
    % Apply the filters using convolution
    grad_x = conv2(double(image), kernel_x, 'same');
    grad_y = conv2(double(image), kernel_y, 'same');
    
    % Calculate magnitude of gradients
    result = sqrt(grad_x.^2 + grad_y.^2);
end