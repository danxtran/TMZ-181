function output_gauss = gauss_blur(IMAGE_FILE)
    rgbImage = imread(IMAGE_FILE);
    output_gauss = imgaussfilt(rgbImage, 2, 'FilterSize', 7);
    montage({rgbImage, output_gauss});
    title('Original Image vs Guassian Image');
end