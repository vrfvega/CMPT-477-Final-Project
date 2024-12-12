function result = unsharp_masking(image, k)
    % Define the averaging kernel (3x3)
    avg_kernel = (1/9) * ones(3, 3);
    
    % Apply the averaging filter to get the blurred image
    blurred = conv2(double(image), avg_kernel, 'same');
    
    % Compute the mask
    mask = double(image) - blurred;
    
    % Apply unsharp masking
    result = double(image) + k * mask;
end