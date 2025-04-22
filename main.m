%% Clear Workspace
close all;
clear;
clc;

%% User Configurable Variables
input_image_file = 'demo.cropped.png';
gauss_mean = 0;
gauss_variance = 0.005;
salt_and_peper_percent = 0.015;

%% Main Script
% Print script info
fprintf("********************************************************\n");
fprintf("NoiseBuster\n");
fprintf("Developed by Iordanis Kostelidis <iordkost@ihu.gr>\n");
fprintf("********************************************************\n");

% Load RGB image
fprintf("Loading %s image file as RGB... ", input_image_file);
rgb_input_image = imread(input_image_file);
fprintf("Done\n");

% Convert RGB to Grayscale image
fprintf("Converting %s image file as to grayscale on memory... ", input_image_file);
input_image = rgb2gray(rgb_input_image);
fprintf("Done\n");
clear input_image_file;
clear rgb_input_image;

% Calculate the coordinates for the four image parts
% (top_left, top_right, bottom_left, bottom_right)
[image_height, image_width, ~] = size(input_image);
image_height_middle = floor(image_height/2);
image_width_middle = floor(image_width/2);

top_left_x = 1:image_height_middle;
top_left_y = 1:image_width_middle;

top_right_x = 1:image_height_middle;
top_right_y = image_width_middle:image_width;

bottom_left_x = image_height_middle:image_height;
bottom_left_y = 1:image_width_middle;

bottom_right_x = image_height_middle:image_height;
bottom_right_y = image_width_middle:image_width;

clear image_height image_width;
clear image_height_middle image_width_middle;

% Create the four image parts
% (top_left, top_right, bottom_left, bottom_right)
image_top_left = input_image(top_left_x, top_left_y);
image_top_right = input_image(top_right_x, top_right_y);
image_bottom_left = input_image(bottom_left_x, bottom_left_y);
image_bottom_right = input_image(bottom_right_x, bottom_right_y);
clear top_left_x top_left_y;
clear top_right_x top_right_y;
clear bottom_left_x bottom_left_y;
clear bottom_right_x bottom_right_y;
clear input_image;

% Apply the noise
fprintf("Applying noise on image segments... ");
noise_image_top_left = imnoise( ...
    image_top_left, ...
    'gaussian', ...
    gauss_mean, ...
    gauss_variance ...
);

noise_image_top_right = imnoise( ...
    image_top_right, ...
    'salt & pepper', ...
    salt_and_peper_percent ...
);

noise_image_bottom_left = imnoise( ...
    image_bottom_left, ...
    'gaussian', ...
    gauss_mean, ...
    gauss_variance ...
);
noise_image_bottom_left = imnoise( ...
    noise_image_bottom_left, ...
    'salt & pepper', ...
    salt_and_peper_percent ...
);

clear gauss_mean gauss_variance salt_and_peper_percent;

% We don't apply any noise on bottom right segment
noise_image_bottom_right = image_bottom_right;
fprintf("Done\n");

% Calculate PSNR between original and noisy images
fprintf("Calculating PSNR between original and noisy images... ")
psnr_top_left = nb_psnr(noise_image_top_left, image_top_left);
psnr_top_right = nb_psnr(noise_image_top_right, image_top_right);
psnr_bottom_left = nb_psnr(noise_image_bottom_left, image_bottom_left);
psnr_bottom_right = nb_psnr(noise_image_bottom_right, image_bottom_right);
fprintf( ...
    "Done,\n\t TL=%f dB, TR=%f dB, BL=%f dB, BR=%f dB. The BR must be Inf (noisy and original are equal)\n", ...
    psnr_top_left, ...
    psnr_top_right, ...
    psnr_bottom_left, ...
    psnr_bottom_right ...
);
clear psnr_top_left psnr_top_right psnr_bottom_left psnr_bottom_right;

% Denoise
fprintf("Denoising images using three filters... \n")
[top_left_denoised, ~] = nb_denoise( ...
    'top left', ...
    image_top_left, ...
    noise_image_top_left ...
);
[top_right_denoised, ~] = nb_denoise( ...
    'top right', ...
    image_top_right, ...
    noise_image_top_right...
);
[bottom_left_denoised, ~] = nb_denoise( ...
    'bottom left', ...
    image_bottom_left, ...
    noise_image_bottom_left ...
);
clear image_top_left image_top_right image_bottom_left;
clear noise_image_top_left noise_image_top_right;
clear noise_image_bottom_left noise_image_bottom_right;

% We don't denoise the bottom right segment,
% because we didn't apply any noise.
% [bottom_right_denoised, ~] = nb_denoise( ...
%     'bottom right', ...
%     image_bottom_right, ...
%     noise_image_bottom_right ...
% );

denoised_image = [
 top_left_denoised top_right_denoised; 
 bottom_left_denoised image_bottom_right
];

clear top_left_denoised top_right_denoised;
clear bottom_left_denoised image_bottom_right;

imshow(denoised_image);
clear denoised_image;