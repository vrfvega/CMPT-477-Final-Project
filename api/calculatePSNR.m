function psnr = calculatePSNR(alt, ref)
    % Check if the input images have the same size
    if ~isequal(size(alt), size(ref))
        error('Input images must have the same dimensions');
    end

    % Compute PSNR
    max_pixel = double(max(alt,[],'all'));
    psnr = -10 * log10(mse / max_pixel^2);
end
