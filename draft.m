%% load all the images
all_images = uint8(zeros(145,216,3,36));
imagefiles = dir('better_images/*.jpg');
for ii=1:36
    current_file_name = ['better_images/', imagefiles(ii).name];
    current_image = imread(current_file_name);
    if size(current_image,1) ~= 145 || size(current_image,2) ~= 216
        current_image = imresize(current_image,[145,216]);
        imwrite(current_image, current_file_name);
    end
    all_images( :, :, :, ii) = current_image;
end

%% concat into 6 long pieces
img_first = squeeze(all_images(:, :, :,1));
% imshow(img_first);
all_images(:, :, :,1) = [];    % remove the chosen image
img_long_piece = img_first;     % to be constructed longer

while size(img_long_piece, 2) < 216*6
    dist = zeros(size(all_images, 4), 4);
    
    left_vec = squeeze(img_long_piece(:,1,:));
    right_vec = squeeze(img_long_piece(:, size(img_long_piece, 2),:));
    
    for i = 1:size(all_images, 4)
        vec_i_l = reshape((all_images(:, 1, :, i)), 145, []);
        vec_i_r = reshape(all_images(:, 216,:,i), 145, []);
        left_dist_i_1 = M_plus_S(left_vec, flip(vec_i_l,2),1);
        left_dist_i_2 = M_plus_S(left_vec, vec_i_r,1);
        right_dist_i_1 = M_plus_S(right_vec, vec_i_l,1);
        right_dist_i_2 = M_plus_S(right_vec, flip(vec_i_r,2),1);
%         left_dist_i_1 = SSDfunction(left_vec, flip(vec_i_l,2));
%         left_dist_i_2 = SSDfunction(left_vec, vec_i_r);
%         right_dist_i_1 = SSDfunction(right_vec, vec_i_l);
%         right_dist_i_2 = SSDfunction(right_vec, flip(vec_i_r,2));
        dist(i, 1) = left_dist_i_1;
        dist(i, 2) = left_dist_i_2;
        dist(i, 3) = right_dist_i_1;
        dist(i, 4) = right_dist_i_2;
    end

    threshold = 100000000000;
%     threshold = 10000;
    dist(dist>threshold) = NaN;
    dist(dist<=0) = NaN;
    if size(find(isnan(dist)),1)~=(size(dist,1)*size(dist,2))   % this matrix has valid values
        [mins, indices_r] = min(dist);
        [min_val, index_r] = min(mins);
        col_r = index_r;
        row_r = indices_r(index_r);
        chosen_image = squeeze(all_images(:, :, :, row_r));
        all_images(:,:,:,row_r) = [];
        if col_r == 1 || col_r == 4    % LL or RR
            chosen_image = imrotate(chosen_image, 180);
        end
        if col_r == 1 || col_r == 2    % LL or LR
            img_long_piece = cat(2, chosen_image, img_long_piece);
        elseif col_r == 3 || col_r == 4 % RL or RR
            img_long_piece = cat(2, img_long_piece, chosen_image);
        end
    end
end
imshow(img_long_piece);