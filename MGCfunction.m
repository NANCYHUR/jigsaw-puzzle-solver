function mgc = MGCfunction(vector_1, vector_2)
% MGCfunction: a function that computes the MGC dissimilarity between 2 vectors
% parameters:
% vector_1 - n*3 matrix containing single column/row with 3 channels
% vector_2 - same as above, the other column/row
%
% example call:
% img_piece_1 = imread('processed image/1.png');
% img_piece_2 = imread('processed image/2.png');
% mgc_1l_2l = MGCfunction(squeeze(img_piece_1(:,1,:)), squeeze(img_piece_2(:,1,:)));

% get length
len = size(vector_1, 1);

% extract r,g,b
r_1 = vector_1(:,1);
g_1 = vector_1(:,2);
b_1 = vector_1(:,3);
r_2 = vector_2(:,1);
g_2 = vector_2(:,2);
b_2 = vector_2(:,3);

% compute the (average) color difference of each channel
col_diff_r1 = r_1(1:len-1)-r_1(2:len);
col_diff_g1 = g_1(1:len-1)-g_1(2:len);
col_diff_b1 = b_1(1:len-1)-b_1(2:len);
col_diff_r2 = r_2(1:len-1)-r_2(2:len);
col_diff_g2 = g_2(1:len-1)-g_2(2:len);
col_diff_b2 = b_2(1:len-1)-b_2(2:len);
all_color_diff_avg = [sum(col_diff_r1), sum(col_diff_g1), sum(col_diff_b1), ...
    sum(col_diff_r2), sum(col_diff_g2), sum(col_diff_b2)]/(len-1);
all_color_diff_avg = double(all_color_diff_avg);
col_diff_1 = double([col_diff_r1, col_diff_g1, col_diff_b1]);
col_diff_2 = double([col_diff_r2, col_diff_g2, col_diff_b2]);

% covariance matrices from color differences
s1 = cov(col_diff_1);
s2 = cov(col_diff_2);

% color difference between one another
color_diff_r = r_2 - r_1;
color_diff_g = g_2 - g_1;
color_diff_b = b_2 - b_1;
G_12 = double([color_diff_r, color_diff_g, color_diff_b]);
G_21 = -G_12;

% dissimilarity score from (1 to 2) and (2 to 1)
D_12 = 0;
D_21 = 0;
for i = 1:len
    D_12 = D_12+(G_12(i,:)-all_color_diff_avg(1:3))/s1*(G_12(i,:)-all_color_diff_avg(1:3))';
    D_21 = D_21+(G_21(i,:)-all_color_diff_avg(4:6))/s2*(G_21(i,:)-all_color_diff_avg(4:6))';
end

% combine two scores to form MGC value
mgc = D_12 + D_21;

end
