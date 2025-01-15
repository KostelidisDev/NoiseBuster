function [denoised, psnr] = nb_denoise( ...
    image_name, ...
    reference, ...
    noisy ...
    )
    % Denoise using 3 methods and return the best result and the psnr
    % Inputs:
    %   - reference: 2D int array
    %   - noisy: 2D int array
    % Output:
    %   - denoised: 2D int array
    %   - psnr: float
    
    if ~isequal(size(reference), size(noisy))
        error('Input arrays must have the same size.');
    end

    filter_neighbourhood = [3 3];

    fprintf( ...
        "\tDenoising %s image using mean, median and midpoint filters...", ...
        image_name ...
    );
    
    mean_array=imfilter( ...
        noisy, ...
        fspecial('average', filter_neighbourhood), ...
        0 ...
    );
    mean_psnr = nb_psnr(reference,mean_array);
    

    median_array=medfilt2(noisy, filter_neighbourhood, 'zeros');
    median_psnr = nb_psnr(reference,median_array);
    
    midpoint_array=nb_midpoint(noisy, filter_neighbourhood, 0);
    midpoint_psnr = nb_psnr(reference,midpoint_array);

    max_psnr = max([mean_psnr median_psnr midpoint_psnr]);

    if mean_psnr == max_psnr
        denoised = mean_array;
        psnr = mean_psnr;
        best_method='mean';
    elseif median_psnr == max_psnr
        denoised = median_array;
        psnr = median_psnr;
        best_method='median';
    else
        denoised = midpoint_array;
        psnr = midpoint_psnr;
        best_method='midpoint';
    end

    fprintf(" Done\n")

    filter_psnr_pairs = {
        'Mean', mean_psnr;
        'Median', median_psnr;
        'Midpoint', midpoint_psnr;
    };
    filter_psnr_table = cell2table(filter_psnr_pairs, 'VariableNames', {'FilterName', 'PSNR'});
    sorted_filter_psnr_table = sortrows(filter_psnr_table, 'PSNR', 'ascend');
    for i = 1:height(sorted_filter_psnr_table)
        if i == 1
            fprintf('\t\t%s (%f) PSNR', sorted_filter_psnr_table.FilterName{i}, sorted_filter_psnr_table.PSNR(i));
        else
            fprintf(' < %s: (%f) PSNR', sorted_filter_psnr_table.FilterName{i}, sorted_filter_psnr_table.PSNR(i));
        end 
    end
    fprintf("\n")

    fprintf( ...
        "\t\tBest filter for this image is %s, with PSNR=%f\n", ...
        best_method, ...
        psnr ...
    );
end