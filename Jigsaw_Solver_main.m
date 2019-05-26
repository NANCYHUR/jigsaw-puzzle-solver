%Now we start to fix the Jigsaw problem

%%Part 1 Processing the image;
% TODO shuffle the images later
all_images = uint8(zeros(36, 75, 133));
imagefiles = dir('processed image/*.png');
for ii=1:36
    current_file_name = ['processed image/', imagefiles(ii).name];
    current_image = imread(current_file_name);
    figure,imshow(current_image);
    current_image = rgb2gray(current_image);
    all_images(ii, :, :, :) = current_image;
    all_images(ii, :, :, :) = current_image;
end

%%Part 2 Using the Jigsaw solver;
img_first = squeeze(all_images(1, :, :));
all_images(1, :, :) = [];    % remove the chosen image
img_long_piece = img_first;     % to be constructed longer
while size(img_long_piece, 2) ~= 133*6
    left_dist = zeros(size(all_images, 1), 2);  % 2 edges for each 
    right_dist = zeros(size(all_images, 1), 2);
    left_vec = img_long_piece(:, 1);
    right_vec = flip(img_long_piece(:, size(img_long_piece, 2)), 2);
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
    left_dist_small = left_dist < 80;
    right_dist_small = right_dist < 80;
    [left_similar_r, left_similar_c] = find(left_dist_small);
    [right_similar_r, right_similar_c] = find(right_dist_small);
    % append the chosen images, use the first image similar in edge 
    % (only for now, we need to modify it later)
    if size(left_similar_r, 1) ~=0  % append some image to the left
        chosen_image = squeeze(all_images(left_similar_r(1,1), :, :));
        if left_similar_c(1,1) == 1    % the matching edge is in the left
            chosen_image = imrotate(chosen_image, 180);
        end
        img_long_piece = cat(2, chosen_image, img_long_piece);
    end
    if size(right_similar_r, 1) ~= 0  % append some image to the right
        chosen_image = squeeze(all_images(right_similar_r(1,1), :, :));
        if right_similar_c(1,1) == 2    % the matching edge is in the right
            chosen_image = imrotate(chosen_image, 180);
        end
        img_long_piece = cat(2, img_long_piece, chosen_image);
    end
end
figure;
imshow(img_long_piece);

%%Part 3 Printing the result;
% ---
% ---
% ---
% ---