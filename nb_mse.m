function mse = nb_mse(reference, noisy)
    % Calculate the Mean Squared Error (MSE)
    % Inputs:
    %   - reference: 2D int array
    %   - noisy: 2D int array
    % Output:
    %   - mse: float
    
    if ~isequal(size(reference), size(noisy))
        error('Input arrays must have the same size.');
    end
    
    differences = (reference - noisy);
    squaredDifferences = differences.^2;
    mse = mean(squaredDifferences(:));
end