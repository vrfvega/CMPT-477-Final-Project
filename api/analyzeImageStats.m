function [minVal, maxVal, meanVal, stdDev, varVal, snrVal] = analyzeImageStats(imageArray)
    % Check if the input is a grayscale image
    if size(imageArray, 3) ~= 1
        error('Input must be a grayscale image.');
    end
    
    % Ensure the image array is of type double for accurate calculations
    imageArray = double(imageArray);
    
    % Calculate the minimum value
    minVal = min(imageArray(:));
    
    % Calculate the maximum value
    maxVal = max(imageArray(:));
    
    % Calculate the mean
    meanVal = mean(imageArray(:));
    
    % Calculate the standard deviation
    stdDev = std(imageArray(:));
    
    % Calculate the variance
    varVal = var(imageArray(:));
    
    % Calculate the Signal-to-Noise Ratio (SNR)
    signalPower = meanVal^2;     % Signal power is mean squared
    noisePower = stdDev^2;       % Noise power is the variance
    if noisePower == 0
        snrVal = Inf;            % If no noise, SNR is infinite
    else
        snrVal = 10 * log10(signalPower / noisePower);  % SNR in dB
    end
end
