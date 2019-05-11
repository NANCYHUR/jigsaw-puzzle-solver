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
img_first = squeeze(all_images(1, :, :));
all_images(1, :, :) = [];    % remove the chosen image
img_long_piece = img_first;     % to be constructed longer
while size(img_long_piece) ~= 133*6
    left_dist = zeros(size(all_images, 1), 2);  % 2 edges for each 
    right_dist = zeros(size(all_images, 1), 2);
    left_vec = img_long_piece(:, 1);
    right_vec = flip(img_long_piece(:, 133), 2);
    for i = 1:size(all_images, 1)
        vec_i_1 = reshape((all_images(i, :, 1)), 75, []);
        vec_i_2 = flip(reshape(all_images(i, :, 133), 75, []), 2);
        left_dist_i_1 = distance(left_vec, vec_i_1);
        left_dist_i_2 = distance(left_vec, vec_i_2);
        right_dist_i_1 = distance(right_vec, vec_i_1);
        right_dist_i_2 = distance(right_vec, vec_i_2);
        left_dist(i, 1) = left_dist_i_1;
        left_dist(i, 2) = left_dist_i_2;
        right_dist(i, 1) = right_dist_i_1;
        right_dist(i, 2) = right_dist_i_2;
    end
    % filter out edges pairs with small distances
    left_dist_small = left_dist < 50;
    right_dist_small = right_dist < 50;
    
    break;
end


%%Part 3 Printing the result;
% ---
% ---
% ---
% ---