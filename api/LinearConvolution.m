function [results] = image_luminosity_convolution_filter(varargin)
    % Luminosity Channel Convolution Filter for Generic Image
    % Flexible kernel specification methods
    
    % Parse input arguments
    p = inputParser;
    addParameter(p, 'kernel_size', 3, @(x) isnumeric(x) && x > 0 && mod(x,2)==1);
    addParameter(p, 'kernel_file', '', @ischar);
    addParameter(p, 'kernel_weights', [], @isnumeric);
    addParameter(p, 'image_name', 'Image', @ischar);
    
    parse(p, varargin{:});
    
    % Extract parsed inputs
    kernel_size = p.Results.kernel_size;
    kernel_file = p.Results.kernel_file;
    kernel_weights = p.Results.kernel_weights;
    image_name = p.Results.image_name;
    
    % Construct full image filename with multiple possible extensions
    image_extensions = {'.tif', '.png', '.jpg', '.jpeg', '.bmp', '.gif'};
    full_image_path = '';
    
    for i = 1:length(image_extensions)
        potential_path = [image_name, image_extensions{i}];
        if exist(potential_path, 'file')
            full_image_path = potential_path;
            break;
        end
    end
    
    % Check if image was found
    if isempty(full_image_path)
        error('Unable to find image with name "%s" and common image extensions', image_name);
    end
    
    % Read the image
    try
        % Read the image (keeping original color)
        original_image = imread(full_image_path);
    catch ME
        error('Error reading image %s: %s', full_image_path, ME.message);
    end
    
    % Convert to double for processing
    original_image = im2double(original_image);
    
    % Kernel selection logic
    if ~isempty(kernel_file)
        % Load kernel from text file
        try
            kernel_weights = load(kernel_file);
            
            % Validate kernel is square
            if size(kernel_weights, 1) ~= size(kernel_weights, 2)
                error('Kernel from file must be a square matrix');
            end
            
            % Update kernel size based on loaded kernel
            kernel_size = size(kernel_weights, 1);
        catch ME
            error('Error loading kernel file: %s', ME.message);
        end
    elseif isempty(kernel_weights)
        % If no kernel specified, create default kernels
        kernel_weights = create_default_kernel(kernel_size);
    end
    
    % Convert to LAB color space
    lab_image = rgb2lab(original_image);
    
    % Extract luminosity channel (L channel in LAB)
    luminosity_channel = lab_image(:,:,1);
    
    % Prepare figure for visualization of luminosity processing
    figure('Name', 'Luminosity Channel Convolution', 'Position', [100, 100, 1500, 900]);
    
    % Store results for potential further analysis
    results = struct();
    
    % First subplot is the original luminosity channel
    subplot(2, 2, 1);
    imshow(luminosity_channel, []);
    title('Original Luminosity Channel');
    colorbar;
    
    % Apply convolution to luminosity channel
    convolved_luminosity = conv2(luminosity_channel, kernel_weights, 'same');
    
    % Store result
    results.custom_kernel = convolved_luminosity;
    
    % Display convolved luminosity
    subplot(2, 2, 2);
    imshow(convolved_luminosity, []);
    title('Custom Kernel Convolution');
    colorbar;
    
    % Visualize the kernel
    subplot(2, 2, 3);
    imagesc(kernel_weights);
    title('Applied Kernel');
    colorbar;
    
    % Reconstruct Color Image with Processed Luminosity
    % Create a new LAB image with modified luminosity
    modified_lab_image = lab_image;
    modified_lab_image(:,:,1) = convolved_luminosity;
    
    % Convert back to RGB
    reconstructed_image = lab2rgb(modified_lab_image);
    
    % Display reconstructed image
    subplot(2, 2, 4);
    imshow(reconstructed_image);
    title('Reconstructed Color Image');
    
    % Suptitle for overall figure
    sgtitle([num2str(kernel_size), 'x', num2str(kernel_size), ' Custom Kernel Convolution']);
    
    % Quantitative Analysis
    fprintf('%dx%d Luminosity Channel Convolution Analysis:\n', kernel_size, kernel_size);
    fprintf('Custom Kernel:\n');
    fprintf('  Mean Luminosity: %f\n', mean(convolved_luminosity(:)));
    fprintf('  Luminosity Standard Deviation: %f\n', std(convolved_luminosity(:)));
    fprintf('  Luminosity Range: [%f, %f]\n', min(convolved_luminosity(:)), max(convolved_luminosity(:)));
end

function kernel = create_default_kernel(kernel_size)
    % Create a default Gaussian kernel if no specific kernel is provided
    half_size = floor(kernel_size/2);
    [X, Y] = meshgrid(-half_size:half_size, -half_size:half_size);
    kernel = exp(-(X.^2 + Y.^2) / (2 * (kernel_size/6)^2));
    kernel = kernel / sum(kernel(:));
end

% Demonstration function
function run_demo()
    % Demonstrate different kernel specification methods
    
    % Method 1: Default 3x3 Gaussian kernel on default 'Image'
    image_luminosity_convolution_filter();
    
    % Method 2: Specify kernel size
    image_luminosity_convolution_filter('kernel_size', 5);
    
    % Method 3: Specify custom kernel weights directly
    custom_kernel = [0 -1 0; -1 5 -1; 0 -1 0];
    image_luminosity_convolution_filter('kernel_weights', custom_kernel);
    
    % Method 4: Specify different image name
    % Assumes you have an image named 'MyPicture.jpg' in the directory
    image_luminosity_convolution_filter('image_name', 'MyPicture');
    
    % Method 5: Load kernel from a text file (uncomment and replace with actual file path)
    % image_luminosity_convolution_filter('kernel_file', 'my_custom_kernel.txt');
end
