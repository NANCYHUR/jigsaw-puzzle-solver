function mgc = MGCfunction(vector_1, vector_2)
% MGCfunction: a function that computes the MGC dissimilarity between 2 vectors
% parameters:
% vector_1 - n*3 matrix containing single column/row with 3 channels
% vector_2 - same as above, the other column/row
%
% example call:
% img_piece_1 = imread(‘processed image/1.png’);
% img_piece_2 = imread(‘processed image/2.png’);
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

% compute the average color difference of each channel
color_diff_r_1 = sum(r_1(1:len-1)-r_1(2:len))/(len-1);
color_diff_g_1 = sum(g_1(1:len-1)-g_1(2:len))/(len-1);
color_diff_b_1 = sum(b_1(1:len-1)-b_1(2:len))/(len-1);
color_diff_r_2 = sum(r_2(1:len-1)-r_2(2:len))/(len-1);
color_diff_g_2 = sum(g_2(1:len-1)-g_2(2:len))/(len-1);
color_diff_b_2 = sum(b_2(1:len-1)-b_2(2:len))/(len-1);

% covariance matrices from average color differences


% color difference between one another
color_diff_r = r_2 - r_1;
color_diff_g = g_2 - g_1;
color_diff_b = b_2 - b_1;

%
