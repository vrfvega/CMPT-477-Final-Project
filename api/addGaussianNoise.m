function noisy_img = addGaussianNoise(img, noise_fraction)
    % Convert image to double
    img = double(img);
    
    % Calculate image standard deviation
    img_std = std(img(:));
    
    % Calculate noise standard deviation
    noise_std = noise_fraction * img_std;
    
    % Generate Gaussian noise
    noise = noise_std * randn(size(img));
    
    % Add noise to image
    noisy_img = img + noise;
    
    % Clip values to valid range [0, 255]
    noisy_img = max(0, min(255, noisy_img));
end