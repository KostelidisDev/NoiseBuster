function psnr = nb_psnr(reference, noisy, max_value)
    % Calculate the Peak Signal-to-Noise Ratio (PSNR)
    % Inputs:
    %   - reference: 2D int array
    %   - noisy: 2D int array
    %   - max_value: int (default=255)
    % Output:
    %   - psnr: float

    if ~isequal(size(reference), size(noisy))
        error('Input arrays must have the same size.');
    end

    if nargin < 3
        max_value = 255;
    end
    
    psnr = 10 * log10((max_value^2) / nb_mse(reference, noisy));
end