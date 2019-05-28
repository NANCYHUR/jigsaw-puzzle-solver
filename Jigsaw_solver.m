function whole_img = Jigsaw_solver(path, imagefiles, col_num, row_num, thresh_v, thresh_h)
% This function solves a simplified Jigsaw problem.
% It's the core function of this project.
%
% parameter: path, a string of file path
%            imagefiles, a struct containing all files info.
%            col_num, an integer describing how many pieces in each row
%            row_num, an integer describing how many pieces in each column
%                   --- col_num * row_num = size(imagefiles,1)
%            thresh_v, a double, to filter big distances of vertical edges
%            thresh_h, a double, to filter big distances of horizontal edges
%
% output: reassembled whole image, 
%               [width*sqrt(#pieces), height*sqrt(#pieces), channel(3)]

%% load all the images
first_file = [path, imagefiles(1).name];
first_img = imread(first_file);
size_r = size(first_img,1);
size_c = size(first_img,2);
all_images = uint8(zeros(size_r,size_c,3,36));
figure;     % display all small pieces
for ii=1:size(imagefiles,1)
    current_file_name = [path, imagefiles(ii).name];
    current_image = imread(current_file_name);
    subplot(row_num, col_num, ii), imshow(current_image);
    all_images( :, :, :, ii) = current_image;
end

%% TODO: suffle all the images (relocate)


%% TODO: rotate some of the images


%% concat into row_num long pieces
long_pieces = zeros(size_r, size_c*col_num, 3, row_num);
figure;     % display all long pieces
for n = 1:row_num
    img_first = squeeze(all_images(:, :, :,1));
    all_images(:, :, :,1) = [];    % remove the chosen image
    img_long_piece = img_first;     % to be constructed longer

    while size(img_long_piece, 2) < size_c*col_num
        dist = zeros(size(all_images, 4), 4);

        left_vec = squeeze(img_long_piece(:,1,:));
        right_vec = squeeze(img_long_piece(:, size(img_long_piece, 2),:));

        for i = 1:size(all_images, 4)
            vec_i_l = reshape((all_images(:, 1, :, i)), size_r, []);
            vec_i_r = reshape(all_images(:, size_c,:,i), size_r, []);
            left_dist_i_1 = M_plus_S(left_vec, flip(vec_i_l,2),1);
            left_dist_i_2 = M_plus_S(left_vec, vec_i_r,1);
            right_dist_i_1 = M_plus_S(right_vec, vec_i_l,1);
            right_dist_i_2 = M_plus_S(right_vec, flip(vec_i_r,2),1);
            dist(i, 1) = left_dist_i_1;
            dist(i, 2) = left_dist_i_2;
            dist(i, 3) = right_dist_i_1;
            dist(i, 4) = right_dist_i_2;
        end

        dist(dist>thresh_v) = NaN;
        dist(dist<=0) = NaN;
        if size(find(isnan(dist)),1)~=(size(dist,1)*size(dist,2))   % this matrix has valid values
            [mins, indices_r] = min(dist);
            [~, index_r] = min(mins);
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
    subplot(row_num,1,n), imshow(img_long_piece);
    long_pieces(:,:,:,n) = img_long_piece;
end

%% whole image
whole_img = squeeze(long_pieces(:,:,:,1));
while size(whole_img,1) < size_r*row_num
    dist = zeros(size(long_pieces, 4), 4);

    top_vec = squeeze(whole_img(1,:,:));
    bottom_vec = squeeze(whole_img(size(whole_img,1),:,:));
    
    for i = 1:size(long_pieces, 4)
        vec_i_t = squeeze(long_pieces(1,:,:,i));
        vec_i_b = squeeze(long_pieces(size(long_pieces,1),:,:,i));
        top_dist_i_t = M_plus_S(top_vec, flip(vec_i_t,2), 1);
        top_dist_i_b = M_plus_S(top_vec, vec_i_b, 1);
        bottom_dist_i_t = M_plus_S(bottom_vec, vec_i_t, 1);
        bottom_dist_i_b = M_plus_S(bottom_vec, flip(vec_i_b,2),1);
        dist(i, 1) = top_dist_i_t;
        dist(i, 2) = top_dist_i_b;
        dist(i, 3) = bottom_dist_i_t;
        dist(i, 4) = bottom_dist_i_b;
    end
    
    dist(dist>thresh_h) = NaN;
    dist(dist<=0) = NaN;
    if size(find(isnan(dist)),1)~=(size(dist,1)*size(dist,2))   % this matrix has valid values
        [mins, indices_r] = min(dist);
        [~, index_r] = min(mins);
        col_r = index_r;
        row_r = indices_r(index_r);
        if size(dist,1)==1
            row_r = 1;
            [~, col_r] = min(dist);
        end
        chosen_image = squeeze(long_pieces(:, :, :, row_r));
        long_pieces(:,:,:,row_r) = [];
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
figure, imshow(whole_img);


end

