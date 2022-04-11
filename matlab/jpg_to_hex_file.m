% Generate 3D image of random pixels
% IMAGE_FILE = any file that is format .jpg
% OUTPUT 3 txt files, that are row ordered, 
function success = jpg_to_hex_file(IMAGE_FILE)
    rgbImage = imread(IMAGE_FILE);
    % Extract color channels.
    redChannel = rgbImage(:,:,1); % Red channel
    greenChannel = rgbImage(:,:,2); % Green channel
    blueChannel = rgbImage(:,:,3); % Blue channel

    fileID1 = fopen('image_r_channel.txt', 'w');
    fileID2 = fopen('image_g_channel.txt', 'w');
    fileID3 = fopen('image_b_channel.txt', 'w');

    fprintf(fileID1, '%02x\n', transpose(redChannel));
    fprintf(fileID2, '%02x\n', transpose(greenChannel));
    fprintf(fileID3, '%02x\n', transpose(blueChannel));
    success = 1;
    
end