%% load all the images
all_images = uint8(zeros(75,133,3,36));
imagefiles = dir('processed image/*.png');
for ii=1:36
    current_file_name = ['processed image/', imagefiles(ii).name];
    current_image = imread(current_file_name);
    all_images( :, :, :, ii) = current_image;
end

%% concat into 6 long pieces
img_first = squeeze(all_images(:, :, :,1));
% imshow(img_first);
all_images(:, :, :,1) = [];    % remove the chosen image
img_long_piece = img_first;     % to be constructed longer

while size(img_long_piece, 2) < 133*6
    left_dist = zeros(size(all_images, 4), 2);  % 2 edges for each 
    right_dist = zeros(size(all_images, 4), 2);
    
    left_vec = squeeze(img_long_piece(:,1,:));
    right_vec = squeeze(img_long_piece(:, size(img_long_piece, 2),:));
    
    for i = 1:size(all_images, 4)
        vec_i_l = reshape((all_images(:, 1, :, i)), 75, []);
        vec_i_r = reshape(all_images(:, 133,:,i), 75, []);
        if i == 11
            
        end
        left_dist_i_1 = M_plus_S(left_vec, flip(vec_i_l,2),1);
        left_dist_i_2 = M_plus_S(left_vec, vec_i_r,1);
        right_dist_i_1 = M_plus_S(right_vec, vec_i_l,1);
        right_dist_i_2 = M_plus_S(right_vec, flip(vec_i_r,2),1);
        left_dist(i, 1) = left_dist_i_1;
        left_dist(i, 2) = left_dist_i_2;
        right_dist(i, 1) = right_dist_i_1;
        right_dist(i, 2) = right_dist_i_2;
    end

    threshold = 100000000000;

    left_dist(left_dist>threshold) = NaN;
    left_dist(left_dist<=0) = NaN;
    if size(find(isnan(left_dist)),1)~=(size(left_dist,1)*size(left_dist,2))   % this matrix has valid values
        [mins, indices] = min(left_dist);
        [min_l, index] = min(mins);
        col = index;
        row = indices(index);
        chosen_image = squeeze(all_images(:, :, :, row));
        all_images(:,:,:,row) = [];
        right_dist(row,:) = [];
        if col == 1    % the matching edge is in the left
            chosen_image = imrotate(chosen_image, 180);
        end
        img_long_piece = cat(2, chosen_image, img_long_piece);
    end

    right_dist(right_dist>threshold) = NaN;
    right_dist(right_dist<=0) = NaN;
    if size(find(isnan(right_dist)),1)~=(size(right_dist,1)*size(right_dist,2))   % this matrix has valid values
        [mins_r, indices_r] = min(right_dist);
        [min_r, index_r] = min(mins_r);
        col_r = index_r;
        row_r = indices_r(index_r);
        chosen_image = squeeze(all_images(:, :, :, row_r));
        all_images(:,:,:,row_r) = [];
        if col_r == 2    % the matching edge is in the left
            chosen_image = imrotate(chosen_image, 180);
        end
        img_long_piece = cat(2, img_long_piece, chosen_image);
    end
end
imshow(img_long_piece);