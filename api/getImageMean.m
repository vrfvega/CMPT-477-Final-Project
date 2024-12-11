function meanVal = getImageMean(imageArray)
    % Ensure the image array is of type double for accurate calculations
    imageArray = double(imageArray);

    % Calculate the mean
    meanVal = mean(imageArray(:));
end
