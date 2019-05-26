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
six_pieces = zeros(145, 216*6, 3, 6);
for n = 1:6
    img_first = squeeze(all_images(:, :, :,1));
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
            dist(i, 1) = left_dist_i_1;
            dist(i, 2) = left_dist_i_2;
            dist(i, 3) = right_dist_i_1;
            dist(i, 4) = right_dist_i_2;
        end

        threshold = 100000000000;
        dist(dist>threshold) = NaN;
        dist(dist<=0) = NaN;
        if size(find(isnan(dist)),1)~=(size(dist,1)*size(dist,2))   % this matrix has valid values
            [mins, indices_r] = min(dist);
            [min_val, index_r] = min(mins);
            col_r = index_r;
            row_r = indices_r(index_r);
            if size(dist,1)==1
                row_r = 1;
                [~, col_r] = min(dist);
            end
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
    six_pieces(:,:,:,n) = img_long_piece;
%     figure;
%     imshow(img_long_piece);
end

%% whole image
whole_img = squeeze(six_pieces(:,:,:,1));
while size(whole_img,1) < 145*6
    dist = zeros(size(six_pieces, 4), 4);

    top_vec = squeeze(whole_img(1,:,:));
    bottom_vec = squeeze(whole_img(size(whole_img,1),:,:));
    
    for i = 1:size(six_pieces, 4)
        vec_i_t = squeeze(six_pieces(1,:,:,i));
        vec_i_b = squeeze(six_pieces(size(six_pieces,1),:,:,i));
        top_dist_i_t = M_plus_S(top_vec, flip(vec_i_t,2), 1);
        top_dist_i_b = M_plus_S(top_vec, vec_i_b, 1);
        bottom_dist_i_t = M_plus_S(bottom_vec, vec_i_t, 1);
        bottom_dist_i_b = M_plus_S(bottom_vec, flip(vec_i_b,2),1);
        dist(i, 1) = top_dist_i_t;
        dist(i, 2) = top_dist_i_b;
        dist(i, 3) = bottom_dist_i_t;
        dist(i, 4) = bottom_dist_i_b;
    end
    
    threshold = 1e+15;
    dist(dist>threshold) = NaN;
    dist(dist<=0) = NaN;
    if size(find(isnan(dist)),1)~=(size(dist,1)*size(dist,2))   % this matrix has valid values
        [mins, indices_r] = min(dist);
        [min_val, index_r] = min(mins);
        col_r = index_r;
        row_r = indices_r(index_r);
        if size(dist,1)==1
            row_r = 1;
            [~, col_r] = min(dist);
        end
        chosen_image = squeeze(six_pieces(:, :, :, row_r));
        six_pieces(:,:,:,row_r) = [];
        if col_r == 1 || col_r == 4    % TT or BB
            chosen_image = imrotate(chosen_image, 180);
        end
        if col_r == 1 || col_r == 2    % TT or TB
            whole_img = cat(1, chosen_image, whole_img);
        elseif col_r == 3 || col_r == 4 % BT or BB
            whole_img = cat(1, whole_img, chosen_image);
        end
    end
end

whole_img = uint8(whole_img);
imshow(whole_img);
