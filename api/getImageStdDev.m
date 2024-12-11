function stdDev = getImageStdDev(imageArray)
    % Ensure the image array is of type double for accurate calculations
    imageArray = double(imageArray);
    
    % Calculate the standard deviation
    stdDev = std(imageArray(:));
end
