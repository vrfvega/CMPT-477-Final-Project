function edgeImage = directionalLaplacianEdge(inputImage, direction)
    if ~isempty(inputImage) && ndims(inputImage) == 3
        inputImage = rgb2gray(inputImage);
    end
    
    inputImage = double(inputImage);
    
    switch direction
        case 0
            filter = [1 1 1; 
                      0 0 0; 
                     -1 -1 -1];
        case 45
            filter = [0 1 1; 
                     -1 0 1; 
                     -1 -1 0];
        case 90
            filter = [ 1  0 -1; 
                       1  0 -1; 
                       1  0 -1];
        case 135
            filter = [ 1  1  0; 
                      -1  0  1; 
                       0 -1 -1];
        otherwise
            error('Direction must be 0, 45, 90, or 135 degrees');
    end
    
    paddedImage = padarray(inputImage, [1 1], 'replicate');
    
    edgeImage = zeros(size(inputImage));
    
    for i = 2:size(paddedImage, 1) - 1
        for j = 2:size(paddedImage, 2) - 1
            neighborhood = paddedImage(i-1:i+1, j-1:j+1);
            edgeResponse = sum(sum(neighborhood .* filter));
            edgeImage(i-1, j-1) = abs(edgeResponse);
        end
    end
    
    edgeImage = uint8(255 * (edgeImage - min(edgeImage(:))) / (max(edgeImage(:)) - min(edgeImage(:))));
end
