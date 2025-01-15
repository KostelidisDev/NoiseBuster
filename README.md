# NoiseBuster

This MATLAB project performs a series of steps for the analysis and evaluation of denoising techniques.

# Description

This MATLAB project performs a series of steps for the analysis and evaluation of denoising techniques. The script performs the following steps:
* Reads an image and converts it to grayscale.
* Divides the image into four equal-sized segments.
* Applies noise to three of the four segments using different types of noise: Gaussian noise, salt-and-pepper noise, and a combination of both.
* Calculates the PSNR (Peak Signal-to-Noise Ratio) for each noisy segment in comparison to the original, “clean” image.
* Denoises the noisy segments using three filters: mean filter, median filter, and midpoint filter.
* Calculates the PSNR for each combination of filter and noise by comparing the denoised result to the original image.
* Selects the best result for each segment, i.e., the one with the highest PSNR after denoising.
* Merges the four segments (the three denoised ones and the untouched fourth segment) into a final image and displays it as the denoised version of the original image.


# Extra files
** The extra files are written in Greek Language.
* [PDF/Text](./assets/Ρ104%20-%20NoiseBuster.pdf)

# License

[MIT License](./LICENSE)

# Atrributes
The Demo.jpg image is from [Pixabay.com](https://pixabay.com/photos/cortina-dampezzo-mountain-italy-9307295/)

# Disclaimer

This project was conducted as part of the course Ρ104: Robotic Vision in the M.Sc. program in Robotics, offered by the
Department of Computer, Informatics and Telecommunications Engineering at the International Hellenic University.