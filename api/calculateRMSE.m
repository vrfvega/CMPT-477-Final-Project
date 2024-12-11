function rmse = calculateRMSE(alt, ref)
    % Check if the input images have the same size
    if ~isequal(size(alt), size(ref))
        error('Input images must have the same dimensions');
    end
    
    % Compute the mean squared error (MSE)
    num_pixel = size(ref, 1)*size(ref, 2)*size(ref, 3);
    mse = sum((double(ref) - double(alt)).^2, 'all') / num_pixel;

    % Compute the root mean squared error (RMSE)
    rmse = sqrt(mse);
end
