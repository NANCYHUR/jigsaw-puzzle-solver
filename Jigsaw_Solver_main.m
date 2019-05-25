%Now we start to fix the Jigsaw problem

%%Part 1 Processing the image;
% TODO shuffle the images later
all_images = uint8(zeros(36, 75, 133));
imagefiles = dir('processed image/*.png');
for ii=1:36
    current_file_name = ['processed image/', imagefiles(ii).name];
    current_image = imread(current_file_name);
    current_image = rgb2gray(current_image);
    all_images(ii, :, :, :) = current_image;
end

%%Part 2 Using the Jigsaw solver;


%%Part 3 Printing the result;
% ---
% ---
% ---
% ---