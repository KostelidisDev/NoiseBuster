function [midpoint] = nb_midpoint( ...
    image, ...
    filter_neighbourhood, ...
    outer_elements)
    % Apply the midpoint filter
    % Inputs:
    %   - image: 2D int array
    %   - filter_neighbourhood: int array (default=[3 3])
    %   - outer_elements: int (default=0)
    % Output:
    %   - I_midpoint: 2D int array

    if nargin < 2
        filter_neighbourhood = [3 3];
    end
    
    if nargin < 3
        outer_elements = 0;
    end

    image = im2double(image);
    
    num_elements = filter_neighbourhood(1) * filter_neighbourhood(2);
    outer_elements_array = ones(filter_neighbourhood(1), filter_neighbourhood(2)) * outer_elements;

    max_image = ordfilt2(image, num_elements, ones(filter_neighbourhood), outer_elements_array);
    min_image = ordfilt2(image, 1, ones(filter_neighbourhood), outer_elements_array);
    
    midpoint = (max_image + min_image) ./ 2;

    midpoint = im2uint8(midpoint);
end
